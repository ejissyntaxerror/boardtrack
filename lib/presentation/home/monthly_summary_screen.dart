import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/boarder_model.dart';
import 'home_providers.dart';

class MonthlySummaryScreen extends ConsumerWidget {
  final String boarderId;
  final String month;

  const MonthlySummaryScreen({Key? key, required this.boarderId, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final boarder = state.boarders.firstWhere((b) => b.id == boarderId, orElse: () => Boarder(id: '', name: 'Unknown', room: '-', rent: 0.0));
    final feesThisMonth = boarder.fees.where((f) => '${f.createdAt.year.toString().padLeft(4, '0')}-${f.createdAt.month.toString().padLeft(2, '0')}' == month).toList();
    bool paid = false;
    try {
      final p = boarder.payments.firstWhere((r) => r.month == month);
      paid = p.paid;
    } catch (_) {
      paid = false;
    }
    final feesTotal = feesThisMonth.fold<double>(0.0, (s, f) => s + f.amount);

    return Scaffold(
      appBar: AppBar(title: Text('Monthly Summary • $month')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(boarder.name, style: AppTextStyles.headline2),
          const SizedBox(height: 6),
          Text('Room ${boarder.room} • Rent \$${boarder.rent.toStringAsFixed(2)}', style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),
          Text('Status: ${paid ? 'Paid' : 'Unpaid'}', style: TextStyle(color: paid ? Colors.green : Colors.red)),
          const SizedBox(height: 12),
          Text('Additional fees this month', style: AppTextStyles.title),
          const SizedBox(height: 8),
          if (feesThisMonth.isEmpty) Text('No fees', style: AppTextStyles.bodySmall) else Expanded(
            child: ListView(
              children: feesThisMonth.map((f) => ListTile(
                title: Text(f.name),
                trailing: Text('\$${f.amount.toStringAsFixed(2)}'),
                subtitle: Text(f.createdAt.toIso8601String()),
              )).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Text('Fees total: \$${feesTotal.toStringAsFixed(2)}', style: AppTextStyles.title),
          const SizedBox(height: 8),
          Text('Balance: \$${((paid ? 0.0 : boarder.rent) + feesTotal).toStringAsFixed(2)}', style: AppTextStyles.headline2),
        ]),
      ),
    );
  }
}
