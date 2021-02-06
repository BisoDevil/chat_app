package com.innovationcodes.chat_app


import androidx.annotation.NonNull
import com.tekartik.sqflite.SqflitePlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin

import io.flutter.plugins.pathprovider.PathProviderPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
//        flutterEngine.plugins.add(PathProviderPlugin())
//        flutterEngine.plugins.add(SqflitePlugin())
//        flutterEngine.plugins.add(FlutterFirebaseCorePlugin())
    }

}
