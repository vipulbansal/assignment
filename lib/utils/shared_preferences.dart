import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static Future<void> setStringList(
      String stringName, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(stringName, value);
  }

  static Future<List<String>> getStringList(String stringName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(stringName) ?? [];
  }

  static Future<void> setString(String stringName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(stringName, value);
  }

  static Future<String> getString(String stringName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(stringName) ?? "";
  }

  static Future<void> setBool(String stringName, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(stringName, value);
  }

  static Future<bool> getBool(String stringName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(stringName) ?? false;
  }

  static Future<void> setDouble(String stringName, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(stringName, value);
  }

  static Future<double> getDouble(String stringName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(stringName) ?? 0.0;
  }

  static Future<void> setInt(String stringName, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(stringName, value);
  }

  static Future<int> getInt(String stringName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(stringName) ?? 0;
  }

  static Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> checkKey(String stringName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(stringName);
  }

  static Future<bool> clearSpecific(String stringName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(stringName);
  }
}
