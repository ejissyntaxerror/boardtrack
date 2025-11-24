import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/boarder_model.dart';
import '../../core/failure.dart';
import '../../data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  final HomeRepository repository;

  HomeController({required this.repository}) : super(HomeState.initial());

  Future<void> loadAllBoarders() async {
    state = state.copyWith(isLoading: true, failure: null);
    final res = await repository.getAllBoarders();
    res.fold(
      (f) => state = state.copyWith(isLoading: false, failure: f),
      (list) => state = state.copyWith(isLoading: false, boarders: list, failure: null),
    );
  }

  Future<void> loadForMonth(String yearMonth) async {
    state = state.copyWith(isLoading: true, failure: null, month: yearMonth);
    final res = await repository.getBoardersForMonth(yearMonth);
    res.fold(
      (f) => state = state.copyWith(isLoading: false, failure: f),
      (list) => state = state.copyWith(isLoading: false, boarders: list, failure: null),
    );
  }

  Future<void> addBoarder(Boarder boarder) async {
    state = state.copyWith(isLoading: true, failure: null);
    final res = await repository.addBoarder(boarder);
    await res.fold(
      (f) async {
        state = state.copyWith(isLoading: false, failure: f);
      },
      (r) async {
        await loadAllBoarders();
      },
    );
  }

  Future<void> updateBoarder(Boarder boarder) async {
    state = state.copyWith(isLoading: true, failure: null);
    final res = await repository.updateBoarder(boarder);
    await res.fold(
      (f) async => state = state.copyWith(isLoading: false, failure: f),
      (r) async => await loadAllBoarders(),
    );
  }

  Future<void> deleteBoarder(String id) async {
    state = state.copyWith(isLoading: true, failure: null);
    final res = await repository.deleteBoarder(id);
    await res.fold(
      (f) async => state = state.copyWith(isLoading: false, failure: f),
      (r) async => await loadAllBoarders(),
    );
  }
}
