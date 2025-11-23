import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';

abstract class AddBoarderRepository {
  Future<Either<Failure, void>> addBoarder(Boarder boarder);
}
