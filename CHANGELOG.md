# Changelog

## 0.1.0

- Android Maven / Kotlin package: `io.github.telephony_context` (not `com.example`).
- Initial release: Android `TelephonyContextPlugin.getContext()` via `MethodChannel`, Kotlin implementation using `TelephonyManager` and `PackageManager` without declaring sensitive runtime permissions.
- `TelephonyContext` with `toJson` / `fromJson`, `getContextAsMap()`, and optional `toJsonWithCollectedAt()` (Dart-side timestamp).
- Dart unit tests for JSON and `phoneType` strings; Android unit tests for `TelephonyMapper` (normalization and phone type mapping).
- Example app under `example/`.
