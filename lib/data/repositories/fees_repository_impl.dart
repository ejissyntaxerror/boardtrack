import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';
import '../datasources/fees_local_data_source.dart';
import 'fees_repository.dart';

class FeesRepositoryImpl implements FeesRepository {
  final FeesLocalDataSource local;

  FeesRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, List<Fee>>> getFeesForBoarder(String boarderId) async {
    try {
      final fees = await local.getFeesForBoarder(boarderId);
      return Right(fees);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFee(String boarderId, Fee fee) async {
    try {
      await local.addFee(boarderId, fee);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFee(String boarderId, Fee fee) async {
    try {
      await local.updateFee(boarderId, fee);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFee(String boarderId, String feeId) async {
    try {
      await local.deleteFee(boarderId, feeId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
