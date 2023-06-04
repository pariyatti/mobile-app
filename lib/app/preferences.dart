import 'package:shared_preferences/shared_preferences.dart';

import '../model/Language.dart';

// NOTE: as per some stack overflow warning, remember to use a relative
//       import to access this static class
class Preferences {
  static late SharedPreferences prefs;
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool? getBool(key) {
    return prefs.getBool(key);
  }

  static void setBool(String key, bool flag) {
    prefs.setBool(key, flag);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }

  static void setString(String key, String value) {
    prefs.setString(key, value);
  }

  static Language getLanguage(String key) {
    return Language.from(Preferences.getString(key));
  }

  static void setLanguage(String key, Language language) {
    prefs.setString(key, language.code);
  }

  static bool getIsFirstRun() {
    if (Preferences.getBool("first_run_flagged") == null) {
      Preferences.setBool("first_run_flagged", true);
      return true;
    }
    return false;
  }

}
