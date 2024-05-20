import 'package:flutter/material.dart';
import 'package:news_app_project/features/screens/initial_screens/onboarding_screen/onboarding_screen.dart';
import 'package:news_app_project/features/screens/initial_screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
