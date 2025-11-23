import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/monthly_summary_model.dart';

abstract class MonthlyRepository {
  Future<Either<Failure, MonthlySummary>> getMonthlySummary(String yearMonth, {bool allTime = false});
}
