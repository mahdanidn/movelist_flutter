import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();
}
