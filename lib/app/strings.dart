import 'package:flutter/foundation.dart';

const Map<String, AppStrings> strings = {
  'eng': AppStrings(
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
};

class AppStrings {
  final String appName;
  final String donatePreamble;
  final String errorMessageTryAgainLater;
  final String messageNothingBookmarked;
  final String labelToday;
  final String labelAccount;
  final String labelDonate;
  final String labelShareInspiration;
  final String labelSharePaliWord;
  final String labelTranslation;
  final String labelBookmarks;
  final String labelSettings;

  const AppStrings({
    @required required this.appName,
    @required required this.donatePreamble,
    @required required this.errorMessageTryAgainLater,
    @required required this.messageNothingBookmarked,
    @required required this.labelToday,
    @required required this.labelAccount,
    @required required this.labelDonate,
    @required required this.labelShareInspiration,
    @required required this.labelSharePaliWord,
    @required required this.labelTranslation,
    @required required this.labelBookmarks,
    @required required this.labelSettings
  });

  static AppStrings get() {
    return strings['eng']!;
  }
}
