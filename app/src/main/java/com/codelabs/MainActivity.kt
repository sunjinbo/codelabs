package com.codelabs

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun onCameraXClick(view: View) {
        val intent = Intent(this, CameraXActivity::class.java)
        startActivity(intent)
    }

    fun onDataStoreClick(view: View) {
        val intent = Intent(this, DataStoreActivity::class.java)
        startActivity(intent)
    }
}
