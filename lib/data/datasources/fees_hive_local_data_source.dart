import 'package:hive/hive.dart';
import '../../data/models/boarder_model.dart';
import 'fees_local_data_source.dart';

class FeesHiveLocalDataSource implements FeesLocalDataSource {
  static const String boxName = 'boarders';

  Future<Box<Boarder>> _openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      throw Exception('Hive adapters not registered. Call registerHiveAdapters() before opening boxes.');
    }
    return await Hive.openBox<Boarder>(boxName);
  }

  @override
  Future<List<Fee>> getFeesForBoarder(String boarderId) async {
    final box = await _openBox();
    final boarder = box.get(boarderId);
    if (boarder == null) return <Fee>[];
    return List<Fee>.from(boarder.fees);
  }

  @override
  Future<void> addFee(String boarderId, Fee fee) async {
    final box = await _openBox();
    final boarder = box.get(boarderId);
    if (boarder == null) throw Exception('Boarder not found: $boarderId');
    final fees = List<Fee>.from(boarder.fees)..add(fee);
    final updated = Boarder(
      id: boarder.id,
      name: boarder.name,
      room: boarder.room,
      rent: boarder.rent,
      fees: fees,
      payments: List<PaymentRecord>.from(boarder.payments),
      createdAt: boarder.createdAt,
    );
    await box.put(boarderId, updated);
  }

  @override
  Future<void> updateFee(String boarderId, Fee fee) async {
    final box = await _openBox();
    final boarder = box.get(boarderId);
    if (boarder == null) throw Exception('Boarder not found: $boarderId');
    final fees = List<Fee>.from(boarder.fees);
    final idx = fees.indexWhere((f) => f.id == fee.id);
    if (idx < 0) throw Exception('Fee not found: ${fee.id}');
    fees[idx] = fee;
    final updated = Boarder(
      id: boarder.id,
      name: boarder.name,
      room: boarder.room,
      rent: boarder.rent,
      fees: fees,
      payments: List<PaymentRecord>.from(boarder.payments),
      createdAt: boarder.createdAt,
    );
    await box.put(boarderId, updated);
  }

  @override
  Future<void> deleteFee(String boarderId, String feeId) async {
    final box = await _openBox();
    final boarder = box.get(boarderId);
    if (boarder == null) throw Exception('Boarder not found: $boarderId');
    final fees = boarder.fees.where((f) => f.id != feeId).toList(growable: false);
    final updated = Boarder(
      id: boarder.id,
      name: boarder.name,
      room: boarder.room,
      rent: boarder.rent,
      fees: fees,
      payments: List<PaymentRecord>.from(boarder.payments),
      createdAt: boarder.createdAt,
    );
    await box.put(boarderId, updated);
  }
}
