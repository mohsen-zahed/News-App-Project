import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app_project/features/screens/home_screens/home_screen/home_screen.dart';
import 'package:news_app_project/features/screens/initial_screens/onboarding_screen/onboarding_screen.dart';
import 'package:news_app_project/features/screens/initial_screens/splash_screen/splash_screen.dart';
import 'package:news_app_project/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('fa'),
        Locale('ps'),
      ],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('fa'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      themeMode: ThemeMode.system,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        // NewsDetailsScreen.id: (context) => const NewsDetailsScreen(), //* MaterialPageRoute
        // FullScreenImage.id: (context) => const FullScreenImage(), //* MaterialPageRoute
      },
      home: const HomeScreen(),
    );
  }
}
