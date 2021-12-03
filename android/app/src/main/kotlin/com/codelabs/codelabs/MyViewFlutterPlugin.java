package com.codelabs.codelabs;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.platform.PlatformViewRegistry;

public class MyViewFlutterPlugin implements FlutterPlugin {

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        PlatformViewRegistry registry = binding.getPlatformViewRegistry();
        registry.registerViewFactory(
                "mynativeview",
                new MyViewFactory());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }
}
