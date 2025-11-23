import 'package:hive/hive.dart';
import '../data/models/boarder_model.dart';

void registerHiveAdapters() {
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(BoarderAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(FeeAdapter());
  if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(PaymentRecordAdapter());
}
