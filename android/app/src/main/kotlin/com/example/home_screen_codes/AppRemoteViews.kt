package com.example.home_screen_codes

import android.app.PendingIntent
import android.content.Context
import android.graphics.BitmapFactory
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class AppRemoteViews( packageName: String, id: Int): RemoteViews(packageName, id) {

    fun getLaunchIntent(context: Context): PendingIntent {
        return HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java
        )
    }

    fun updateWidgetUI(codes: Codes, index: Int) {
        val codeData = codes.codesDatas[index]

        setButtonsVisibility(codes.codesDatas.size)
        setImage(codeData.imagePath)
        setLabelText(codeData.labelText)
    }

    private fun setLabelText(labelText: String) {
        setTextViewText(
            R.id.label_text,
            labelText
        )
    }

    private fun setImage(imagePath: String) {
        val bitmapOptions = BitmapFactory.Options()
        bitmapOptions.inSampleSize = 4
        val bitmap = BitmapFactory.decodeFile(imagePath, bitmapOptions)
        setImageViewBitmap(R.id.image, bitmap)
    }

    private fun setButtonsVisibility(codesDatasSize: Int) {
        val buttonViewVisibility = getButtonVisibility(codesDatasSize)
        setViewVisibility(R.id.previous_button, buttonViewVisibility)
        setViewVisibility(R.id.next_button, buttonViewVisibility)
    }

    private fun getButtonVisibility(codesDatasSize: Int): Int  {
        return if (codesDatasSize <= 1) {
            View.INVISIBLE
        } else {
            View.VISIBLE
        }
    }
}