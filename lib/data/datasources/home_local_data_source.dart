import '../../data/models/boarder_model.dart';

abstract class HomeLocalDataSource {
  Future<List<Boarder>> getAllBoarders();
  Future<Boarder?> getBoarderById(String id);
  Future<void> addBoarder(Boarder boarder);
  Future<void> updateBoarder(Boarder boarder);
  Future<void> deleteBoarder(String id);
  Future<List<Boarder>> getBoardersForMonth(String yearMonth); // "YYYY-MM"
}
