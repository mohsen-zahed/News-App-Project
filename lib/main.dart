import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/data/models/banners_news_model.dart';
import 'package:news_app/features/data/models/business_news_model.dart';
import 'package:news_app/features/data/models/general_news_model.dart';
import 'package:news_app/features/data/models/technology_news_model.dart';
import 'package:news_app/features/data/models/wall_street_news_model.dart';
import 'package:news_app/features/screens/home_screens/home_screen/home_screen.dart';
import 'package:news_app/features/screens/initial_screens/onboarding_screen/onboarding_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/login_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/sign_up_screen.dart/sign_up_screen.dart';
import 'package:news_app/features/screens/initial_screens/splash_screen/splash_screen.dart';
import 'package:news_app/packages/connectivity_plus_package/connection_controller.dart';
import 'package:news_app/packages/hive_flutter_package/hive_flutter_package_constants.dart';
import 'package:news_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNoInternetListener();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BannersNewsModelAdapter());
  Hive.registerAdapter(BusinessNewsModelAdapter());
  Hive.registerAdapter(GeneralNewsModelAdapter());
  Hive.registerAdapter(TechnologyNewsModelAdapter());
  Hive.registerAdapter(WallStreetNewsModelAdapter());
  await Hive.openBox<BannersNewsModel>(bannersNewsModelBoxName);
  await Hive.openBox<BusinessNewsModel>(businessNewsModelBoxName);
  await Hive.openBox<GeneralNewsModel>(generalNewsModelBoxName);
  await Hive.openBox<TechnologyNewsModel>(technologyNewsModelBoxName);
  await Hive.openBox<WallStreetNewsModel>(wallStreetNewsModelBoxName);
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
        // SearchScreen.id: (context) => const SearchScreen(), //* MaterialPageRoute
        // AllNewsScreen.id: (context) => const AllNewsScreen(), //* MaterialPageRoute
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(), //* MaterialPageRoute
      },
      home: const SplashScreen(),
    );
  }
}
