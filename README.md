# patta [m.]: _leaf; alms bowl; attained_

The Pariyatti mobile app.

## Design

- [Design Docs & Wireframes](https://drive.google.com/drive/folders/1Iga6z-5tndLJ411XG5ibimLwNC5VZDVv?usp=sharing) (public)

## Dev Setup

- Install Java: `sudo apt-get install openjdk-14-jdk` or `sudo apt-get install openjdk-11-jdk`
- Install Android Studio: https://developer.android.com/studio
- Install Android SDK Tools (Settings > Appearance and Behaviour > System Settings > Android SDK):
  - Install Android SDK Tools (obsolete)
  - Install Android SDK Command-line Tools
- Install the Android Studio Flutter Plugin
- Install Flutter: https://flutter.dev/docs/get-started/install

## Build Process

You need to generate JSON conversion classes before running the app.

```
# Grab dependencies
flutter pub get

# Generate JSON conversion code
flutter pub run build_runner build

# Run the app on connected device
flutter run
```
