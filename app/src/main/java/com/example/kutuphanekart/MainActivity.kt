package com.example.kutuphanekart

import android.content.Context
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val sharedPref = getSharedPreferences(
            "KullaniciOturumu",
            Context.MODE_PRIVATE
        )

        sharedPref.edit()
            .putString("ogrenci_no", "2026105020")
            .putString("token", "jwt_token_123")
            .apply()

        findViewById<Button>(R.id.btnAktif)
            .setOnClickListener {

                finish()
            }
    }
}