
# The Pariyatti mobile app

[![Codemagic build status](https://api.codemagic.io/apps/623f06b866f7430a541f6528/default-workflow/status_badge.svg)](https://codemagic.io/apps/623f06b866f7430a541f6528/default-workflow/latest_build)

## Design

- [Design Docs & Wireframes](https://drive.google.com/drive/folders/1Iga6z-5tndLJ411XG5ibimLwNC5VZDVv?usp=sharing) (public)
- `patta [m.]: _leaf; alms bowl; attained_`

## Tool Versions

* Ubuntu 22.04
* MacOS 13.2.1
* JDK 17
* Android Studio 22.2.1
* XCode 15
* Flutter:

```
% flutter --version
Flutter 3.22.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 761747bfc5 (2 weeks ago) • 2024-06-05 22:15:13 +0200
Engine • revision edd8546116
Tools • Dart 3.4.3 • DevTools 2.34.3
```

## Dev Setup: Android

1. Install Java (Linux or MacOS): `sudo apt-get install openjdk-17-jdk`
2. Install Linux deps:
   - `sudo apt install net-tools clang ninja-build google-android-platform-tools-installer`
3. Install Android Studio:
   - MacOS: https://developer.android.com/studio
   - Linux: https://flathub.org/apps/com.google.AndroidStudio
   - Install Android SDK: `Settings > Languages & Frameworks > Android SDK > click 'edit'` (SDK will be installed to a directory like `/home/steven/Android/Sdk`)
   - In `Settings > Languages & Frameworks > Android SDK > SDK Tools`, install:
      - Android SDK Command-line Tools
      - Android SDK Build-Tools
      - Android SDK Platform-Tools
      - Android Emulator
   - Install the Android Studio Flutter Plugin
   - (Optional, Linux) Configure udev to collect logs from a hardware device attached by USB:
     - `sudo apt-get install adb && sudo usermod -aG plugdev $LOGNAME`
4. Install Flutter: https://flutter.dev/docs/get-started/install
   - run `flutter doctor` and follow any remaining instructions

### Troubleshooting Android

```sh
$ flutter doctor --android-licenses # produces:
Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema
```

See: https://stackoverflow.com/questions/46402772/failed-to-install-android-sdk-java-lang-noclassdeffounderror-javax-xml-bind-a/64389804#64389804

Can't find device? Make sure `google-android-platform-tools-installer` is installed (Linux). Then try:

```sh 
adb kill-server
adb start-server
```

## Dev Setup: iOS

1. Install Java (MacOS):
   - Download JDK 17: https://jdk.java.net/17/
   - `cd ~/Downloads && tar xzf tar xzf openjdk-17.0.0_osx-x64_bin.tar.gz`
   - `sudo mv jdk-17.0.0.jdk /Library/Java/JavaVirtualMachines/.`
   - `echo 'export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.0.0.jdk/Contents/Home' >> ~/.zshrc` # or `.bash_profile`
2. Install Ruby (MacOS, rbenv):
   - https://github.com/rbenv/rbenv
   - `rbenv install 3.2.2`
3. Install Xcode
4. Install Flutter: https://flutter.dev/docs/get-started/install
   - run `flutter precache` and `flutter doctor` and follow any remaining instructions
   - when installing CocoaPods, prefer the local, rbenv-managed `--user-install` option
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
make help    # optional: view targets, if you like
make clean
make init
make build
```

## Local Build Process

```
make help
make clean
make init
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
* `lib/ui/widgets/cards/*Card.dart`
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

Database migrations are done in `database.dart` by bumping `schemaVersion`.

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

1. Staging, which emails builds to developers
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

## Troubleshooting

On an error like `Error (Xcode): Provisioning profile "Pariyatti App Dev" expired on Jan 4, 2025.`

* Xcode => Preferences => Accounts => Manage Certificates
    * A new Development cert might automatically be created
    * ...if not, click "+" => Apple Development Certificate
* Check for cert in https://developer.apple.com/account/resources/certificates/list
* Go to https://developer.apple.com/account/resources/profiles/
    * Open "Pariyatti App Dev" profile
    * Associate (select) new certificate(s)
    * Click "Save" => you should see a new expiration date on the "Download and Install" page
* Xcode => Preferences => Accounts => "Download Manual Profiles"
* Check Runner => Signing & Capabilities => Provisioning Profile and Signing Certificate should be ok

## License and Copyright

[AGPL-3](https://github.com/pariyatti/mobile-app/blob/master/LICENSE)

Copyright (c) 2019-present, Pariyatti
