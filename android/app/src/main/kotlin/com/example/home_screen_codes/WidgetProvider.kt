package com.example.home_screen_codes

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetProvider
import kotlinx.serialization.*
import kotlinx.serialization.json.Json

@Serializable
data class Codes(val codesDatas: List<CodeData>, val currentIndex: Int)

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
            val views = AppRemoteViews(context.packageName, R.layout.widget_layout).apply {
                // Open App on Widget Click
                this.setOnClickPendingIntent(R.id.widget_root, getLaunchIntent(context))

                val jsonCodes = widgetData.getString("_codes", null)

                if (jsonCodes != null && jsonCodes.isNotEmpty()) {
                    val parsedCodes = Json.decodeFromString<Codes>(jsonCodes)
                    if (parsedCodes.codesDatas.isNotEmpty()) {
                        updateWidgetUI(parsedCodes, parsedCodes.currentIndex)
                    }
                }

                val nextIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                        Uri.parse("myAppWidget://next"))
                 setOnClickPendingIntent(R.id.next_button, nextIntent)

                val previousIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                    Uri.parse("myAppWidget://previous"))
                setOnClickPendingIntent(R.id.previous_button, previousIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}