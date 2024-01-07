
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/app_constants.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/feed_preferences.dart';
import 'package:patta/app/log.dart';
import 'package:patta/services/numerical_range_formatter.dart';
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
    List<SettingsTile> feedToggleTiles = List.from(feedList.all().map((e) => buildFeedToggleTiles(e)));
    List<SettingsTile> todayMaxDays = [buildTodayMaxDaysTile()];

    return Scaffold(
      appBar: AppBar(
          title: Text(I18n.get("feeds")),
          backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        darkTheme: AppThemes.darkSettingsThemeData,
        sections: [
          SettingsSection(tiles: feedToggleTiles),
          SettingsSection(tiles: todayMaxDays)
        ],
      ),
    );
  }

  SettingsTile buildFeedToggleTiles(Feed feed) {
    return SettingsTile(
      title: Text(feed.title),
      trailing: checkmark(feedPreferences.getFeedFlag(feed)),
      onPressed: (BuildContext context) { _toggleFeed(feed); });
  }

  SettingsTile buildTodayMaxDaysTile() {
    var focus = FocusNode();
    var numberInput = number(feedPreferences.getTodayMaxDays(), focus);
    return SettingsTile(
        title: Text("Days Visible (1-${AppConstants.MAX_DAYS_PERMITTED})"),
        trailing: numberInput,
        onPressed: (BuildContext context) { focus.requestFocus(); });
  }

  Widget checkmark(bool enabled) {
    return enabled ? AppThemes.checkIcon(context) : Icon(null);
  }

  Widget number(int count, FocusNode focus) {
    var settingsStyle = TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.w700);
    return rangeEntry(settingsStyle, focus);
  }

  Widget rangeEntry(TextStyle settingsStyle, FocusNode focus) {
    return Flexible(
        child:
        TextFormField(
          focusNode: focus,
          onChanged: (text) { feedPreferences.setTodayMaxDays(text); },
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            NumericalRangeFormatter(min: 1, max: AppConstants.MAX_DAYS_PERMITTED)
          ],
          initialValue: feedPreferences.getTodayMaxDays().toString(),
          textAlign: TextAlign.right,
          style: settingsStyle,
          decoration: InputDecoration(border: UnderlineInputBorder().copyWith(borderSide: BorderSide.none))
        ));
  }
}
