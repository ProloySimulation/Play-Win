import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUserIdPreferences(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

// To get a value from SharedPreferences
Future<String?> getUserIdPreferences(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

// To remove a value from SharedPreferences
Future<void> removeUserIdPreferences(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}