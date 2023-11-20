import 'package:flutter/material.dart';
import 'package:pod_player/home_screen.dart';
import 'package:pod_player/route_names.dart';
import 'package:pod_player/subscription_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        RouteNames.home: (context) => const HomeScreen(),
        RouteNames.sub: (context) => const Subscriptions(),
        // RouteNames.
      },
      initialRoute: RouteNames.sub,
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












