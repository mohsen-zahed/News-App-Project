import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: kLightBackgroundColor,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: kLightPrimaryTextColor),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(color: kLightPrimaryTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: Theme.of(context).textTheme.titleMedium,
      unselectedLabelColor: kGreyColorShade500,
      unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: kDarkBackgroundColor,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: kDarkPrimaryTextColor),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(color: kDarkPrimaryTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: kWhiteColor),
      unselectedLabelColor: kGreyColorShade500,
      unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
    ),
  );
}
