import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../models/boarder_model.dart';

abstract class BoarderRepository {
  Future<Either<Failure, List<BoarderModel>>> getBoarders();
  Future<Either<Failure, void>> addBoarder(BoarderModel boarder);
}