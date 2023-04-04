import 'package:shared_preferences/shared_preferences.dart';

Future<void> setQuizNumberPreference(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

// To get a value from SharedPreferences
Future<String?> getQuizNumberPreference(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

// To remove a value from SharedPreferences
Future<void> removeQuizNumberPreference(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}