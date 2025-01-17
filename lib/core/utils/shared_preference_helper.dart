import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();
  static SharedPrefHelper sp = SharedPrefHelper._();
  SharedPreferences? prefs;
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString(String name, String value) async {
    await prefs!.setString(name, value);
  }

  String? getString(String key) {
    return prefs!.getString(key);
  }

  Future<void> setInt(String name, int value) async {
    await prefs!.setInt(name, value);
  }

  int? getInt(String key) {
    return prefs!.getInt(key);
  }

  Future<void> setBool(String name, bool value) async {
    await prefs!.setBool(name, value);
  }

  bool? getBool(String key) {
    return prefs!.getBool(key);
  }

  Future<bool> delete(String key) async {
    return await prefs!.remove(key);
  }
}