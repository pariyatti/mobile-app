
import 'package:patta/app/log.dart';
import 'package:patta/app/preferences.dart';

import '../model/Feed.dart';
import '../model/FeedList.dart';
import '../model/Language.dart';

class FeedPreferences {

  static Future<void> init() async {
    for (Feed feed in _getFeedList().all()) {
      if (Preferences.getBool(feed.key) == null) {
        log2("[FeedPreferences] WARNING: $feed flag not found; force-enabling feed...");
        Preferences.setBool(feed.key, true);
      }
    }
  }

  static void initFirstRun() {
    log2("[FeedPreferences] First run: setting all feed flags");
    for (Feed feed in _getFeedList().all()) {
      log2("[FeedPreferences] First run: setting $feed");
      Preferences.setBool(feed.key, true);
    }
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

}