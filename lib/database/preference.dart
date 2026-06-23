import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static late SharedPreferences _preferences;
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const _keyLogin = 'isLogin';
  static Future<void> setLogin(bool, isLogin) async {
    await _preferences.setBool(_keyLogin, isLogin);
  }

  static bool get isLogin {
    return _preferences.getBool(_keyLogin) ?? false;
  }

  static Future<void> logOut() async {
    await _preferences.remove(_keyLogin);
  }
}
