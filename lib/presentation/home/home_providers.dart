import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/home_hive_local_data_source.dart';
import '../../data/datasources/home_local_data_source.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/home_repository_impl.dart';
import 'home_controller.dart';
import 'home_state.dart';

// Data source provider (Hive implementation)
final homeLocalDataSourceProvider = Provider<HomeLocalDataSource>((ref) {
  return HomeHiveLocalDataSource();
});

// Repository provider (uses interface but supplies implementation)
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final local = ref.read(homeLocalDataSourceProvider);
  return HomeRepositoryImpl(local: local);
});

// Controller provider (StateNotifier) depends on repository interface
final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  final repo = ref.read(homeRepositoryProvider);
  return HomeController(repository: repo);
});
