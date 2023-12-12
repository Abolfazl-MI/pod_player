import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:pod_player/data/providers/data_source/local/connectivity/connectivity_provider.dart';
import 'package:pod_player/data/providers/data_source/local/podcast_provider/podcast_provider.dart';
import 'package:pod_player/data/providers/data_source/local/subscriptions/subscription_provider.dart';
import 'package:pod_player/data/repositories/podcast/podcast_repository_impl.dart';
import 'package:pod_player/data/repositories/subscriptions/subscription_repository_impl.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
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
  locator.registerSingleton<ConnectivityProvider>(
      ConnectivityProvider(locator<Connectivity>()));
// initialize the podcast provider
  locator.registerSingleton<PodcastProvider>(PodcastProvider());
  // intialize podcast repository
  locator.registerSingleton<PodcastRepository>(
      PodcastRepositoryImpl(locator<PodcastProvider>()));
}
