import 'package:shared_preferences/shared_preferences.dart';

class UtilSharedPreferences {
  static Future<String> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('access_token') ?? '';
  }

  static Future setToken(String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('access_token', value);
  }
}
