import '../../data/models/boarder_model.dart';

abstract class FeesLocalDataSource {
  Future<List<Fee>> getFeesForBoarder(String boarderId);
  Future<void> addFee(String boarderId, Fee fee);
  Future<void> updateFee(String boarderId, Fee fee);
  Future<void> deleteFee(String boarderId, String feeId);
}
