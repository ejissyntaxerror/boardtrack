import '../../data/models/boarder_model.dart';

abstract class AddBoarderLocalDataSource {
  /// Persist a new boarder (expects boarder.id to be set).
  Future<void> addBoarder(Boarder boarder);
}
