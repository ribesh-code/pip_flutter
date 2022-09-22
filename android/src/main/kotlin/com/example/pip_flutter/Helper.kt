package com.example.pip_flutter

import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine



open class Helper {
    private val CHANNEL = "com.example.pip_flutter"
    private  lateinit var channel: MethodChannel

    fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    }

    fun onPictureInPictureModeChanged(active: Boolean){
        if(active) {
            channel.invokeMethod("onPipEntered", null)
        } else {
            channel.invokeMethod("onPipExited", null)
        }
    }
}