import 'package:boardtrack/features/dashboard/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../models/dashboard_summary_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardSummaryModel>> getDashboardSummary();
  Future<Either<Failure, void>> saveDashboardSummary(DashboardSummaryModel summary);
}
