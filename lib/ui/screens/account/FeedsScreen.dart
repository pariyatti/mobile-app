
import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/log.dart';
import 'package:patta/model/FeedList.dart';
import 'package:patta/model/Language.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/preferences.dart';
import '../../../model/Feed.dart';

class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  var feedList;
  Map<String, bool> enabledFeeds = Map();

  @override
  void initState() {
    super.initState();
    loadFeedPreferences();
    feedList = getFeedList();
    enabledFeeds = Map.fromIterable(feedList.all(), key: (e) => e.key, value: (e) => true);
  }

  bool _readPreference(String key) {
    return Preferences.getBool(key) ?? enabledFeeds[key]!;
  }

  void loadFeedPreferences() async {
    setState(() {
      enabledFeeds.keys.forEach((key) { enabledFeeds[key] = _readPreference(key); });
    });
  }

  FeedList getFeedList() {
    Language selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
    log2("[TodayFeed] Calling FeedList constructor with: $selectedLanguage");
    return FeedList(selectedLanguage);
  }

  void _toggleFeed(String feedKey) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enabledFeeds[feedKey] = !(_readPreference(feedKey));
      prefs.setBool(feedKey, enabledFeeds[feedKey]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SettingsTile> tiles = List.from(feedList.all().map((e) => buildSettingsTile(e)));

    return Scaffold(
      appBar: AppBar(
          title: Text(I18n.get("feeds")),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        darkTheme: AppThemes.darkSettingsThemeData,
        sections: [
          SettingsSection(tiles: tiles),
        ],
      ),
    );
  }

  SettingsTile buildSettingsTile(Feed feed) {
    return SettingsTile(
      title: Text(feed.title),
      trailing: trailingWidget(enabledFeeds[feed.key]!),
      onPressed: (BuildContext context) { _toggleFeed(feed.key); });
  }

  Widget trailingWidget(bool enabled) {
    return enabled ? AppThemes.checkIcon(context) : Icon(null);
  }
}
