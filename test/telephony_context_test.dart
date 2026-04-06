import 'package:flutter_test/flutter_test.dart';
import 'package:telephony_context/telephony_context.dart';

void main() {
  group('TelephonyContext', () {
    test('toJson roundtrip', () {
      const TelephonyContext ctx = TelephonyContext(
        simCountryIso: 'us',
        networkCountryIso: 'gb',
        simOperator: '23415',
        simOperatorName: 'Test',
        networkOperator: '23415',
        networkOperatorName: 'Test Net',
        phoneType: 'gsm',
        hasTelephonyFeature: true,
        hasTelephonySubscriptionFeature: false,
        isSupported: true,
      );
      final TelephonyContext back =
          TelephonyContext.fromJson(Map<String, dynamic>.from(ctx.toJson()));
      expect(back.simCountryIso, 'us');
      expect(back.networkCountryIso, 'gb');
      expect(back.simOperator, '23415');
      expect(back.simOperatorName, 'Test');
      expect(back.networkOperator, '23415');
      expect(back.networkOperatorName, 'Test Net');
      expect(back.phoneType, 'gsm');
      expect(back.hasTelephonyFeature, isTrue);
      expect(back.hasTelephonySubscriptionFeature, isFalse);
      expect(back.isSupported, isTrue);
    });

    test('fromJson null string fields', () {
      final TelephonyContext ctx = TelephonyContext.fromJson(<String, dynamic>{
        'simCountryIso': null,
        'networkCountryIso': null,
        'simOperator': null,
        'simOperatorName': null,
        'networkOperator': null,
        'networkOperatorName': null,
        'phoneType': null,
        'hasTelephonyFeature': false,
        'hasTelephonySubscriptionFeature': false,
        'isSupported': true,
      });
      expect(ctx.simCountryIso, isNull);
      expect(ctx.phoneType, isNull);
      expect(ctx.hasTelephonyFeature, isFalse);
      expect(ctx.isSupported, isTrue);
    });

    test('fromJson bool fallbacks when missing', () {
      final TelephonyContext ctx = TelephonyContext.fromJson(<String, dynamic>{});
      expect(ctx.hasTelephonyFeature, isFalse);
      expect(ctx.hasTelephonySubscriptionFeature, isFalse);
      expect(ctx.isSupported, isFalse);
    });

    test('phoneType enum-like strings preserved', () {
      const TelephonyContext gsm = TelephonyContext(
        simCountryIso: null,
        networkCountryIso: null,
        simOperator: null,
        simOperatorName: null,
        networkOperator: null,
        networkOperatorName: null,
        phoneType: 'gsm',
        hasTelephonyFeature: true,
        hasTelephonySubscriptionFeature: true,
        isSupported: true,
      );
      expect(gsm.toJson()['phoneType'], 'gsm');
    });

    test('toJsonWithCollectedAt adds collectedAt', () {
      const TelephonyContext ctx = TelephonyContext(
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
      final DateTime fixed = DateTime.utc(2026, 4, 7, 12);
      final Map<String, dynamic> m = ctx.toJsonWithCollectedAt(at: fixed);
      expect(m['collectedAt'], fixed.toIso8601String());
      expect(m['isSupported'], isFalse);
    });
  });
}
