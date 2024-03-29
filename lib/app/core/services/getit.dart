import 'package:audio_service/audio_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:pod_player/data/providers/data_source/local/audio_service/audio_service.dart';
import 'package:pod_player/data/providers/data_source/local/connectivity/connectivity_provider.dart';
import 'package:pod_player/data/providers/data_source/remote/downloade/downloader_service.dart';
import 'package:pod_player/data/providers/data_source/local/podcast_provider/podcast_provider.dart';
import 'package:pod_player/data/providers/data_source/local/subscriptions/subscription_provider.dart';
import 'package:pod_player/data/repositories/download/download_episode_repository_impl.dart';
import 'package:pod_player/data/repositories/podcast/podcast_repository_impl.dart';
import 'package:pod_player/data/repositories/subscriptions/subscription_repository_impl.dart';
import 'package:pod_player/domain/repositories/download/download_episode_repository.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';
import 'package:pod_player/presentation/blocs/player/player_controller.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator(Isar isar) async {
  // dio instance
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(followRedirects: true)));
  locator
      .registerSingleton<DownloaderService>(DownloaderService(locator<Dio>()));

  // isar instance
  locator.registerSingleton<Isar>(isar);
  // handler class registration
  locator.registerSingleton<MyAudioHandler>(MyAudioHandler());
  // audio player
  locator.registerSingleton(await initAudioServices());
  // register episode repository
  locator.registerSingleton<DownloadEpisodeRepository>(
    DownloadEpisodeRepositoryImpl(
      downloadService: locator<DownloaderService>(),
    ),
  );

  /// player controller
  locator.registerSingleton<PlayerController>(
      PlayerController(locator<MyAudioHandler>()));
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
