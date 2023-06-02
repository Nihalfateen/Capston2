import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  /// Inialize in [main] when app start
  ///
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Called when needed to store primitive data [String, int,double, bool]
  /// in app [SharedPreferences]
  ///
  static Future<bool> savePrefs(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }

    return await sharedPreferences.setBool(key, value);
  }

  /// Called when needed to retrieve primitve data like [String, int,double, bool]
  /// from app [SharedPreferences]
  ///
  static dynamic getPrefs({required String key}) {
    return sharedPreferences.get(key);
  }

  /// Called when needed to store [List] of [String] data
  /// in app [SharedPreferences]
  ///
  static dynamic savePrefsList(
      {required String key, required List<String> value}) {
    return sharedPreferences.setStringList(key, value);
  }

  /// Called when needed to retrieve [List] of [String] data
  /// in app [SharedPreferences]
  ///
  static List<String>? getPrefsList({required String key}) {
    return sharedPreferences.getStringList(key);
  }

  /// Removes an entry from [SharedPreferences] storage with key.
  /// Called   delete any value in [SharedPreferences] with key
  ///
  static Future<bool> clearPrefs({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  /// Completes with true once the user all data in  the app has been cleared.
  /// from [SharedPreferences] storage

  static Future<bool> clearAll() async {
    return await sharedPreferences.clear();
  }
}
