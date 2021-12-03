package com.codelabs.codelabs

import android.os.BatteryManager
import android.os.Build

import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.codelabs.codelabs/battery"

    private var tips = ""

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("mynativeview", MyViewFactory())

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler {
                methodCall: MethodCall, result: MethodChannel.Result ->
            if (methodCall.method.equals("getBatteryLevel")) {
                var batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available", null)
                }
            } else if (methodCall.method.equals("setTips")) {
                getTipsFromFlutter(flutterEngine)
                result.success(null)
            } else if (methodCall.method.equals("getTips")) {
                result.success(tips)
            } else {
                result.notImplemented()
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getBatteryLevel(): Int {
        var batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    private fun getTipsFromFlutter(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).invokeMethod("getFlutterTips", null,
            object : MethodChannel.Result {
                override fun success(result: Any?) {
                    tips = result as String
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {

                }

                override fun notImplemented() {

                }
            })
    }
}
