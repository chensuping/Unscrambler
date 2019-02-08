package com.spchen.unscrambler

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import com.google.android.gms.ads.MobileAds;

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MobileAds.initialize(this,"ca-app-pub-7821168080202935~6933403773")
  }
}
