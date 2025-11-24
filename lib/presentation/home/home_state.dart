import 'package:flutter/foundation.dart';
import '../../data/models/boarder_model.dart';
import '../../core/failure.dart';

@immutable
class HomeState {
  final bool isLoading;
  final List<Boarder> boarders;
  final Failure? failure;
  final String month; // "YYYY-MM" or 'all-time'

  const HomeState({
    required this.isLoading,
    required this.boarders,
    this.failure,
    required this.month,
  });

  factory HomeState.initial() {
    final now = DateTime.now();
    final month = '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}';
    return HomeState(isLoading: false, boarders: const [], failure: null, month: month);
  }

  HomeState copyWith({
    bool? isLoading,
    List<Boarder>? boarders,
    Failure? failure,
    String? month,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      boarders: boarders ?? this.boarders,
      failure: failure,
      month: month ?? this.month,
    );
  }
}
