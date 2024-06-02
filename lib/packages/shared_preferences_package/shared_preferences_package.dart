import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferencesPackage {
  static MySharedPreferencesPackage? _instance;
  MySharedPreferencesPackage._();
  static MySharedPreferencesPackage get instance {
    _instance ??= MySharedPreferencesPackage._();
    return _instance!;
  }

  Future<bool> saveToSharedPreferences(String setStringKey, dynamic setStringValue, String setBookKey, bool setBoolValue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final bool stringSaved = await sharedPreferences.setString(setStringKey, setStringValue.toString());
      final bool boolSaved = await sharedPreferences.setBool(setBookKey, setBoolValue);
      if (stringSaved && boolSaved) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<dynamic> loadFromSharedPreferences(String getBoolKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isExisted;
    try {
      isExisted = sharedPreferences.getBool(getBoolKey)!;
      if (isExisted) {
        return sharedPreferences.getString(getBoolKey);
      } else {
        return 'Nothing found!';
      }
    } catch (e) {
      return 'Something wrong happened';
    }
  }

  Future<bool> checkExistAny(String getBoolKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isExisted;
    try {
      isExisted = sharedPreferences.getBool(getBoolKey)!;
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
