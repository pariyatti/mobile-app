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
   - Configure udev: `sudo apt-get install adb && sudo usermod -aG plugdev $LOGNAME`
3. Install Flutter: https://flutter.dev/docs/get-started/install
   - run `flutter doctor` and follow any remaining instructions

## Local Build Process

```
# Grab dependencies
flutter pub get

# Generate database-interaction and json-conversion code
flutter pub run build_runner build

# Generate iOS and Android icons
flutter pub run flutter_launcher_icons:main

# Run the app on connected device
flutter run
```

## CI / CD Builds

Ask Steven Deobald or Varun Barad for an account if you cannot see the app:

[https://codemagic.io/app/5ea7faa6ab38b5000ac85f7b](https://codemagic.io/app/5ea7faa6ab38b5000ac85f7b)

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

