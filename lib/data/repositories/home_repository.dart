import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Boarder>>> getAllBoarders();
  Future<Either<Failure, Boarder?>> getBoarderById(String id);
  Future<Either<Failure, void>> addBoarder(Boarder boarder);
  Future<Either<Failure, void>> updateBoarder(Boarder boarder);
  Future<Either<Failure, void>> deleteBoarder(String id);
  Future<Either<Failure, List<Boarder>>> getBoardersForMonth(String yearMonth);
}
