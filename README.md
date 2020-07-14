# patta [m.]: _leaf; alms bowl; attained_

The Pariyatti mobile app.

## Design

- [Design Docs & Wireframes](https://drive.google.com/drive/folders/1Iga6z-5tndLJ411XG5ibimLwNC5VZDVv?usp=sharing) (public)

## Dev Setup

1. Install Java: `sudo apt-get install openjdk-14-jdk` or `sudo apt-get install openjdk-11-jdk`
2. Install Android Studio: https://developer.android.com/studio
   - Install Android SDK Tools (obsolete) in `Tools > SDK Manager`
   - Install Android SDK Command-line Tools in `Tools > SDK Manager`
   - Install the Android Studio Flutter Plugin
   - Configure udev to collect logs from a hardware device attached by USB: 
     - `sudo apt-get install adb && sudo usermod -aG plugdev $LOGNAME`
3. Install Flutter: https://flutter.dev/docs/get-started/install
   - run `flutter doctor` and follow any remaining instructions

## Local Build Process

### Common steps

```
# Copy example config file to provide configuration secrets
cp config/app_config.sample.json config/app_config.json

# Fill in values of secrets/keys inside config/app_config.json

# Grab dependencies
flutter pub get

# Generate code for part-files. This generated code is used to 
# parse/deserialize JSON and db data into model objects. 
flutter pub run build_runner build
```


### Run debug build with sandbox servers
```
# Target sandbox environment
# This uses a `main` specific to the sandbox server
flutter run --target lib/main_sand.dart
```

### Run debug build with production servers
```
# Target production environment
# This uses a `main` specific to the production server
flutter run --target lib/main_prod.dart
```

### Run signed Android release build with production servers
```
# Generate Android signing keystore from these instructions
# https://flutter.dev/docs/deployment/android#create-a-keystore
# Make sure to name the file "keystore.jks" and put it right inside "android" dir

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

