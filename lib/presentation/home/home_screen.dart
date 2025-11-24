import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/boarder_model.dart';
import 'home_providers.dart';
import 'add_boarder_screen.dart';
import 'monthly_summary_screen.dart';
import 'fees_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // load data after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeControllerProvider.notifier).loadAllBoarders();
    });
  }

  String _fmtYearMonthFromDate(DateTime dt) => '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);
    final controller = ref.read(homeControllerProvider.notifier);

    final month = state.month;
    // compute summary values based on current month selection
    double totalCollected = 0.0;
    double totalUnpaid = 0.0;
    int unpaidCount = 0;

    for (final b in state.boarders) {
      bool paid = false;
      // find payment for current month
      try {
        final p = b.payments.firstWhere((r) => r.month == month);
        paid = p.paid;
      } catch (_) {
        paid = false;
      }
      final feesThisMonth = b.fees.where((f) => '${f.createdAt.year.toString().padLeft(4, '0')}-${f.createdAt.month.toString().padLeft(2, '0')}' == month).toList();
      final feesTotal = feesThisMonth.fold<double>(0.0, (s, f) => s + f.amount);

      if (paid) totalCollected += b.rent;
      else {
        totalUnpaid += b.rent;
        unpaidCount += 1;
      }
      totalUnpaid += feesTotal; // include fees in unpaid totals
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BoardTrack', style: AppTextStyles.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadForMonth(month),
            tooltip: 'Refresh',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Month filter row
            Row(
              children: [
                Expanded(
                  child: Text('Month: $month', style: AppTextStyles.bodyLarge),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_today, size: 18),
                  label: const Text('Pick Month'),
                  onPressed: () async {
                    final now = DateTime.now();
                    final pick = await showDatePicker(
                      context: context,
                      initialDate: DateTime(now.year, now.month),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      helpText: 'Select month (day ignored)',
                    );
                    if (pick != null) {
                      final ym = _fmtYearMonthFromDate(pick);
                      controller.loadForMonth(ym);
                    }
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => controller.loadForMonth('all-time'),
                  child: const Text('All time'),
                )
              ],
            ),

            // Summary cards
            SizedBox(
              height: 110,
              child: Row(
                children: [
                  _SummaryCard(
                    title: 'Total Collected',
                    value: '\$${totalCollected.toStringAsFixed(2)}',
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  _SummaryCard(
                    title: 'Total Unpaid',
                    value: '\$${totalUnpaid.toStringAsFixed(2)}',
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 8),
                  _SummaryCard(
                    title: 'Unpaid Boarders',
                    value: unpaidCount.toString(),
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Boarder list
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: state.boarders.length,
                      itemBuilder: (context, idx) {
                        final b = state.boarders[idx];
                        bool paid = false;
                        try {
                          final p = b.payments.firstWhere((r) => r.month == month);
                          paid = p.paid;
                        } catch (_) {
                          paid = false;
                        }
                        final feesThisMonth = b.fees.where((f) => '${f.createdAt.year.toString().padLeft(4, '0')}-${f.createdAt.month.toString().padLeft(2, '0')}' == month).toList();
                        final feesTotal = feesThisMonth.fold<double>(0.0, (s, f) => s + f.amount);
                        final balance = (paid ? 0.0 : b.rent) + feesTotal;

                        return Card(
                          child: ListTile(
                            title: Text(b.name, style: AppTextStyles.title),
                            subtitle: Text('Room ${b.room} • \$${b.rent.toStringAsFixed(2)}', style: AppTextStyles.bodySmall),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(paid ? 'Paid' : 'Unpaid', style: TextStyle(color: paid ? Colors.green : Colors.red)),
                                Text('\$${balance.toStringAsFixed(2)}', style: AppTextStyles.bodySmall),
                              ],
                            ),
                            onTap: () {
                              // show actions: Monthly Summary or Additional Fees
                              showModalBottomSheet(
                                context: context,
                                builder: (ctx) => SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.summarize),
                                        title: const Text('Monthly Summary'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (_) => MonthlySummaryScreen(boarderId: b.id, month: month),
                                          ));
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.attach_money),
                                        title: const Text('Additional Fees'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (_) => FeesScreen(boarderId: b.id),
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddBoarderScreen()));
          // after returning, refresh list
          await controller.loadForMonth(state.month);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SummaryCard({Key? key, required this.title, required this.value, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.07),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.caption.copyWith(color: Colors.black54)),
            const Spacer(),
            Text(value, style: AppTextStyles.headline2.copyWith(color: color)),
          ]),
        ),
      ),
    );
  }
}
