import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferencesPackage {
  static MySharedPreferencesPackage? _instance;
  MySharedPreferencesPackage._();
  static MySharedPreferencesPackage get instance {
    _instance ??= MySharedPreferencesPackage._();
    return _instance!;
  }

  Future<bool> storeUserInfoAndRegistrationToLocale(
      String setInfoKey, DocumentSnapshot setInfoValue, String setRegisteredKey, bool setRegisteredValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final Map<String, dynamic> userData = {
        'name': setInfoValue['name'],
        'email': setInfoValue['email'],
        'profileImage': setInfoValue['profileImage'],
        'id': setInfoValue['id'],
        'joinedAt': setInfoValue['joinedAt'],
        'password': setInfoValue['password'],
        'accountCreatedOn': setInfoValue['accountCreatedOn'].toString(),
      };
      final String userInfoJson = jsonEncode(userData);

      final bool infoSaved = await sharedPreferences.setString(setInfoKey, userInfoJson);
      final bool registrationSaved = await sharedPreferences.setBool(setRegisteredKey, setRegisteredValue);

      if (infoSaved && registrationSaved) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('store user: ${e.toString()}');
      return false;
    }
  }

  Future<bool> storeOnboardingStatusToLocale(String setOnboardingKey, bool setOnboardingValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
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
      return jsonDecode(sharedPreferences.getString(userInfoKey)!);
    } catch (e) {
      return 'Something wrong happened';
    }
  }

  Future<bool> loadRegistrationStatusFromLocale(String userRegistrationStatusKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isExisted;
    try {
      isExisted = sharedPreferences.getBool(userRegistrationStatusKey) ?? false;
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
      isExisted = sharedPreferences.getBool(userOnboardingStatusKey) ?? false;
      if (isExisted) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearSharedPreferences<T>() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }
}
