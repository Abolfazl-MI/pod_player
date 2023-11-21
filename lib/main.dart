import 'package:flutter/material.dart';
import 'package:pod_player/app/config/router/app_router.dart';

import 'package:pod_player/app/config/router/route_names.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: ApplicationRouter.router,
      initialRoute: RouteNames.splash,
      darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
    );
  }
}












