import 'package:hive/hive.dart';
import '../../data/models/boarder_model.dart';
import '../../data/models/monthly_summary_model.dart';
import 'monthly_local_data_source.dart';

class MonthlyHiveLocalDataSource implements MonthlyLocalDataSource {
  static const String boxName = 'boarders';

  Future<Box<Boarder>> _openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      throw Exception('Hive adapters not registered. Call registerHiveAdapters() before opening boxes.');
    }
    return await Hive.openBox<Boarder>(boxName);
  }

  String _fmtYearMonth(DateTime dt) => '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}';

  @override
  Future<MonthlySummary> getMonthlySummary(String yearMonth, {bool allTime = false}) async {
    final box = await _openBox();
    final allBoarders = box.values.toList(growable: false);

    double totalCollected = 0.0;
    double totalUnpaid = 0.0;
    double totalFees = 0.0;
    int unpaidCount = 0;
    final List<BoarderMonthlySummary> rows = [];

    for (final b in allBoarders) {
      // compute fees relevant to this month (or all-time)
      final feesThisMonth = allTime
          ? b.fees
          : b.fees.where((f) => _fmtYearMonth(f.createdAt) == yearMonth).toList(growable: false);
      final feesTotal = feesThisMonth.fold<double>(0.0, (s, f) => s + f.amount);

      // find payment record for month
      PaymentRecord? p;
      if (!allTime) {
        try {
          p = b.payments.firstWhere((r) => r.month == yearMonth);
        } catch (_) {
          p = null;
        }
      }

      final paid = allTime ? false : (p?.paid ?? false);

      final collected = paid ? b.rent : 0.0;
      final unpaid = paid ? 0.0 : b.rent;

      if (!paid) unpaidCount += 1;
      totalCollected += collected;
      totalUnpaid += unpaid;
      totalFees += feesTotal;

      final balance = (paid ? 0.0 : b.rent) + feesTotal;

      rows.add(BoarderMonthlySummary(
        id: b.id,
        name: b.name,
        room: b.room,
        rent: b.rent,
        paid: paid,
        feesTotal: feesTotal,
        balance: balance,
      ));
    }

    final monthLabel = allTime ? 'all-time' : yearMonth;

    return MonthlySummary(
      month: monthLabel,
      totalCollected: totalCollected,
      totalUnpaid: totalUnpaid,
      unpaidCount: unpaidCount,
      totalFees: totalFees,
      boarderSummaries: rows,
    );
  }
}
