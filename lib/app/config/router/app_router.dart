import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/app/config/router/route_names.dart';
import 'package:pod_player/app/core/services/getit.dart';
import 'package:pod_player/data/providers/data_source/local/connectivity/connectivity_provider.dart';
import 'package:pod_player/domain/repositories/podcst/podcast_repository.dart';
import 'package:pod_player/domain/repositories/subscription/subscription_repository.dart';
import 'package:pod_player/presentation/blocs/home_cubit/home_cubti.dart';
import 'package:pod_player/presentation/blocs/subscription/subscriptions_bloc.dart';

import '../../../presentation/screens/screens.dart';

class ApplicationRouter {
  static Map<String, Widget Function(BuildContext)> router = {
    RouteNames.home: (context) => BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(
            connectivityProvider: locator<ConnectivityProvider>(),
            subRepository: locator<SubscriptionRepository>()),
        child: const HomeScreen()),
    RouteNames.sub: (context) => BlocProvider(
        create: (context)=>SubscriptionsBloc(
          podcastRepository: locator<PodcastRepository>(),
          subscriptionRepository: locator<SubscriptionRepository>()
        ),
        child: const Subscriptions()),
    RouteNames.splash: (context) => SplashScreen()
  };
}
