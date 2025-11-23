import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';
import '../datasources/add_boarder_local_data_source.dart';
import 'add_boarder_repository.dart';

class AddBoarderRepositoryImpl implements AddBoarderRepository {
  final AddBoarderLocalDataSource local;

  AddBoarderRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, void>> addBoarder(Boarder boarder) async {
    try {
      await local.addBoarder(boarder);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
