import 'package:hive/hive.dart';
import '../../data/models/boarder_model.dart';
import 'home_local_data_source.dart';

class HomeHiveLocalDataSource implements HomeLocalDataSource {
  static const String boxName = 'boarders';

  Future<Box<Boarder>> _openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      throw Exception('Hive adapters not registered. Call registerHiveAdapters() before opening boxes.');
    }
    return await Hive.openBox<Boarder>(boxName);
  }

  @override
  Future<void> addBoarder(Boarder boarder) async {
    final box = await _openBox();
    await box.put(boarder.id, boarder);
  }

  @override
  Future<void> deleteBoarder(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  @override
  Future<List<Boarder>> getAllBoarders() async {
    final box = await _openBox();
    return box.values.toList(growable: false);
  }

  @override
  Future<Boarder?> getBoarderById(String id) async {
    final box = await _openBox();
    return box.get(id);
  }

  @override
  Future<List<Boarder>> getBoardersForMonth(String yearMonth) async {
    final box = await _openBox();
    final all = box.values.toList(growable: false);
    // return all boarders; caller/repository can compute paid/unpaid/fees per month
    return all;
  }

  @override
  Future<void> updateBoarder(Boarder boarder) async {
    final box = await _openBox();
    await box.put(boarder.id, boarder);
  }
}
