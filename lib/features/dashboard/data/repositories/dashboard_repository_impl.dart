import 'package:boardtrack/features/dashboard/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../datasources/dashboard_local_data_source.dart';
import '../models/dashboard_summary_model.dart';
import 'dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, DashboardSummaryModel>> getDashboardSummary() async {
    try {
      final result = await localDataSource.getDashboardSummary();
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load dashboard summary: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveDashboardSummary(
      DashboardSummaryModel summary) async {
    try {
      await localDataSource.saveDashboardSummary(summary);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to save dashboard summary: $e'));
    }
  }
}
