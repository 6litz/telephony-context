# Contributing

## Repository URLs

Canonical repository: [github.com/6litz/telephony-context](https://github.com/6litz/telephony-context). If you fork, update `homepage`, `repository`, and `issue_tracker` in [pubspec.yaml](pubspec.yaml) before publishing to pub.dev.

## Setup

```bash
flutter pub get
cd example && flutter pub get
```

## Checks

From the repository root:

```bash
flutter analyze
flutter test
```

Example app:

```bash
cd example
flutter test
flutter run   # Android device or emulator
```

Android unit tests for Kotlin helpers (from `example/android` with a JDK supported by the Android Gradle Plugin, e.g. 17 or 21):

```bash
cd example/android
./gradlew :telephony_context:testDebugUnitTest
```

## Pull requests

- Keep changes focused; match existing style.
- Update [CHANGELOG.md](CHANGELOG.md) under an `## Unreleased` or new version section for user-visible changes.
- Ensure `flutter analyze` and `flutter test` pass.

## Publishing (maintainers)

1. Bump `version` in [pubspec.yaml](pubspec.yaml) and finalize [CHANGELOG.md](CHANGELOG.md).
2. `dart pub publish --dry-run`
3. `dart pub publish`
4. Tag the release (e.g. `v0.1.0`) and create a GitHub Release.
