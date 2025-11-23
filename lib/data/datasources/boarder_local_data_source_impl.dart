import 'package:hive/hive.dart';
import '../../models/boarder_model.dart';
import 'boarder_local_data_source.dart';

class BoarderLocalDataSourceImpl implements BoarderLocalDataSource {
  final Box<BoarderModel> _boardersBox;

  BoarderLocalDataSourceImpl(this._boardersBox);

  @override
  Future<List<BoarderModel>> getBoarders() async {
    return _boardersBox.values.toList();
  }

  @override
  Future<void> addBoarder(BoarderModel boarder) async {
    await _boardersBox.put(boarder.id, boarder);
  }
}