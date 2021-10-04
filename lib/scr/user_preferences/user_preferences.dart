import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences.internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences.internal();

  late SharedPreferences _prefs;

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  int get gender {
    return _prefs.getInt('gender') ?? 1;
  }

  set gender(int value) {
    _prefs.setInt('gender', value);
  }

  ///Get and Set
  bool get secondaryColors {
    return _prefs.getBool('secondaryColor') ?? false;
  }

  set secondaryColors(bool value) {
    _prefs.setBool('secondaryColor', value);
  }

  ///Get and Set
  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  ///Get and Set
  String get lastPage {
    return _prefs.getString('lastpage') ?? 'home';
  }

  set lastPage(String value) {
    _prefs.setString('lastpage', value);
  }
}