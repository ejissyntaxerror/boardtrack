import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';
import '../datasources/home_local_data_source.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource local;

  HomeRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, void>> addBoarder(Boarder boarder) async {
    try {
      await local.addBoarder(boarder);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBoarder(String id) async {
    try {
      await local.deleteBoarder(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Boarder>>> getAllBoarders() async {
    try {
      final data = await local.getAllBoarders();
      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Boarder?>> getBoarderById(String id) async {
    try {
      final b = await local.getBoarderById(id);
      return Right(b);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Boarder>>> getBoardersForMonth(String yearMonth) async {
    try {
      final data = await local.getBoardersForMonth(yearMonth);
      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBoarder(Boarder boarder) async {
    try {
      await local.updateBoarder(boarder);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
