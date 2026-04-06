package io.github.telephony_context

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.telephony.TelephonyManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** Android implementation: reads [TelephonyManager] / [PackageManager] without requesting runtime permissions. */
class TelephonyContextPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == METHOD_GET_CONTEXT) {
            val ctx = applicationContext
            result.success(if (ctx != null) buildContextMap(ctx) else emptyContextMap())
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun buildContextMap(context: Context): Map<String, Any?> {
        val pm = context.packageManager
        val hasTelephonyFeature = safeHasFeature { pm.hasSystemFeature(PackageManager.FEATURE_TELEPHONY) }
        val hasTelephonySubscriptionFeature = safeHasTelephonySubscriptionFeature(pm)
        val tm = safeTelephonyManager(context)

        return mapOf(
            "simCountryIso" to safeSimCountryIso(tm),
            "networkCountryIso" to safeNetworkCountryIso(tm),
            "simOperator" to safeSimOperator(tm),
            "simOperatorName" to safeSimOperatorName(tm),
            "networkOperator" to safeNetworkOperator(tm),
            "networkOperatorName" to safeNetworkOperatorName(tm),
            "phoneType" to safePhoneType(tm),
            "hasTelephonyFeature" to hasTelephonyFeature,
            "hasTelephonySubscriptionFeature" to hasTelephonySubscriptionFeature,
            "isSupported" to true,
        )
    }

    private fun emptyContextMap(): Map<String, Any?> {
        return mapOf(
            "simCountryIso" to null,
            "networkCountryIso" to null,
            "simOperator" to null,
            "simOperatorName" to null,
            "networkOperator" to null,
            "networkOperatorName" to null,
            "phoneType" to null,
            "hasTelephonyFeature" to false,
            "hasTelephonySubscriptionFeature" to false,
            "isSupported" to true,
        )
    }

    private fun safeTelephonyManager(context: Context): TelephonyManager? {
        return try {
            context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
        } catch (e: Exception) {
            null
        }
    }

    private fun safeHasFeature(block: () -> Boolean): Boolean {
        return try {
            block()
        } catch (e: Exception) {
            false
        }
    }

    private fun safeHasTelephonySubscriptionFeature(pm: PackageManager): Boolean {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                pm.hasSystemFeature(PackageManager.FEATURE_TELEPHONY_SUBSCRIPTION)
            } else {
                pm.hasSystemFeature("android.hardware.telephony.subscription")
            }
        } catch (e: Exception) {
            false
        }
    }

    private fun safeSimCountryIso(tm: TelephonyManager?): String? {
        if (tm == null) return null
        return try {
            TelephonyMapper.normalizeSimCountryIso(tm.simCountryIso)
        } catch (e: SecurityException) {
            null
        } catch (e: Exception) {
            null
        }
    }

    private fun safeNetworkCountryIso(tm: TelephonyManager?): String? {
        if (tm == null) return null
        return try {
            TelephonyMapper.normalizeString(tm.networkCountryIso)
        } catch (e: SecurityException) {
            null
        } catch (e: Exception) {
            null
        }
    }

    private fun safeSimOperator(tm: TelephonyManager?): String? {
        if (tm == null) return null
        return try {
            TelephonyMapper.normalizeString(tm.simOperator)
        } catch (e: SecurityException) {
            null
        } catch (e: Exception) {
            null
        }
    }

    private fun safeSimOperatorName(tm: TelephonyManager?): String? {
        if (tm == null) return null
        return try {
            TelephonyMapper.normalizeString(tm.simOperatorName)
        } catch (e: SecurityException) {
            null
        } catch (e: Exception) {
            null
        }
    }

    private fun safeNetworkOperator(tm: TelephonyManager?): String? {
        if (tm == null) return null
        return try {
            TelephonyMapper.normalizeString(tm.networkOperator)
        } catch (e: SecurityException) {
            null
        } catch (e: Exception) {
            null
        }
    }

    private fun safeNetworkOperatorName(tm: TelephonyManager?): String? {
        if (tm == null) return null
        return try {
            TelephonyMapper.normalizeString(tm.networkOperatorName)
        } catch (e: SecurityException) {
            null
        } catch (e: Exception) {
            null
        }
    }

    private fun safePhoneType(tm: TelephonyManager?): String? {
        if (tm == null) return null
        return try {
            TelephonyMapper.phoneTypeToString(tm.phoneType)
        } catch (e: Exception) {
            null
        }
    }

    companion object {
        private const val CHANNEL_NAME = "telephony_context"
        private const val METHOD_GET_CONTEXT = "getContext"
    }
}
