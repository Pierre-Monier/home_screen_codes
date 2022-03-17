package com.example.home_screen_codes

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import kotlinx.serialization.*
import kotlinx.serialization.json.Json

@Serializable
data class Codes(val codesDatas: List<CodeData>)

@Serializable
data class CodeData(val imagePath: String, val labelText: String)

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java
                )
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                // !look at this code, it's getting data from home_widget plugins!
                val codes = widgetData.getString("_codes", null);

                if (codes != null && codes.isNotEmpty()) {
                    var codes = Json.decodeFromString<Codes>(codes);
                    if (codes.codesDatas.isNotEmpty()) {
                        val myBitmap = BitmapFactory.decodeFile(codes.codesDatas.first().imagePath)
                        setImageViewBitmap(R.id.image_toto, myBitmap);
                    }
                }


                // Pending intent to update counter on button click
                //val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                //        Uri.parse("myAppWidget://updatecounter"))
                // setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}