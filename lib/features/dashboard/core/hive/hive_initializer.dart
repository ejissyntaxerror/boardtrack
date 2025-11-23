import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';


Future<void> registerHiveAdapters() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(DashboardSummaryModelAdapter() as TypeAdapter);
}

class DashboardSummaryModelAdapter {
}

