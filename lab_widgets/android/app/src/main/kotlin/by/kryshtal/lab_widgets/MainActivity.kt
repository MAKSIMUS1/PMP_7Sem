package by.kryshtal.lab_widgets

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import android.location.Location

class MainActivity : FlutterActivity() {
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private val CHANNEL = "com.example/geolocation"
    private val BATTERY_CHANNEL = "com.example/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getGeolocation" -> getGeolocation(result)
                "openEmailApp" -> {
                    val subject = call.argument<String>("subject") ?: ""
                    openEmailApp(subject, result)
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> getBatteryLevel(result)
                "observeBatteryLevel" -> observeBatteryLevel(result)
                else -> result.notImplemented()
            }
        }
    }

    private fun getGeolocation(result: MethodChannel.Result) {
        fusedLocationClient.lastLocation
            .addOnSuccessListener { location: Location? ->
                if (location != null) {
                    result.success("${location.latitude}, ${location.longitude}")
                } else {
                    result.error("UNAVAILABLE", "Location not available", null)
                }
            }
    }

    private fun openEmailApp(subject: String, result: MethodChannel.Result) {
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_SUBJECT, subject)
        }

        if (intent.resolveActivity(packageManager) != null) {
            startActivity(Intent.createChooser(intent, "Choose Email Client"))
            result.success("Email app opened successfully")
        } else {
            result.error("UNAVAILABLE", "No email client found", null)
        }
    }

    private fun getBatteryLevel(result: MethodChannel.Result) {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        val batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        if (batteryLevel != -1) {
            result.success(batteryLevel)
        } else {
            result.error("UNAVAILABLE", "Battery level not available", null)
        }
    }

    private fun observeBatteryLevel(result: MethodChannel.Result) {
        val batteryLevelReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
                val scale = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
                if (level != -1 && scale != -1) {
                    val batteryPercentage = (level.toFloat() / scale.toFloat()) * 100
                    result.success(batteryPercentage.toInt())
                } else {
                    result.error("UNAVAILABLE", "Unable to retrieve battery level", null)
                }
            }
        }
        val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        registerReceiver(batteryLevelReceiver, intentFilter)
    }
}
