import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../data/models/boarder_model.dart';
import '../../data/repositories/add_boarder_repository.dart';
import 'add_boarder_state.dart';

class AddBoarderController extends StateNotifier<AddBoarderState> {
  final AddBoarderRepository repository;

  AddBoarderController({required this.repository}) : super(AddBoarderState.initial());

  Future<void> addBoarder(Boarder boarder) async {
    state = state.copyWith(isLoading: true, failure: null, success: false, addedId: null);
    final Either<Failure, void> res = await repository.addBoarder(boarder);
    res.fold(
      (f) => state = state.copyWith(isLoading: false, failure: f, success: false),
      (_) => state = state.copyWith(isLoading: false, failure: null, success: true, addedId: boarder.id),
    );
  }

  void reset() {
    state = AddBoarderState.initial();
  }
}
