const Map<String, AppStrings> strings = {
  'en': AppStrings(
    appName: 'Pariyatti',
    errorMessageTryAgainLater:
        'Some error occured, can you please try again later!',
    labelShareInspiration: 'Share Inspiration',
  ),
};

class AppStrings {
  final String appName;
  final String errorMessageTryAgainLater;
  final String labelShareInspiration;

  const AppStrings({
    this.appName,
    this.errorMessageTryAgainLater,
    this.labelShareInspiration,
  });
}
