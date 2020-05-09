# patta [m.]: _leaf; alms bowl; attained_

The Pariyatti mobile app.

## Design

- [Design Docs & Wireframes](https://drive.google.com/drive/folders/1Iga6z-5tndLJ411XG5ibimLwNC5VZDVv?usp=sharing) (public)

## Branches

1. `master` is for release builds. Merging changes into `master` causes a build in [CodeMagic](https://github.com/pariyatti/patta#ci--cd-builds) which publishes to the Play Store.
2. `development` is for debug builds. These are not published to the Play Store but are automatically emailed to developers. Do version bumps in the `development` branch **only**.
3. Feature Branches are used for all active development. Branch off of the `development` branch either in the `pariyatti/patta` repo or in your own personal repo. When you are finished a User Story, submit a PR to the `development` branch. Stories should be thoroughly tested before they are merged into `master`.

```
Promotion:

[feature] ==> [development] ==> [master]
    |      |         |       |      |
   dev     PR   debug/test   PR  release
```

## Dev Setup

1. Install Java: `sudo apt-get install openjdk-14-jdk` or `sudo apt-get install openjdk-11-jdk`
2. Install Android Studio: https://developer.android.com/studio
   - Install Android SDK Tools (obsolete) in `Tools > SDK Manager`
   - Install Android SDK Command-line Tools in `Tools > SDK Manager`
   - Install the Android Studio Flutter Plugin
   - Configure udev: `sudo apt-get install adb && sudo usermod -aG plugdev $LOGNAME`
3. Install Flutter: https://flutter.dev/docs/get-started/install
   - run `flutter doctor` and follow any remaining instructions

## Local Build Process

### Common steps

```
# Copy example config file to provide configuration secrets
cp config/app_config.sample.json config/app_config.json

# Fill in values of secrets/keys inside config/app_config.json
# (At the moment, the app doesn't require any.)

# Grab dependencies
flutter pub get

# Generate code for part-files
flutter pub run build_runner build
```


### Run debug build with sandbox servers

```
# Target sandbox environment
flutter run --target lib/main_sand.dart
```

### Run debug build with production servers

```
# Target production environment
flutter run --target lib/main_prod.dart
```

### Run release build with production servers (signed APK)

In order of preference:

1. Use a build from [CodeMagic](https://github.com/pariyatti/patta#ci--cd-builds). Avoid locally signed release builds.

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

- What's the Right Way to do i18n?
- Why are the emulators broken and can we fix them?
- Philsophical: What's the deal with `State` vs. `StatefulWidget`?
- Could the HomeScreen state switch be a tiny object unto itself?
- How does the `factory` keyword work?
- If Santu comments on the `*Card.dart` files, are they readable to a newbie?
- What is the `delete(card)..where()` double-dot syntax in Moor?
- Can Moor Converters move into multiple files?

