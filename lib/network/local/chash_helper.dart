import 'package:shared_preferences/shared_preferences.dart';

class CashHelper
{
  static late SharedPreferences sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean(String key, bool value) async
  {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBoolean(String key)
  {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> putString(String key, String value) async
  {
    return await sharedPreferences.setString(key, value);
  }

  static String? getString(String key)
  {
    return sharedPreferences.getString(key);
  }
}