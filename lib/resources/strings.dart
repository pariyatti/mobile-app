import 'package:flutter/foundation.dart';

const Map<String, AppStrings> strings = {
  'eng': AppStrings(
    appName: 'Pariyatti',
    messageNothingBookmarked: "You haven't bookmarked anything yet",
    errorMessageTryAgainLater: 'An error occurred. Please try again later.',
    labelToday: 'Today',
    labelAccount: 'Account',
    labelShareInspiration: 'Share Inspiration',
    labelSharePaliWord: 'Share Pāli Word',
    labelTranslation: 'Translation',
    labelBookmarks: 'Bookmarks',
    labelSettings: 'Settings'
  ),
};

class AppStrings {
  final String appName;
  final String errorMessageTryAgainLater;
  final String messageNothingBookmarked;
  final String labelToday;
  final String labelAccount;
  final String labelShareInspiration;
  final String labelSharePaliWord;
  final String labelTranslation;
  final String labelBookmarks;
  final String labelSettings;

  const AppStrings({
    @required required this.appName,
    @required required this.errorMessageTryAgainLater,
    @required required this.messageNothingBookmarked,
    @required required this.labelToday,
    @required required this.labelAccount,
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
