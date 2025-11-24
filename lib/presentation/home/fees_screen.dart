import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/boarder_model.dart';
import 'home_providers.dart';

class FeesScreen extends ConsumerWidget {
  final String boarderId;

  const FeesScreen({Key? key, required this.boarderId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final controller = ref.read(homeControllerProvider.notifier);
    final boarder = state.boarders.firstWhere((b) => b.id == boarderId, orElse: () => Boarder(id: '', name: 'Unknown', room: '-', rent: 0.0));
    final fees = boarder.fees;

    return Scaffold(
      appBar: AppBar(title: Text('Fees • ${boarder.name}')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          if (fees.isEmpty) Text('No fees', style: AppTextStyles.bodySmall),
          if (fees.isNotEmpty) Expanded(
            child: ListView.builder(
              itemCount: fees.length,
              itemBuilder: (ctx, i) {
                final f = fees[i];
                return Card(
                  child: ListTile(
                    title: Text(f.name),
                    subtitle: Text(f.createdAt.toIso8601String()),
                    trailing: Text('\$${f.amount.toStringAsFixed(2)}'),
                    onTap: () {
                      // placeholder for edit/delete actions
                      showModalBottomSheet(context: context, builder: (_) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
                        ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text('Delete fee'),
                          onTap: () async {
                            Navigator.of(context).pop();
                            // perform delete by mutating boarder and updating via controller
                            final newFees = boarder.fees.where((x) => x.id != f.id).toList();
                            final updated = Boarder(
                              id: boarder.id,
                              name: boarder.name,
                              room: boarder.room,
                              rent: boarder.rent,
                              fees: newFees,
                              payments: List<PaymentRecord>.from(boarder.payments),
                              createdAt: boarder.createdAt,
                            );
                            await controller.updateBoarder(updated);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.cancel),
                          title: const Text('Cancel'),
                          onTap: () => Navigator.of(context).pop(),
                        )
                      ])));
                    },
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
