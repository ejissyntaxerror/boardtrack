import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../data/datasources/boarder_local_data_source.dart';
import '../../models/boarder_model.dart';
import 'boarder_repository.dart';

class BoarderRepositoryImpl implements BoarderRepository {
  final BoarderLocalDataSource dataSource;

  BoarderRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<BoarderModel>>> getBoarders() async {
    try {
      final boarders = await dataSource.getBoarders();
      return Right(boarders);
    } catch (e) {
      return Left(DatabaseFailure('Failed to retrieve boarders: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> addBoarder(BoarderModel boarder) async {
    try {
      await dataSource.addBoarder(boarder);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add boarder: ${e.toString()}'));
    }
  }
}