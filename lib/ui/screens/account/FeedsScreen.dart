
import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/feed_preferences.dart';
import 'package:patta/app/log.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:patta/app/preferences.dart';
import '../../../model/Feed.dart';
import '../../../model/FeedList.dart';
import '../../../model/Language.dart';

class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  var feedList;
  var feedPreferences;

  @override
  void initState() {
    super.initState();
    feedList = getFeedList();
    feedPreferences = FeedPreferences();
  }

  FeedList getFeedList() {
    Language selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
    log2("[TodayFeed] Calling FeedList constructor with: $selectedLanguage");
    return FeedList(selectedLanguage);
  }

  void _toggleFeed(Feed feed) async {
    setState(() {
      feedPreferences.toggle(feed);
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
      trailing: trailingWidget(feedPreferences.getFeedFlag(feed)),
      onPressed: (BuildContext context) { _toggleFeed(feed); });
  }

  Widget trailingWidget(bool enabled) {
    return enabled ? AppThemes.checkIcon(context) : Icon(null);
  }
}
