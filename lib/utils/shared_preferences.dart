import 'package:shared_preferences/shared_preferences.dart';

class UtilSharedPreferences {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  static Future<bool> setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', value);
  }

  static Future<bool> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('access_token');
  }
}
