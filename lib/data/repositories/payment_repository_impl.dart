import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';
import '../datasources/payment_local_data_source.dart';
import 'payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentLocalDataSource local;

  PaymentRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, PaymentRecord?>> getPaymentForMonth(String boarderId, String yearMonth) async {
    try {
      final rec = await local.getPaymentForMonth(boarderId, yearMonth);
      return Right(rec);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PaymentRecord>>> getPaymentHistory(String boarderId) async {
    try {
      final list = await local.getPaymentHistory(boarderId);
      return Right(list);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setPaymentStatus(String boarderId, String yearMonth, bool paid) async {
    try {
      await local.setPaymentStatus(boarderId, yearMonth, paid);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
