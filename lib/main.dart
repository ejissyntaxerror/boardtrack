import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'core/database/hive_registration.dart';
import 'data/datasources/boarder_local_data_source_impl.dart';
import 'data/repositories/boarder_repository_impl.dart';
import 'screens/boarder_list_screen.dart';
import 'theme.dart';
import 'models/boarder_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerHiveAdapters();

  // Dependency Injection
  final boardersBox = await Hive.openBox<BoarderModel>('boarders');
  GetIt.I.registerSingleton<BoarderLocalDataSourceImpl>(
    BoarderLocalDataSourceImpl(boardersBox),
  );
  GetIt.I.registerSingleton<BoarderRepositoryImpl>(
    BoarderRepositoryImpl(GetIt.I<BoarderLocalDataSourceImpl>()),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoardTrack',
      theme: appTheme,
      home: const BoarderListScreen(),
    );
  }
}