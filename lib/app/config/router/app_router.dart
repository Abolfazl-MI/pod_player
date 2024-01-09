import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/config/router/route_names.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/data/providers/data_source/local/audio_service/audio_service.dart';
import 'package:pod_player/data/providers/data_source/local/audio_service/audio_service.dart';
import 'package:pod_player/data/providers/data_source/local/connectivity/connectivity_provider.dart';
import 'package:pod_player/domain/entities/single_podcast/single_podcast_entity.dart';
import 'package:pod_player/domain/repositories/download/download_episode_repository.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';
import 'package:pod_player/presentation/blocs/home_cubit/home_cubti.dart';
import 'package:pod_player/presentation/blocs/podcast_single/single_podcast_bloc.dart';
import 'package:pod_player/presentation/blocs/search/search_podcast_bloc.dart';
import 'package:pod_player/presentation/blocs/subscribe/subscription_cubit.dart';
import 'package:pod_player/presentation/screens/player_screen.dart';
import 'package:pod_player/presentation/screens/podcast_single.dart';

import '../../../presentation/screens/screens.dart';

class ApplicationRouter {
  static Map<String, Widget Function(BuildContext)> router = {
    RouteNames.home: (context) => BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(
            connectivityProvider: locator<ConnectivityProvider>(),
            subRepository: locator<SubscriptionRepository>()),
        child: const HomeScreen()),
    RouteNames.sub: (context) => BlocProvider(
        create: (context) => SearchPodcastBloc(
            podcastRepository: locator<PodcastRepository>(),
            subscriptionRepository: locator<SubscriptionRepository>()),
        child: const Subscriptions()),
    RouteNames.splash: (context) => const SplashScreen(),
    RouteNames.podcastSingleInfo: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<SubscriptionCubit>(
              create: (context) => SubscriptionCubit(
                subRepository: locator<SubscriptionRepository>(),
              ),
            ),
            BlocProvider<SinglePodcastBloc>(
              create: (context) => SinglePodcastBloc(
                  subscriptionRepository: locator<SubscriptionRepository>(),
                  podcastRepository: locator<PodcastRepository>(),
                  audioHandler: locator<MyAudioHandler>(),
                  downloadEpisodeRepository:
                      locator<DownloadEpisodeRepository>()),
            )
          ],
          child: const SinglePodInfoScreen(),
        ),
    RouteNames.podcastSingle: (context) => BlocProvider(
          create: (context) => SinglePodcastBloc(
              subscriptionRepository: locator<SubscriptionRepository>(),
              podcastRepository: locator<PodcastRepository>(),
              audioHandler: locator<MyAudioHandler>(),
              downloadEpisodeRepository: locator<DownloadEpisodeRepository>()),
          child: PodcastSingleScreen(),
        ),
    RouteNames.playerScreen: (context) => PlayerScreen()
  };
}
