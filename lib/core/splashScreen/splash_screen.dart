import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:devti_agro/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
          splash: Center(
            child: Lottie.asset("assets/icon/spl.json"),
          ),
          nextScreen: const MyApp(),
          animationDuration: const Duration(seconds: 3),
          backgroundColor: const Color.fromARGB(188, 76, 175, 79),
          splashIconSize: 500,
        ),
      );
  }
}
