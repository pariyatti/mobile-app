import 'package:patta/app/log.dart';
import 'package:patta/model/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'I18nStrings.dart';

class I18n {
  static var _selectedLanguage;

  static Future<Language> init() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedLanguage = Language.from(prefs.getString(Language.SETTINGS_KEY));
    log2("I18n.init selected language: $_selectedLanguage");
    return _selectedLanguage;
  }

  static void set(Language language) {
    _selectedLanguage = language;
    log2("I18n.set selected language: $_selectedLanguage");
  }

  static I18nStrings get() {
    return strings[_selectedLanguage]!;
  }

  static const Map<Language, I18nStrings> strings = {
    Language.eng: I18nStrings(
        appName: 'Pariyatti',
        messageNothingBookmarked: "You haven't bookmarked anything yet",
        donatePreamble: "Pariyatti is an independent USA 501(c)(3) non-profit organization and is not part of the Vipassana organization. Pariyatti relies on a combination of sales revenue and donations to offer its services. All donations are tax-deductible in accordance with US tax law.\n\nIf you would like to have your donation be matched by your employer, request it for Pariyatti (EIN 80-0038336).",
        errorMessageTryAgainLater: 'An error occurred. Please try again later.',
        labelToday: 'Today',
        labelAccount: 'Account',
        labelDonate: 'Donate',
        labelShareInspiration: 'Share Inspiration',
        labelSharePaliWord: 'Share Pāli Word',
        labelTranslation: 'Translation',
        labelBookmarks: 'Bookmarks',
        labelSettings: 'Settings'
    ),
    Language.fra: I18nStrings(appName: "appName",
        donatePreamble: "donatePreamble",
        errorMessageTryAgainLater: "errorMessageTryAgainLater",
        messageNothingBookmarked: "messageNothingBookmarked",
        labelToday: "aujourd'hui",
        labelAccount: "labelAccount",
        labelDonate: "labelDonate",
        labelShareInspiration: "labelShareInspiration",
        labelSharePaliWord: "labelSharePaliWord",
        labelTranslation: "labelTranslation",
        labelBookmarks: "labelBookmarks",
        labelSettings: "labelSettings")
  };

}

