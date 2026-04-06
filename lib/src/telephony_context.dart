/// Structured telephony / SIM context for antifraud-style signals (Android only).
class TelephonyContext {
  const TelephonyContext({
    required this.simCountryIso,
    required this.networkCountryIso,
    required this.simOperator,
    required this.simOperatorName,
    required this.networkOperator,
    required this.networkOperatorName,
    required this.phoneType,
    required this.hasTelephonyFeature,
    required this.hasTelephonySubscriptionFeature,
    required this.isSupported,
  });

  final String? simCountryIso;
  final String? networkCountryIso;
  final String? simOperator;
  final String? simOperatorName;
  final String? networkOperator;
  final String? networkOperatorName;

  /// Normalized labels: `none`, `gsm`, `cdma`, `sip`, `unknown`.
  final String? phoneType;

  final bool hasTelephonyFeature;
  final bool hasTelephonySubscriptionFeature;

  /// `true` when running on Android and the platform channel returned data;
  /// `false` on non-Android platforms or if the channel call failed.
  final bool isSupported;

  /// Non-Android platforms (or explicit unsupported).
  factory TelephonyContext.unsupported() => const TelephonyContext(
        simCountryIso: null,
        networkCountryIso: null,
        simOperator: null,
        simOperatorName: null,
        networkOperator: null,
        networkOperatorName: null,
        phoneType: null,
        hasTelephonyFeature: false,
        hasTelephonySubscriptionFeature: false,
        isSupported: false,
      );

  /// Android: channel error or invalid payload — still treated as Android-supported, empty fields.
  factory TelephonyContext.emptyAndroid() => const TelephonyContext(
        simCountryIso: null,
        networkCountryIso: null,
        simOperator: null,
        simOperatorName: null,
        networkOperator: null,
        networkOperatorName: null,
        phoneType: null,
        hasTelephonyFeature: false,
        hasTelephonySubscriptionFeature: false,
        isSupported: true,
      );

  factory TelephonyContext.fromJson(Map<String, dynamic> json) {
    return TelephonyContext(
      simCountryIso: json['simCountryIso'] as String?,
      networkCountryIso: json['networkCountryIso'] as String?,
      simOperator: json['simOperator'] as String?,
      simOperatorName: json['simOperatorName'] as String?,
      networkOperator: json['networkOperator'] as String?,
      networkOperatorName: json['networkOperatorName'] as String?,
      phoneType: json['phoneType'] as String?,
      hasTelephonyFeature: _readBool(json['hasTelephonyFeature'], false),
      hasTelephonySubscriptionFeature:
          _readBool(json['hasTelephonySubscriptionFeature'], false),
      isSupported: _readBool(json['isSupported'], false),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'simCountryIso': simCountryIso,
        'networkCountryIso': networkCountryIso,
        'simOperator': simOperator,
        'simOperatorName': simOperatorName,
        'networkOperator': networkOperator,
        'networkOperatorName': networkOperatorName,
        'phoneType': phoneType,
        'hasTelephonyFeature': hasTelephonyFeature,
        'hasTelephonySubscriptionFeature': hasTelephonySubscriptionFeature,
        'isSupported': isSupported,
      };

  static bool _readBool(Object? value, bool fallback) {
    if (value is bool) return value;
    return fallback;
  }
}

/// Optional: attach a collection timestamp on the Dart side (not from Android).
extension TelephonyContextCollectedAt on TelephonyContext {
  Map<String, dynamic> toJsonWithCollectedAt({DateTime? at}) {
    final Map<String, dynamic> base = Map<String, dynamic>.from(toJson());
    base['collectedAt'] = (at ?? DateTime.now()).toUtc().toIso8601String();
    return base;
  }
}
