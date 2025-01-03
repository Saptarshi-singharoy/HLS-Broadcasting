package com.example.flutapp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine?.platformViewsController?.registry?.registerViewFactory(
                "myVideoView",
                MyVideoViewFactory(this)
        )
    }
}
