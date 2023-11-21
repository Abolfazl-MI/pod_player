

import 'package:flutter/material.dart';
import 'package:pod_player/app/config/router/route_names.dart';

import '../../../presentation/screens/screens.dart';


class ApplicationRouter {
  static Map<String, Widget Function(BuildContext)> router = {
     RouteNames.home: (context) => const HomeScreen(),
        RouteNames.sub: (context) => const Subscriptions(),
        RouteNames.splash:(context)=>SplashScreen()
  };
}
