import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/screens/home_screens/home_screen/home_screen.dart';
import 'package:news_app/features/screens/initial_screens/onboarding_screen/onboarding_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/login_screen.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_constants.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_package.dart';
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
      () async {
        await MySharedPreferencesPackage.instance.checkExistAny(hasSeenOnboarding).then((value) {
          if (value) {
            MySharedPreferencesPackage.instance.checkExistAny(isUserRegistered).then((value) {
              value
                  ? Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false)
                  : Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
            });
          } else {
            Navigator.pushNamedAndRemoveUntil(context, OnboardingScreen.id, (route) => false);
          }
        });
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
