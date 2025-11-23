import '../models/dashboard_summary_model.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardSummaryModel> getDashboardSummary();
  Future<void> saveDashboardSummary(DashboardSummaryModel summary);
}
