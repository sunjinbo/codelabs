package com.codelabs.codelabs

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.BinaryMessenger

class MyView : PlatformView {
    private var myNativeView: TextView? = null

    constructor(
        context: Context?,
        messenger: BinaryMessenger?,
        id: Int,
        params: Map<String?, Any?>?
    ) {
        val myNativeView = TextView(context)
        myNativeView.text = "Android Native View"
        this.myNativeView = myNativeView
    }

    override fun getView(): View? {
        return myNativeView
    }

    override fun dispose() {}
}
