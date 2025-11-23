import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';

abstract class FeesRepository {
  Future<Either<Failure, List<Fee>>> getFeesForBoarder(String boarderId);
  Future<Either<Failure, void>> addFee(String boarderId, Fee fee);
  Future<Either<Failure, void>> updateFee(String boarderId, Fee fee);
  Future<Either<Failure, void>> deleteFee(String boarderId, String feeId);
}
