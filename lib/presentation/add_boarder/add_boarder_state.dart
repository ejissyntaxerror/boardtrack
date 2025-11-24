import 'package:flutter/foundation.dart';
import '../../core/failure.dart';

@immutable
class AddBoarderState {
  final bool isLoading;
  final Failure? failure;
  final bool success;
  final String? addedId;

  const AddBoarderState({
    required this.isLoading,
    this.failure,
    required this.success,
    this.addedId,
  });

  factory AddBoarderState.initial() => const AddBoarderState(isLoading: false, failure: null, success: false, addedId: null);

  AddBoarderState copyWith({
    bool? isLoading,
    Failure? failure,
    bool? success,
    String? addedId,
  }) {
    return AddBoarderState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      success: success ?? this.success,
      addedId: addedId ?? this.addedId,
    );
  }
}
