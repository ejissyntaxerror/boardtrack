import 'package:hive/hive.dart';
import '../models/dashboard_summary_model.dart';
import 'dashboard_local_data_source.dart';

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final Box<DashboardSummaryModel> dashboardBox;

  DashboardLocalDataSourceImpl(this.dashboardBox);

  @override
  Future<DashboardSummaryModel> getDashboardSummary() async {
    if (dashboardBox.isNotEmpty) {
      return dashboardBox.getAt(0)!;
    }

    // return default empty summary if none exists
    return DashboardSummaryModel(
      totalRentCollected: 0.0,
      totalUnpaidRent: 0.0,
      unpaidBoarderCount: 0,
    );
  }

  @override
  Future<void> saveDashboardSummary(DashboardSummaryModel summary) async {
    if (dashboardBox.isEmpty) {
      await dashboardBox.add(summary);
    } else {
      await dashboardBox.putAt(0, summary);
    }
  }
}
