import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: kLightBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kWhiteColor,
      surfaceTintColor: kWhiteColor,
      actionsIconTheme: IconThemeData(color: kBlackColor),
    ),
    brightness: Brightness.light,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: kLightPrimaryTextColor),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(color: kBlackColor),
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
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: kGreyColorShade500),
    ),
    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    dialogTheme: DialogTheme(
      backgroundColor: kLightBackgroundColor,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: kLightPrimaryTextColor),
      contentTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: kLightPrimaryTextColor),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(kLightPrimaryTextColor),
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.titleSmall!.copyWith(color: kLightPrimaryTextColor),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: kWhiteColor,
      elevation: 0.3,
      shadowColor: kBlackColorOp3,
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: kDarkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kDarkBackgroundColor,
      surfaceTintColor: kDarkBackgroundColor,
      iconTheme: IconThemeData(color: kWhiteColor),
    ),
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.w900, color: kDarkPrimaryTextColor),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(color: kWhiteColor),
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
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: kGreyColorShade500),
    ),
    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    dialogTheme: DialogTheme(
      backgroundColor: kDarkBackgroundColor,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(color: kDarkPrimaryTextColor),
      contentTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkPrimaryTextColor),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(kDarkPrimaryTextColor),
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkPrimaryTextColor),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: kDarkBackgroundColor,
      elevation: 0.3,
      shadowColor: kWhiteColorOp3,
    ),
  );
}
