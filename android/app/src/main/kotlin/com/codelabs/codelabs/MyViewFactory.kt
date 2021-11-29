package com.codelabs.codelabs

import android.content.Context
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec

import io.flutter.plugin.common.BinaryMessenger

class MyViewFactory(private var messenger: BinaryMessenger?) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String?, Any?>
        return MyView(context, messenger, viewId, params)
    }
}
