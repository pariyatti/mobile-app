
# The Pariyatti mobile app.

[![Codemagic build status](https://api.codemagic.io/apps/5ea7faa6ab38b5000ac85f7b/5ea7faa6ab38b5000ac85f7a/status_badge.svg)](https://codemagic.io/apps/5ea7faa6ab38b5000ac85f7b/5ea7faa6ab38b5000ac85f7a/latest_build)

## Design

- [Design Docs & Wireframes](https://drive.google.com/drive/folders/1Iga6z-5tndLJ411XG5ibimLwNC5VZDVv?usp=sharing) (public)
- `patta [m.]: _leaf; alms bowl; attained_`

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

### Troubleshooting

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

### Troubleshooting

**Flutter Package Versioning Failures:**

Try:

```sh
$ flutter upgrade
$ flutter pub upgrade
```

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

## Local Build Process

```
make help
make init
make test
make run                # sandbox, by default
make run env=local      # local Kosa server to test Kosa dev changes
make run env=production # production, if you need it
```

***

:sunrise_over_mountains: Everything below this point is for project admins. If this is your first time building `patta`, you can stop here. :) :sunrise_over_mountains:

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

Ask Steven Deobald or Varun Barad for an account if you cannot see the app:

[https://codemagic.io/app/5ea7faa6ab38b5000ac85f7b](https://codemagic.io/app/5ea7faa6ab38b5000ac85f7b)

We have two builds:

1. Sandbox, which emails builds to developers
2. Production, which publishes signed release builds to App/Play Stores

### Managing Tracks

We should only ever have one published track in the Play Store. At this stage, our only track is the `Internal` track. When the first public release is ready, this will change to the `Production` track. Both of these tracks use the same signed release build targetting the `production` kosa server. The only difference is that the `Production` track is publicly visible.

When we're ready for our first public release, we will need to change `Publish => Google Play => Track` to `Production` and `Build => Trigger on Push` to `false` (public builds will be manual).

## Flutter - Outstanding Questions

If you have answers to these questions, please move them to the top and put the answer in a sub-bullet.

- What is the `delete(card)..where()` double-dot syntax in Moor?
  - This is not Moor-specific but rather a feature of Dart. The double-dot returns you the _previous_ instance so you can keep operating on one object rather than chaining methods over previous methods' return values. For instance: `A.b()..c()` runs `b()` on the instance `A` but it also runs `c()` on the instance `A`, instead of on the return value of `b()` as `A.b().c()` would.
- What's the Right Way to do i18n?
  - https://flutter.dev/docs/development/accessibility-and-localization/internationalization

- Why are the emulators broken and can we fix them?
- Philsophical: What's the deal with `State` vs. `StatefulWidget`?
- Could the HomeScreen state switch be a tiny object unto itself?
- How does the `factory` keyword work?
- If Santu comments on the `*Card.dart` files, are they readable to a newbie?
- Can Moor Converters move into multiple files?

## License and Copyright

[AGPL-3](https://github.com/pariyatti/mobile-app/blob/development/LICENSE)

Copyright (c) 2019-present, Pariyatti
