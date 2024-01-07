
import 'package:patta/app/log.dart';
import 'preferences.dart';

import '../model/Feed.dart';
import '../model/FeedList.dart';
import '../model/Language.dart';
import 'app_constants.dart';

class FeedPreferences {
  static const TODAY_MAX_DAYS = "TODAY_MAX_DAYS";

  static Future<void> init() async {
    for (Feed feed in _getFeedList().all()) {
      if (Preferences.getBool(feed.key) == null) {
        log2("[FeedPreferences] WARNING: $feed flag not found; force-enabling feed...");
        Preferences.setBool(feed.key, true);
      }
    }
    if (Preferences.getInt(TODAY_MAX_DAYS) == null) {
      log2("[FeedPreferences] WARNING: Preference '$TODAY_MAX_DAYS' not found; defaulting to ${AppConstants.DEFAULT_TODAY_MAX_DAYS} ...");
      Preferences.setInt(TODAY_MAX_DAYS, AppConstants.DEFAULT_TODAY_MAX_DAYS);
    }
  }

  static void initFirstRun() {
    log2("[FeedPreferences] First run: setting all feed flags");
    for (Feed feed in _getFeedList().all()) {
      log2("[FeedPreferences] First run: setting $feed");
      Preferences.setBool(feed.key, true);
    }
    Preferences.setInt(TODAY_MAX_DAYS, AppConstants.DEFAULT_TODAY_MAX_DAYS);
  }

  static FeedList _getFeedList() {
    Language selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
    log2("[TodayFeed] Calling FeedList constructor with: $selectedLanguage");
    return FeedList(selectedLanguage);
  }

  bool getFeedFlag(Feed feed) {
    return Preferences.getBool(feed.key)!;
  }

  void toggle(Feed feed) {
    bool oldValue = Preferences.getBool(feed.key)!;
    Preferences.setBool(feed.key, !oldValue);
  }

  int getTodayMaxDays() {
    log2("[FeedPreferences] 'TODAY_MAX_DAYS' is = ${Preferences.getInt(TODAY_MAX_DAYS)}.");
    return Preferences.getInt(TODAY_MAX_DAYS) ?? AppConstants.DEFAULT_TODAY_MAX_DAYS;
  }

  void setTodayMaxDays(String? days) {
    if (days == null || days.isEmpty) {
      log2("[FeedPreferences] 'days' was empty; setting prefs to default.");
      Preferences.setInt(TODAY_MAX_DAYS, AppConstants.DEFAULT_TODAY_MAX_DAYS);
      return;
    }
    var d = int.parse(days);
    log2("[FeedPreferences] 'days' was $d, setting prefs.");
    Preferences.setInt(TODAY_MAX_DAYS, d);
  }
}