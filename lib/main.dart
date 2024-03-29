import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:pod_player/app/config/database/isar_run.dart';
import 'package:pod_player/app/config/router/app_router.dart';

import 'package:pod_player/app/config/router/route_names.dart';
import 'package:pod_player/app/core/services/getit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Decency injection
  Isar isar = await initializeIsar();
  await setupLocator(isar);
  await locator.allReady();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffF25135)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
    );
  }
}
