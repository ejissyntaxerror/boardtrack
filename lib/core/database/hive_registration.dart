import 'package:hive/hive.dart';
import '../../models/boarder_model.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(BoarderModelAdapter());
}