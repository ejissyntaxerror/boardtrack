import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/monthly_summary_model.dart';
import '../datasources/monthly_local_data_source.dart';
import 'monthly_repository.dart';

class MonthlyRepositoryImpl implements MonthlyRepository {
  final MonthlyLocalDataSource local;

  MonthlyRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, MonthlySummary>> getMonthlySummary(String yearMonth, {bool allTime = false}) async {
    try {
      final summary = await local.getMonthlySummary(yearMonth, allTime: allTime);
      return Right(summary);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
