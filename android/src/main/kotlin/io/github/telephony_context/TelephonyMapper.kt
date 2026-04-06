package io.github.telephony_context

import android.telephony.TelephonyManager

/** Pure helpers for string normalization and [TelephonyManager.getPhoneType] mapping (unit-tested). */
object TelephonyMapper {
    fun normalizeString(value: String?): String? {
        if (value == null) return null
        val trimmed = value.trim()
        if (trimmed.isEmpty()) return null
        return trimmed
    }

    fun normalizeSimCountryIso(value: String?): String? {
        val n = normalizeString(value) ?: return null
        return n.lowercase()
    }

    fun phoneTypeToString(phoneType: Int): String {
        return when (phoneType) {
            TelephonyManager.PHONE_TYPE_NONE -> "none"
            TelephonyManager.PHONE_TYPE_GSM -> "gsm"
            TelephonyManager.PHONE_TYPE_CDMA -> "cdma"
            TelephonyManager.PHONE_TYPE_SIP -> "sip"
            else -> "unknown"
        }
    }
}
