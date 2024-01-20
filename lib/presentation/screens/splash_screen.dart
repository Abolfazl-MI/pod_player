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
    super.initState();
    _navigate();
  }

  _navigate() async {
    await Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(RouteNames.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image(
                  image: AssetImage('assets/icons/appicon.png'),
                ),
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
    );
  }
}
