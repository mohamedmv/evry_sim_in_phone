package com.example.evry_sim_in_phone

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.telephony.SubscriptionManager
import android.telephony.SubscriptionInfo
import android.telephony.TelephonyManager

import java.lang.Exception

/** EvrySimInPhonePlugin */
class EvrySimInPhonePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context :Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "evry_sim_in_phone")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext

  }


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {


    if(call.method == "sim") {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
        var sm: SubscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        try {
          var s: List<SubscriptionInfo> = sm.activeSubscriptionInfoList
          var r: String = ""
          for (info: SubscriptionInfo in s) {
            r = r + info.carrierName + "::"
          }
          result.success(r)


        } catch (ex: Exception) {
          result.success("$ex")
        }
      }
      result.success("")


    }



    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
