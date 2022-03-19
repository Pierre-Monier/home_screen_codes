package com.example.home_screen_codes

import android.app.PendingIntent
import android.content.Context
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent

import android.graphics.Bitmap
import com.bumptech.glide.Glide


class AppRemoteViews( packageName: String, id: Int): RemoteViews(packageName, id) {

    fun getLaunchIntent(context: Context): PendingIntent {
        return HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java
        )
    }

    fun updateWidgetUI(codes: Codes, index: Int, context: Context) {
        val codeData = codes.codesDatas[index]
        val bitmapOptions = BitmapFactory.Options()
        bitmapOptions.inSampleSize = 4
        val bitmap = BitmapFactory.decodeFile(codeData.imagePath, bitmapOptions)

//        val bitmap: Bitmap = Glide.with(context)
//            .asBitmap()
//            .load(codeData.imagePath)
//            .override(480, 342).submit().get()

        setImageViewBitmap(R.id.image, bitmap)

        setTextViewText(
            R.id.label_text,
            getLabelText(
                codesLength = codes.codesDatas.size,
                currentIndex = index,
                labelText = codeData.labelText
            )
        )

//        if (codes.codesDatas.size <= 1) {
//            setIcon
//        }
    }

    private fun getLabelText(codesLength: Int, currentIndex: Int, labelText: String): String {
        return "$labelText - ${currentIndex+1}/$codesLength"
    }
}