package com.example.kutuphaneokuyucu

import android.graphics.Color
import android.nfc.NfcAdapter
import android.nfc.Tag
import android.nfc.tech.IsoDep
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import java.io.IOException

class MainActivity : AppCompatActivity(), NfcAdapter.ReaderCallback {

    private var nfcAdapter: NfcAdapter? = null
    private lateinit var tvDurum: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tvDurum = findViewById(R.id.textViewDurum)
        nfcAdapter = NfcAdapter.getDefaultAdapter(this)

        if (nfcAdapter == null) {
            tvDurum.text = "Cihazda NFC desteği yok"
        }
    }

    override fun onResume() {
        super.onResume()
        nfcAdapter?.enableReaderMode(
            this,
            this,
            NfcAdapter.FLAG_READER_NFC_A or NfcAdapter.FLAG_READER_SKIP_NDEF_CHECK,
            null
        )
    }

    override fun onPause() {
        super.onPause()
        nfcAdapter?.disableReaderMode(this)
    }

    override fun onTagDiscovered(tag: Tag?) {
        val isoDep = IsoDep.get(tag)

        if (isoDep != null) {
            try {
                isoDep.connect()

                val sabitTestID = "02230224057"

                runOnUiThread {
                    tvDurum.text = "Giriş Onaylandı \nNo: $sabitTestID"
                    tvDurum.setTextColor(Color.GREEN)
                }

            } catch (e: Exception) {
                runOnUiThread {
                    tvDurum.text = "Bağlantı Hatası\n${e.localizedMessage}"
                    tvDurum.setTextColor(Color.RED)
                }
            } finally {
                try {
                    isoDep.close()
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }
        }
    }
}