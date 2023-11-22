import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static Future<void> addPrefs(Map<String, dynamic> preferences) async {
    final prefs = await SharedPreferences.getInstance();
    preferences.forEach((key, value) {
      if (value.runtimeType == int) {
        prefs.setInt(key, value);
      } else if (value.runtimeType == bool) {
        prefs.setBool(key, value);
      } else if (value.runtimeType == double) {
        prefs.setDouble(key, value);
      } else if (value.runtimeType == String) {
        prefs.setString(key, value);
      } else if (value.runtimeType == List) {
        prefs.setStringList(key, value);
      }
    });
  }

  static getAny(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
