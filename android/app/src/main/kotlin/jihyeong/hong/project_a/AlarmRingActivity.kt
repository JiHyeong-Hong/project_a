package jihyeong.hong.project_a

import android.app.Activity
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.view.Gravity
import android.widget.LinearLayout


class AlarmRingActivity : Activity() {
    private var ringtone: Ringtone? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val textView = TextView(this).apply {
            text = "기상 알람!"
            textSize = 32f
        }

        val stopButton = Button(this).apply {
            text = "끄기"
            setOnClickListener {
                ringtone?.stop()
                finish()
            }
        }

        setContentView(
            LinearLayout(this).apply {
                orientation = LinearLayout.VERTICAL
                gravity = Gravity.CENTER
                addView(textView)
                addView(stopButton)
            }
        )

        val alarmUri: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
        ringtone = RingtoneManager.getRingtone(this, alarmUri)
        ringtone?.play()
    }

    override fun onDestroy() {
        ringtone?.stop()
        super.onDestroy()
    }
}
