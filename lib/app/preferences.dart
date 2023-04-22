import 'package:shared_preferences/shared_preferences.dart';

// NOTE: as per some stack overflow warning, remember to use a relative
//       import to access this static class
class Preferences {
  static late SharedPreferences prefs;
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static getBool(key) {
    return prefs.getBool(key);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }

}
