package com.codelabs.codelabs

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.BinaryMessenger

class MyView : PlatformView {
    private lateinit var myNativeView: TextView

    constructor(
        context: Context?,
        id: Int,
        params: Map<String?, Any?>?
    ) {
        myNativeView = TextView(context)
        myNativeView.textSize = 38.0.toFloat()
        myNativeView.text = "Android Native View"
    }

    override fun getView(): View? {
        return myNativeView
    }

    override fun dispose() {}
}
