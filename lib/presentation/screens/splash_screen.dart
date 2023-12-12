import 'package:flutter/material.dart';
import 'package:pod_player/app/config/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;
  late Animation<double> _rotationAnimation;
  late AnimationController opacityController;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    rotationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _rotationAnimation =
        Tween(begin: 0.0, end: -1.0).animate(rotationController);
    rotationController.forward();
    super.initState();
    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushNamed(RouteNames.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: RotationTransition(
            turns: _rotationAnimation,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.podcasts,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'PodPlayer',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
