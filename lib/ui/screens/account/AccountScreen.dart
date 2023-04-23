import 'dart:async';
import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:patta/ui/screens/account/BookmarksScreen.dart';
import 'package:patta/ui/screens/account/SettingsScreen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

// NOTE: needs to be a stateful widget to force redraw when a new language is
//       selected in the settings screen
class AccountScreen extends StatefulWidget {
  final void Function() rebuildParent;

  AccountScreen(this.rebuildParent, {Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    return SettingsList(
        lightTheme: AppThemes.version1SettingsThemeData,
        darkTheme: AppThemes.darkSettingsThemeData,
        sections: [
        SettingsSection(tiles: <SettingsTile>[
          SettingsTile.navigation(
            leading: Icon(PariyattiIcons.get(IconName.bookmarkFilled)),
            title: Text(I18n.get("bookmarks")),
            onPressed: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BookmarksTab(),
              )).then(rebuild);
            },
          ),
          SettingsTile.navigation(
            leading: Icon(Icons.mail),
            title: Text(I18n.get("subscribe_to_newsletter")),
            onPressed: (context) {
              // TODO: replace with in-app subscription?
              tryLaunchUrl("https://store.pariyatti.org/newsletter-subscription");
            },
          ),
          SettingsTile.navigation(
            // TODO: use PariyattiIcon?
              leading: Icon(Icons.settings),
              title: Text(I18n.get("settings")),
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SettingsTab(),
                )).then(rebuild);
              },
          ),
          ],
        ),

          SettingsSection( // margin: EdgeInsetsDirectional.only(top: 20.0, bottom: 20.0), -- doesn't seem to do anything?
            tiles: <SettingsTile>[
          SettingsTile.navigation(
            leading: Icon(Icons.contact_support),
            title: Text(I18n.get("contact_pariyatti")),
            onPressed: (context) {
              tryLaunchUrl("https://pariyatti.org/About#contact");
            },
          ),
          SettingsTile.navigation(
            leading: Icon(Icons.verified_user),
            title: Text(I18n.get("security_and_privacy")),
            onPressed: (context) {
              tryLaunchUrl("https://pariyatti.org/Security-Privacy");
            },
          ),
          SettingsTile.navigation(
            leading: Icon(Icons.info),
            title: Text(I18n.get("about_pariyatti")),
            onPressed: (context) {
              tryLaunchUrl("https://pariyatti.org/About");
            },
          ),
        ],
        ),
    ]);
  }

  FutureOr<Null> rebuild(value) {
    setState(() => {});
    widget.rebuildParent();
  }

  Future<void> tryLaunchUrl(url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

}
