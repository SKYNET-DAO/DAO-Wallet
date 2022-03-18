package com.example.example

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AppPlugin:FlutterPlugin ,MethodChannel.MethodCallHandler{
    companion object{
        const val TAG = "AppPlugin"
    }
    private var methodChannel:MethodChannel? = null
    private var binding:FlutterPlugin.FlutterPluginBinding? = null
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.binding = binding
        methodChannel = MethodChannel(binding.binaryMessenger,"com.qmstudio.qmlkit")
        methodChannel?.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.binding = null
        methodChannel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method){
            "device.getInfo"->{
                getDeviceInfo(result)
            }
        }
    }
    @SuppressLint("HardwareIds")
    private fun getDeviceInfo(result: MethodChannel.Result){
        val sysVersion = android.os.Build.VERSION.RELEASE
        val model = android.os.Build.MODEL
        val brand = android.os.Build.BRAND
        val packageManager = binding?.applicationContext?.packageManager
        var versionName = ""
        var versionCode:Long = 0
        try {
            val info = packageManager?.getPackageInfo(binding?.applicationContext?.packageName ?: "",0)
            versionName = info?.versionName ?: ""
            versionCode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                info?.longVersionCode ?: 0
            }else{
                (info?.versionCode ?: 0).toLong()
            }
        }catch (e:Exception){
        }
        val imsi:String? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            null
        }else{
            val telManager = binding?.applicationContext?.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager?
            telManager?.subscriberId
        }
        var androidId = ""
        binding?.applicationContext?.contentResolver.let {
            androidId = Settings.System.getString(it,Settings.Secure.ANDROID_ID)
        }

        result.success(mapOf(
            "sysVersion" to sysVersion,
            "model" to model,
            "sysName" to "Android",
            "localizedModel" to model,
            "name" to "${android.os.Build.MANUFACTURER} $model",
            "brand" to brand,
            "appVersion" to "$versionName+$versionCode",
            "uuid" to (imsi ?: androidId)
        ))
    }
}