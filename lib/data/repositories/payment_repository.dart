import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> setPaymentStatus(String boarderId, String yearMonth, bool paid);
  Future<Either<Failure, PaymentRecord?>> getPaymentForMonth(String boarderId, String yearMonth);
  Future<Either<Failure, List<PaymentRecord>>> getPaymentHistory(String boarderId);
}
