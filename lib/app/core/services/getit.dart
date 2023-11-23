import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:pod_player/app/config/database/isar_run.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // isar instance
   locator.registerSingletonAsync<Isar>(() => initializeIsar());
}
