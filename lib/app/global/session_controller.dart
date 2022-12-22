import 'package:shared_preferences/shared_preferences.dart';

class SessionController {
  final SharedPreferences _preferences;
  late bool _isSignedIn;
  bool get isSignedIn => _isSignedIn;

  SessionController(this._preferences) {
    _isSignedIn = _preferences.getBool('session') ?? false;
  }

  void setSignedIn(bool value) {
    _isSignedIn = value;
    _preferences.setBool('session', value);
  }
}
