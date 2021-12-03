package com.codelabs.codelabs

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MyViewFactory : PlatformViewFactory {

    constructor() : super(StandardMessageCodec.INSTANCE)

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>
        return MyView(context, viewId, creationParams)
    }
}