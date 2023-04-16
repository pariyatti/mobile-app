
import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/app_themes.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/Feed.dart';

class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  Map<String, bool> enabledFeeds = Map.fromIterable(Feed.all, key: (e) => e.key, value: (e) => true);

  @override
  void initState() {
    super.initState();
    _loadFeedPreferences();
  }

  bool _readPreference(SharedPreferences prefs, String key) {
    return prefs.getBool(key) ?? enabledFeeds[key]!;
  }

  void _loadFeedPreferences() async {
    // TODO: use 'Preferences' to remove duplication between this and WordsOfBuddhaCard.dart
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enabledFeeds.keys.forEach((key) { enabledFeeds[key] = _readPreference(prefs, key); });
    });
  }

  void _toggleFeed(String feedKey) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enabledFeeds[feedKey] = !(_readPreference(prefs, feedKey));
      prefs.setBool(feedKey, enabledFeeds[feedKey]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SettingsTile> tiles = List.from(Feed.all.map((e) => buildSettingsTile(e)));

    return Scaffold(
      appBar: AppBar(
          title: Text(I18n.get().feeds),
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
