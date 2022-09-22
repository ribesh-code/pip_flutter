package com.example.pip_flutter


import android.content.res.Configuration
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.example.pip_flutter.Helper

open class HelperActivityWrapper: FlutterActivity() {
    private var helper = Helper()

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        helper.configureFlutterEngine(flutterEngine)
    }

    override fun onPictureInPictureModeChanged(active: Boolean, newConfig: Configuration?){
        super.onPictureInPictureModeChanged(active, newConfig)
        helper.onPictureInPictureModeChanged(active)
    }
}