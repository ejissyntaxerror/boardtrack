import '../../data/models/monthly_summary_model.dart';

abstract class MonthlyLocalDataSource {
  /// Compute monthly summary for `yearMonth` ("YYYY-MM"). If `allTime` true, compute over all records.
  Future<MonthlySummary> getMonthlySummary(String yearMonth, {bool allTime = false});
}
