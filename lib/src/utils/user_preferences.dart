import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get accessToken {
    return _prefs.getString('accessToken') ?? '';
  }

  set accessToken(String value) {
    _prefs.setString('accessToken', value);
  }

  get username {
    return _prefs.getString('username') ?? '';
  }

  set username(String value) {
    _prefs.setString('username', value);
  }

  get pocketToken {
    return _prefs.getString('pocketToken') ?? '';
  }

  set pocketToken(String value) {
    _prefs.setString('pocketToken', value);
  }

}