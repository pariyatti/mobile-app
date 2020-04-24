# patta [m.]: _leaf; alms bowl; attained_

The Pariyatti mobile app.

## Design

- [Design Docs & Wireframes](https://drive.google.com/drive/folders/1Iga6z-5tndLJ411XG5ibimLwNC5VZDVv?usp=sharing) (public)

## Dev Setup

- Install Android Studio: https://developer.android.com/studio
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
