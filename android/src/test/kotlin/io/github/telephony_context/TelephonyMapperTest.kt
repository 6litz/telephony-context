package io.github.telephony_context

import android.telephony.TelephonyManager
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull

class TelephonyMapperTest {
    @Test
    fun normalizeString_nullBlank() {
        assertNull(TelephonyMapper.normalizeString(null))
        assertNull(TelephonyMapper.normalizeString(""))
        assertNull(TelephonyMapper.normalizeString("   "))
    }

    @Test
    fun normalizeString_trims() {
        assertEquals("a", TelephonyMapper.normalizeString(" a "))
    }

    @Test
    fun normalizeSimCountryIso_lowercases() {
        assertEquals("us", TelephonyMapper.normalizeSimCountryIso("US"))
    }

    @Test
    fun phoneType_mapsConstants() {
        assertEquals("none", TelephonyMapper.phoneTypeToString(TelephonyManager.PHONE_TYPE_NONE))
        assertEquals("gsm", TelephonyMapper.phoneTypeToString(TelephonyManager.PHONE_TYPE_GSM))
        assertEquals("cdma", TelephonyMapper.phoneTypeToString(TelephonyManager.PHONE_TYPE_CDMA))
        assertEquals("sip", TelephonyMapper.phoneTypeToString(TelephonyManager.PHONE_TYPE_SIP))
        assertEquals("unknown", TelephonyMapper.phoneTypeToString(999))
    }
}
