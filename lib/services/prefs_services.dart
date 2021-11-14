import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Prefs instance = Prefs._();
  Prefs._();
  final String _userIDStorageKey = 'USER_ID';
  late String userID;

  Future<void> setUser(String userID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userIDStorageKey, userID);
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.get(_userIDStorageKey) as String;
  }
}
