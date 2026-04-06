import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'telephony_context.dart';

/// Entry point for the plugin: [getContext] and [getContextAsMap].
///
/// Fail-safe: does not throw for channel failures; on Android returns
/// [TelephonyContext.emptyAndroid], on other platforms [TelephonyContext.unsupported].
abstract final class TelephonyContextPlugin {
  TelephonyContextPlugin._();

  static const MethodChannel _channel = MethodChannel('telephony_context');

  /// Loads telephony context from Android. On non-Android, returns [TelephonyContext.unsupported].
  static Future<TelephonyContext> getContext() async {
    if (!_isAndroid) {
      return TelephonyContext.unsupported();
    }
    try {
      final Object? raw = await _channel.invokeMethod<Object?>('getContext');
      if (raw is Map) {
        try {
          return TelephonyContext.fromJson(
            Map<String, dynamic>.from(raw),
          );
        } on Object {
          return TelephonyContext.emptyAndroid();
        }
      }
      return TelephonyContext.emptyAndroid();
    } on Object {
      return TelephonyContext.emptyAndroid();
    }
  }

  /// Same as [getContext] then [TelephonyContext.toJson].
  static Future<Map<String, dynamic>> getContextAsMap() async {
    final TelephonyContext ctx = await getContext();
    return ctx.toJson();
  }

  static bool get _isAndroid {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android;
  }
}
