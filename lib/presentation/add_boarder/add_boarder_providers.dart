import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/add_boarder_hive_local_data_source.dart';
import '../../data/datasources/add_boarder_local_data_source.dart';
import '../../data/repositories/add_boarder_repository.dart';
import '../../data/repositories/add_boarder_repository_impl.dart';
import 'add_boarder_controller.dart';
import 'add_boarder_state.dart';

// Data source provider (Hive implementation)
final addBoarderLocalDataSourceProvider = Provider<AddBoarderLocalDataSource>((ref) {
  return AddBoarderHiveLocalDataSource();
});

// Repository provider (interface -> implementation)
final addBoarderRepositoryProvider = Provider<AddBoarderRepository>((ref) {
  final local = ref.read(addBoarderLocalDataSourceProvider);
  return AddBoarderRepositoryImpl(local: local);
});

// Controller provider (StateNotifier) depends on repository interface
final addBoarderControllerProvider = StateNotifierProvider<AddBoarderController, AddBoarderState>((ref) {
  final repo = ref.read(addBoarderRepositoryProvider);
  return AddBoarderController(repository: repo);
});
