import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:pod_player/app/config/database/isar_run.dart';
import 'package:pod_player/data/providers/data_source/local/connectivity/connectivity_provider.dart';
import 'package:pod_player/data/providers/data_source/local/subscriptions/subscription_provider.dart';
import 'package:pod_player/data/repositories/subscriptions/subscription_repository_impl.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator(Isar isar) async {
  // isar instance
  locator.registerSingleton<Isar>(isar);
  //  initialize sub provider
  locator.registerSingleton<SubscriptionProvider>(
      SubscriptionProvider(locator<Isar>()));
  // initialize sub repository
  locator.registerSingleton<SubscriptionRepository>(
      SubscriptionRepositoryImpl(locator<SubscriptionProvider>()));
  // initialize connectivity instance
  locator.registerSingleton<Connectivity>(Connectivity());
  // initialize connectivity provider
  locator.registerSingleton(ConnectivityProvider(locator<Connectivity>()));
}
