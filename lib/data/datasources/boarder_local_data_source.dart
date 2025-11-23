import '../../models/boarder_model.dart';

abstract class BoarderLocalDataSource {
  Future<List<BoarderModel>> getBoarders();
  Future<void> addBoarder(BoarderModel boarder);
}