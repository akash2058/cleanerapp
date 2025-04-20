import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginSession(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('token', token); // optional
}


Future<void> clearLoginSession() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
