import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:patta/ui/screens/account/BookmarksScreen.dart';
import 'package:patta/ui/screens/account/SettingsScreen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatelessWidget {

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
              ));
            },
          ),
          SettingsTile.navigation(
            leading: Icon(Icons.mail),
            title: Text(I18n.get("subscribeToNewsletter")),
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
                ));
              },
          ),
          ],
        ),

          SettingsSection( // margin: EdgeInsetsDirectional.only(top: 20.0, bottom: 20.0), -- doesn't seem to do anything?
            tiles: <SettingsTile>[
          SettingsTile.navigation(
            leading: Icon(Icons.contact_support),
            title: Text(I18n.get("contactPariyatti")),
            onPressed: (context) {
              tryLaunchUrl("https://pariyatti.org/About#contact");
            },
          ),
          SettingsTile.navigation(
            leading: Icon(Icons.verified_user),
            title: Text(I18n.get("securityAndPrivacy")),
            onPressed: (context) {
              tryLaunchUrl("https://pariyatti.org/Security-Privacy");
            },
          ),
          SettingsTile.navigation(
            leading: Icon(Icons.info),
            title: Text(I18n.get("aboutPariyatti")),
            onPressed: (context) {
              tryLaunchUrl("https://pariyatti.org/About");
            },
          ),
        ],
        ),
    ]);
  }

  Future<void> tryLaunchUrl(url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

}
