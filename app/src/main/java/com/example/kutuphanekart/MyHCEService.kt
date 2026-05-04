package com.example.kutuphanekart

import android.content.Context
import android.nfc.cardemulation.HostApduService
import android.os.Bundle
import org.json.JSONObject

class MyHCEService : HostApduService() {

    override fun processCommandApdu(
        commandApdu: ByteArray?,
        extras: Bundle?
    ): ByteArray {

        if (
            commandApdu != null &&
            commandApdu.isNotEmpty()
        ) {

            val sharedPref = getSharedPreferences(
                "KullaniciOturumu",
                Context.MODE_PRIVATE
            )

            val ogrenciNo = sharedPref.getString(
                "ogrenci_no",
                "ID_YOK"
            ) ?: "ID_YOK"

            val token = sharedPref.getString(
                "token",
                "TOKEN_YOK"
            ) ?: "TOKEN_YOK"

            val json = JSONObject()

            json.put("ogrenci_no", ogrenciNo)
            json.put("token", token)
            json.put("timestamp", System.currentTimeMillis())

            return json.toString()
                .toByteArray(Charsets.UTF_8)
        }

        return byteArrayOf(
            0x6A.toByte(),
            0x82.toByte()
        )
    }

    override fun onDeactivated(reason: Int) {}
}