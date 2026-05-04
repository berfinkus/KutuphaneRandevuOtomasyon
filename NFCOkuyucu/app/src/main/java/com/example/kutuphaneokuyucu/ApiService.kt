package com.example.kutuphaneokuyucu

import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.POST

interface ApiService {

    @POST("api/nfc/check")
    suspend fun checkNfc(

        @Body request: NfcRequest

    ): Response<NfcResponse>
}