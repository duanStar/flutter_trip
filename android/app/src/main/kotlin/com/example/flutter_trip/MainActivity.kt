package com.example.flutter_trip

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.duanhf.flutter.plugin.asr.AsrPlugin

import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import org.devio.flutter.splashscreen.SplashScreen


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
        //flutter sdk >= v1.12.13+hotfix.5 时使用下面方法注册自定义plugin
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine)
        AsrPlugin.registerWith(shimPluginRegistry.registrarFor("com.duanhf.flutter.plugin.asr.AsrPlugin"))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
//        SplashScreen.show(this, true);
        super.onCreate(savedInstanceState)
    }
}
