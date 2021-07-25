import 'package:flutter/foundation.dart';

const Map<String, AppStrings> strings = {
  'en': AppStrings(
    appName: 'Pariyatti',
    messageNothingBookmarked: 'You haven\'t bookmarked anything yet',
    errorMessageTryAgainLater:
        'Some error occurred, can you please try again later!',
    labelToday: 'Today',
    labelAccount: 'Account',
    labelShareInspiration: 'Share Inspiration',
    labelSharePaliWord: 'Share Pāli Word',
    labelTranslation: 'Translation',
    labelBookmarks: 'Bookmarks',
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
  });

  static AppStrings get() {
    return strings['en']!;
  }
}
