import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferencesPackage {
  static MySharedPreferencesPackage? _instance;
  MySharedPreferencesPackage._();
  static MySharedPreferencesPackage get instance {
    _instance ??= MySharedPreferencesPackage._();
    return _instance!;
  }

  Future<bool> storeUserInfoAndRegistrationToLocale(String setInfoKey, dynamic setInfoValue, String setRegisteredKey, bool setRegisteredValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      print('$setInfoKey : $setInfoValue');
      print('$setRegisteredKey : $setRegisteredValue');
      final bool infoSaved = await sharedPreferences.setString(setInfoKey, setInfoValue);
      final bool registrationSaved = await sharedPreferences.setBool(setRegisteredKey, setRegisteredValue);
      if (infoSaved && registrationSaved) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> storeOnboardingStatusToLocale(String setOnboardingKey, bool setOnboardingValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      print('$setOnboardingKey : $setOnboardingValue');
      final onboardingSaved = await sharedPreferences.setBool(setOnboardingKey, setOnboardingValue);
      if (onboardingSaved) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> loadUserInfoFromLocale(String userInfoKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      return sharedPreferences.getString(userInfoKey);
    } catch (e) {
      return 'Something wrong happened';
    }
  }

  Future<bool> loadRegistrationStatusFromLocale(String userRegistrationStatusKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isExisted;
    try {
      isExisted = sharedPreferences.getBool(userRegistrationStatusKey)!;
      if (isExisted) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> loadOnboardingStatusFromLocale(String userOnboardingStatusKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isExisted;
    try {
      isExisted = sharedPreferences.getBool(userOnboardingStatusKey)!;
      if (isExisted) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
