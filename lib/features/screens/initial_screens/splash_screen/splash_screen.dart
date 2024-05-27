import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/screens/initial_screens/onboarding_screen/onboarding_screen.dart';
import 'package:news_app/utils/my_media_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamed(context, OnboardingScreen.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: getMediaQueryWidth(context),
        height: getMediaQueryHeight(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashScreenBackgroundPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(getMediaQueryHeight(context, 0.15)),
            child: Image.asset(
              lightAppLogoPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
