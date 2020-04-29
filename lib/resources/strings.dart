import 'package:flutter/foundation.dart';

const Map<String, AppStrings> strings = {
  'en': AppStrings(
    appName: 'Pariyatti',
    errorMessageTryAgainLater:
        'Some error occured, can you please try again later!',
      labelToday: 'Today',
      labelAccount: 'Account',
    labelShareInspiration: 'Share Inspiration',
    labelSharePaliWord: 'Share Pali Word',
    labelTranslation: 'Translation'
  ),
};

class AppStrings {
  final String appName;
  final String errorMessageTryAgainLater;
  final String labelToday;
  final String labelAccount;
  final String labelShareInspiration;
  final String labelSharePaliWord;
  final String labelTranslation;

  const AppStrings({
    @required this.appName,
    @required this.errorMessageTryAgainLater,
    @required this.labelToday,
    @required this.labelAccount,
    @required this.labelShareInspiration,
    @required this.labelSharePaliWord,
    @required this.labelTranslation,
  });
}