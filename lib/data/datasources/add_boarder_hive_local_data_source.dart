import 'package:hive/hive.dart';
import '../../data/models/boarder_model.dart';
import 'add_boarder_local_data_source.dart';

class AddBoarderHiveLocalDataSource implements AddBoarderLocalDataSource {
  static const String boxName = 'boarders';

  Future<Box<Boarder>> _openBox() async {
    // Ensure adapters registered centrally before calling this data source.
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
}
