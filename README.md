
# The Pariyatti mobile app. - demo build

[![Codemagic build status](https://api.codemagic.io/apps/623f06b866f7430a541f6528/default-workflow/status_badge.svg)](https://codemagic.io/apps/623f06b866f7430a541f6528/default-workflow/latest_build)

## Design

- [Design Docs & Wireframes](https://drive.google.com/drive/folders/1Iga6z-5tndLJ411XG5ibimLwNC5VZDVv?usp=sharing) (public)
- `patta [m.]: _leaf; alms bowl; attained_`

## Tool Versions

* Ubuntu 22.04
* MacOS 13.2.1
* JDK 17
* Android Studio 22.2.1
* XCode 14.3
* Flutter:

```
% flutter --version
Flutter 3.7.11 • channel stable • https://github.com/flutter/flutter.git
Framework • revision f72efea43c (5 days ago) • 2023-04-11 11:57:21 -0700
Engine • revision 1a65d409c7
Tools • Dart 2.19.6 • DevTools 2.20.1
```

## Dev Setup: Android

1. Install Java (Linux or MacOS): `sudo apt-get install openjdk-17-jdk`
2. Install Android Studio: https://developer.android.com/studio
   - Install Android SDK Tools (obsolete) in `Tools > SDK Manager`
   - Install Android SDK Command-line Tools in `Tools > SDK Manager`
   - Install Android SDK Command-line Tools (latest) in `Preferences > Appearance & Behavior > System Settings > Android SDK > SDK Tools`
   - Install the Android Studio Flutter Plugin
   - (Optional, Linux) Configure udev to collect logs from a hardware device attached by USB:
     - `sudo apt-get install adb && sudo usermod -aG plugdev $LOGNAME`
3. Install Flutter: https://flutter.dev/docs/get-started/install
   - run `flutter doctor` and follow any remaining instructions

### Troubleshooting Android

```sh
$ flutter doctor --android-licenses # produces:
Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema
```

See: https://stackoverflow.com/questions/46402772/failed-to-install-android-sdk-java-lang-noclassdeffounderror-javax-xml-bind-a/64389804#64389804

## Dev Setup: iOS

1. Install Java (MacOS):
   - Download JDK 17: https://jdk.java.net/17/
   - `cd ~/Downloads && tar xzf tar xzf openjdk-17.0.0_osx-x64_bin.tar.gz`
   - `sudo mv jdk-17.0.0.jdk /Library/Java/JavaVirtualMachines/.`
   - `echo 'export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.0.0.jdk/Contents/Home' >> ~/.zshrc` # or `.bash_profile`
1. Install Xcode
2. Install Flutter: https://flutter.dev/docs/get-started/install
   - run `flutter precache` and `flutter doctor` and follow any remaining instructions
   - required on Mac as of 2021-02-06: `ln -s ~/Library/Application\ Support/Google/AndroidStudio4.1/plugins ~/Library/Application\ Support/AndroidStudio4.1`
   - run `flutter devices` - if you get a "device busy" message, reboot MacOS and phone. This might be helpful: https://github.com/flutter/flutter/issues/66862 and https://github.com/flutter/flutter/issues/66862#issuecomment-758967875

### Troubleshooting iOS

**"Untrusted Developer"**

If you are building using a personal Team Profile, you will need to trust your developer profile.
You will need to do this every time you reinstall (delete + install) the app in Debug mode:

`Settings > General > VPN & Device Management > Developer App > Apple Development: {your name} > Trust {your name}`

**Cannot Access Local Network:**

If you get `DioError: ... Failed host lookup: 'your-computer.local'` you can try the following:

1. Enable `Settings > Privacy > Local Network > Pariyatti` (on your iPhone)
** This should (in theory) be set by Bonjour Services as per: https://flutter.dev/docs/development/add-to-app/ios/project-setup#local-network-privacy-permissions
2. Make sure your phone and computer are on the same wifi network
3. Try turning off mobile data to ensure your phone finds your computer through the local network

**XCode Signing Failures:**

```sh
$ make run env=local # produces:
Could not build the precompiled application for the device.
It appears that your application still contains the default signing identifier.
```

XCode _routinely_ changes build configuration recommendations in ways that are not backward-compatible.
If you open XCode with the recommended command (`open ios/Runner.xcworkspace`) you may see some config recommendations.
Try accepting them but make sure you can build and run from Flutter (without XCode) before committing them.

If you are using an automatically-generated certificate, you will need to regenerate it once a week.
Opening XCode with `open ios/Runner.xcworkspace`, selecting your iPhone, and running with ⌘R should regenerate it.
If this does not work, sometimes the Pariyatti Apple Development Team may be stuck.
If you suspect it is, try switching your Team profile to `{Your Name} (Personal Team)` under
`Project Navigator > Runner > Signing & Capabilities > Team`, then running with ⌘R.

```
Error (Xcode): No profiles for 'app.pariyatti' were found: Xcode couldn't find any iOS App Development provisioning profiles matching
'app.pariyatti'. Automatic signing is disabled and unable to generate a profile. To enable automatic signing, pass
-allowProvisioningUpdates to xcodebuild.
```

## Flutter Setup

```
make help
make init-clean
make init
```

## Local Build Process

```
make help
make clean
make build
make test
make run env=local      # local Kosa server to test Kosa dev changes
```

**Flutter Build/Run Failures:**

Try:

```sh
make repair
make repair-xcode
```

**Flutter Package Versioning Failures:**

Try:

```sh
flutter upgrade
flutter pub upgrade
make clean
```


***

:sunrise_over_mountains: Everything below this point is for project admins.
If this is your first time building the Pariyatti Mobile App, you can stop here. :) :sunrise_over_mountains:

***


## Branch Policy

1. `master` is for release builds. Merging changes into `master` causes a build in [CodeMagic](https://github.com/pariyatti/mobile-app#ci--cd-builds) which publishes to the Play Store.
2. `development` is for debug builds. These are not published to the Play Store but are automatically emailed to developers. Do version bumps in the `development` branch **only**.
3. Feature Branches are used for all active development. Branch off of the `development` branch either in the `pariyatti/mobile-app` repo or in your own personal repo. When you are finished a User Story, submit a PR to the `development` branch. Stories should be thoroughly tested before they are merged into `master`.

```
Promotion:

[feature] ==> [development] ==> [master]
    |      |         |       |      |
   dev     PR   debug/test   PR  release
```

## Hacking

To add a new "Today" card, there is quite a bit of duplication. Please see:

* `lib/model/*CardModel.dart`
* `lib/ui/common_widgets/cards/*Card.dart`
* `lib/ui/screens/today/TodayScreen.dart          -> _buildCardsList()`
* `lib/ui/screens/account/tabs/BookmarksTab.dart  -> _buildCardsList()`
* `lib/local_database/cards.dart`
* `lib/local_database/database.dart`
* `lib/local_database/drift_converters.dart       -> toDatabaseCard() / toCardModel()`

Then clean and build to re-generate database stubs:

```sh
make clean
make build
```

If you are changing the schema of the SQLite database, you will need to uninstall
and reinstall the mobile app for the changes to take effect. This is a limitation
of the current method of bookmarking because we do not have database migrations.
Upon re-installation, you will need to trust the app on your phone again:

`Settings > General > VPN & Device Management > Developer App > {your email} > Trust`

## Run release build with production servers (signed APK)

In order of preference:

1. Use a build from [CodeMagic](https://github.com/pariyatti/mobile-app#ci--cd-builds). Avoid locally signed release builds.

2. If for some reason CodeMagic isn't available: Get the `keystore.jks` and `keystore.properties` files from the Vault, copy them locally, and build locally.

```
# Create these files:
/android/keystore.jks
/android/keystore.properties

# Build + Run signed Android app with production environment:
flutter run --release --target lib/main_prod.dart
```

3. Do it all by hand:

```
# Generate Android signing keystore from these instructions
# https://flutter.dev/docs/deployment/android#create-a-keystore
# Make sure to name the file "keystore.jks" and put it right inside the `/android` directory

# Copy sample properties file
cp android/keystore.sample.properties android/keystore.properties

# Fill in the key-alias, store-password and key-password as per your
# keystore inside the copied keystore.properties file

# Run signed Android app with production environment
flutter run --release --target lib/main_prod.dart
```

## CI / CD Builds

Ask Steven Deobald or Tanmay Balwa for an account if you cannot see the app:

https://codemagic.io/app/623f06b866f7430a541f6528

We have two builds:

1. Sandbox, which emails builds to developers
2. Production, which publishes signed release builds to App/Play Stores

* To configure the App Store, go to https://developer.apple.com
* To configure the Play Store, go to https://play.google.com/console/

## Releasing / Managing Tracks

To release a new version publicly, please see https://github.com/pariyatti/mobile-app/blob/master/doc/RELEASING.md

## App Design - Outstanding Questions

If you have answers to these questions, please move them to the top and put the answer in a sub-bullet.

- What's the Right Way to do i18n?
  - https://flutter.dev/docs/development/accessibility-and-localization/internationalization

- Could the HomeScreen state switch be a tiny object unto itself?
- Can Drift Converters move into multiple files?

## License and Copyright

[AGPL-3](https://github.com/pariyatti/mobile-app/blob/master/LICENSE)

Copyright (c) 2019-present, Pariyatti
