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

  static I18nStrings getForced(Language lang) {
    log2("I18n.getForced selected language: $lang");
    return strings[lang]!;
  }

  static const Map<Language, I18nStrings> strings = {
    Language.eng: I18nStrings(
      appName: 'Pariyatti',
      nothingBookmarked: "You haven't bookmarked anything yet",
      donatePreamble: "Pariyatti is an independent USA 501(c)(3) non-profit organization and is not part of the Vipassana organization. Pariyatti relies on a combination of sales revenue and donations to offer its services. All donations are tax-deductible in accordance with US tax law.\n\nIf you would like to have your donation be matched by your employer, request it for Pariyatti (EIN 80-0038336).",
      tryAgainLater: 'An error occurred. Please try again later.',
      today: 'Today',
      account: 'Account',
      donate: 'Donate',
      shareInspiration: 'Share Inspiration',
      sharePaliWord: 'Share Pāli Word',
      translation: 'Translation',
      bookmarks: 'Bookmarks',
      settings: 'Settings',
      subscribeToNewsletter: 'Subscribe to Newsletter',
      contactPariyatti: 'Contact Pariyatti',
      securityAndPrivacy: 'Security and Privacy',
      aboutPariyatti: 'About Pariyatti',
      feeds: "Feeds",
      languages: "Languages",
      language: "Language",
      languageAlternate: "Alternate",
      theme: "Theme",
      lightTheme: "Light Theme",
      darkTheme: "Dark Theme",
      systemDefault: "System Default",
    ),

    Language.fra: I18nStrings(
      appName: "",
      nothingBookmarked: "",
      donatePreamble: "",
      tryAgainLater: "",
      today: "",
      account: "",
      donate: "",
      shareInspiration: "",
      sharePaliWord: "",
      translation: "",
      bookmarks: "",
      settings: "",
      subscribeToNewsletter: "",
      contactPariyatti: "",
      securityAndPrivacy: "",
      aboutPariyatti: "",
      feeds: "",
      languages: "",
      language: "",
      languageAlternate: "",
      theme: "",
      lightTheme: "",
      darkTheme: "",
      systemDefault: "",
    ),

    Language.ita: I18nStrings(
      appName: "",
      nothingBookmarked: "",
      donatePreamble: "",
      tryAgainLater: "",
      today: "",
      account: "",
      donate: "",
      shareInspiration: "",
      sharePaliWord: "",
      translation: "",
      bookmarks: "",
      settings: "",
      subscribeToNewsletter: "",
      contactPariyatti: "",
      securityAndPrivacy: "",
      aboutPariyatti: "",
      feeds: "",
      languages: "",
      language: "",
      languageAlternate: "",
      theme: "",
      lightTheme: "",
      darkTheme: "",
      systemDefault: "",
    ),

    Language.lit: I18nStrings(
      appName: "",
      nothingBookmarked: "",
      donatePreamble: "",
      tryAgainLater: "",
      today: "",
      account: "",
      donate: "",
      shareInspiration: "",
      sharePaliWord: "",
      translation: "",
      bookmarks: "",
      settings: "",
      subscribeToNewsletter: "",
      contactPariyatti: "",
      securityAndPrivacy: "",
      aboutPariyatti: "",
      feeds: "",
      languages: "",
      language: "",
      languageAlternate: "",
      theme: "",
      lightTheme: "",
      darkTheme: "",
      systemDefault: "",
    ),

    Language.por: I18nStrings(
      appName: "",
      nothingBookmarked: "",
      donatePreamble: "",
      tryAgainLater: "",
      today: "",
      account: "",
      donate: "",
      shareInspiration: "",
      sharePaliWord: "",
      translation: "",
      bookmarks: "",
      settings: "",
      subscribeToNewsletter: "",
      contactPariyatti: "",
      securityAndPrivacy: "",
      aboutPariyatti: "",
      feeds: "",
      languages: "",
      language: "",
      languageAlternate: "",
      theme: "",
      lightTheme: "",
      darkTheme: "",
      systemDefault: "",
    ),

    Language.spa: I18nStrings(
      appName: "",
      nothingBookmarked: "",
      donatePreamble: "",
      tryAgainLater: "",
      today: "",
      account: "",
      donate: "",
      shareInspiration: "",
      sharePaliWord: "",
      translation: "",
      bookmarks: "",
      settings: "",
      subscribeToNewsletter: "",
      contactPariyatti: "",
      securityAndPrivacy: "",
      aboutPariyatti: "",
      feeds: "",
      languages: "",
      language: "",
      languageAlternate: "",
      theme: "",
      lightTheme: "",
      darkTheme: "",
      systemDefault: "",
    ),

    Language.srp: I18nStrings(
      appName: "",
      nothingBookmarked: "",
      donatePreamble: "",
      tryAgainLater: "",
      today: "",
      account: "",
      donate: "",
      shareInspiration: "",
      sharePaliWord: "",
      translation: "",
      bookmarks: "",
      settings: "",
      subscribeToNewsletter: "",
      contactPariyatti: "",
      securityAndPrivacy: "",
      aboutPariyatti: "",
      feeds: "",
      languages: "",
      language: "",
      languageAlternate: "",
      theme: "",
      lightTheme: "",
      darkTheme: "",
      systemDefault: "",
    ),

    Language.zho_hant: I18nStrings(
      appName: "",
      nothingBookmarked: "",
      donatePreamble: "",
      tryAgainLater: "",
      today: "",
      account: "",
      donate: "",
      shareInspiration: "",
      sharePaliWord: "",
      translation: "",
      bookmarks: "",
      settings: "",
      subscribeToNewsletter: "",
      contactPariyatti: "",
      securityAndPrivacy: "",
      aboutPariyatti: "",
      feeds: "",
      languages: "",
      language: "",
      languageAlternate: "",
      theme: "",
      lightTheme: "",
      darkTheme: "",
      systemDefault: "",
    ),

  };

}

