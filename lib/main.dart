import 'package:boardtrack/features/dashboard/core/hive/hive_initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerHiveAdapters();


  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  get appTheme => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoardTrack',
      theme: appTheme,
      home: const Scaffold(
        body: Center(child: Text('Boarder List')),
      ),
    );
  }
}

class BoarderListScreen {
  const BoarderListScreen();
}


