package com.example.flutapp

import android.app.Activity
import android.content.Context
import android.net.Uri
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.media3.common.MediaItem
import androidx.media3.common.util.UnstableApi
import androidx.media3.datasource.DefaultHttpDataSource
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.hls.HlsMediaSource
import androidx.media3.ui.PlayerView
import io.flutter.plugin.platform.PlatformView

@UnstableApi
class MyVideoView(
        private val context: Context,
        id: Int,
        creationParams: Map<String?, Any?>?,
        private val activity: Activity
) : PlatformView {
    private val linearLayout: LinearLayout = LinearLayout(context)
    private var player: ExoPlayer? = null
    private var playWhenReady = true
    private var currentItem = 0
    private var playbackPosition = 0L
    private var playerView: PlayerView

    override fun getView(): View {
        return linearLayout
    }

    override fun dispose() {
        releasePlayer()
    }

    init {
        val layoutParams: ViewGroup.LayoutParams =
                ViewGroup.LayoutParams(
                        ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.MATCH_PARENT,
                )
        linearLayout.layoutParams = layoutParams

        playerView = PlayerView(context)
        playerView.layoutParams = layoutParams
        linearLayout.addView(playerView)
        setUpPlayer(creationParams?.get("videoUrl").toString())
    }

    private fun setUpPlayer(url: String) {
        player =
                ExoPlayer.Builder(context).build().also { exoPlayer ->
                    val dataResourceFactory = DefaultHttpDataSource.Factory()
                    val uri = Uri.Builder().encodedPath(url).build()
                    val mediaItem = MediaItem.Builder().setUri(uri).build()
                    val internetVideoSource =
                            HlsMediaSource.Factory(dataResourceFactory).createMediaSource(mediaItem)
                    playerView.player = exoPlayer

                    exoPlayer.setMediaSource(internetVideoSource)
                    exoPlayer.playWhenReady = playWhenReady
                    exoPlayer.seekTo(currentItem, playbackPosition)
                    exoPlayer.prepare()
                }
        hideSystemUi()
    }

    private fun hideSystemUi() {
        WindowCompat.setDecorFitsSystemWindows(activity.window, false)
        val controller = WindowInsetsControllerCompat(activity.window, activity.window.decorView)
        controller.hide(WindowInsetsCompat.Type.systemBars())
        controller.systemBarsBehavior = 
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
    }

    private fun releasePlayer() {
        player?.let { exoPlayer: ExoPlayer ->
            playbackPosition = exoPlayer.currentPosition
            currentItem = exoPlayer.currentMediaItemIndex
            playWhenReady = exoPlayer.playWhenReady
            exoPlayer.release()
        }
        player = null
    }
}