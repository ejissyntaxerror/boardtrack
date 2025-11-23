import 'package:hive/hive.dart';
import '../../data/models/boarder_model.dart';
import 'payment_local_data_source.dart';

class PaymentHiveLocalDataSource implements PaymentLocalDataSource {
  static const String boxName = 'boarders';

  Future<Box<Boarder>> _openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      throw Exception('Hive adapters not registered. Call registerHiveAdapters() before opening boxes.');
    }
    return await Hive.openBox<Boarder>(boxName);
  }

  @override
  Future<PaymentRecord?> getPaymentForMonth(String boarderId, String yearMonth) async {
    final box = await _openBox();
    final boarder = box.get(boarderId);
    if (boarder == null) return null;
    for (final p in boarder.payments) {
      if (p.month == yearMonth) return p;
    }
    return null;
  }

  @override
  Future<List<PaymentRecord>> getPaymentHistory(String boarderId) async {
    final box = await _openBox();
    final boarder = box.get(boarderId);
    if (boarder == null) return <PaymentRecord>[];
    return List<PaymentRecord>.from(boarder.payments);
  }

  @override
  Future<void> setPaymentStatus(String boarderId, String yearMonth, bool paid) async {
    final box = await _openBox();
    final boarder = box.get(boarderId);
    if (boarder == null) throw Exception('Boarder not found: $boarderId');

    final payments = List<PaymentRecord>.from(boarder.payments);
    final idx = payments.indexWhere((p) => p.month == yearMonth);
    final now = DateTime.now();
    if (idx >= 0) {
      payments[idx] = PaymentRecord(month: yearMonth, paid: paid, updatedAt: now);
    } else {
      payments.add(PaymentRecord(month: yearMonth, paid: paid, updatedAt: now));
    }

    final updated = Boarder(
      id: boarder.id,
      name: boarder.name,
      room: boarder.room,
      rent: boarder.rent,
      fees: List<Fee>.from(boarder.fees),
      payments: payments,
      createdAt: boarder.createdAt,
    );

    await box.put(boarderId, updated);
  }
}
