import 'dart:io';

import 'package:flutapp/my_video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const selectVideoChannel = MethodChannel("playVideoPlatform");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Platform.isAndroid
              ? const AndroidPlayer(
                  videoUrl:
                      "https://eab30f14a9fe.ap-south-1.playback.live-video.net/api/video/v1/ap-south-1.730335194207.channel.Rqyu1GDAcfsD.m3u8")
              : TextButton(
                  onPressed: () async {
                    try {
                      await selectVideoChannel.invokeMethod('selectVideo', {
                        'videoUrl':
                            "https://eab30f14a9fe.ap-south-1.playback.live-video.net/api/video/v1/ap-south-1.730335194207.channel.Rqyu1GDAcfsD.m3u8"
                      });
                    } on PlatformException catch (e) {
                      debugPrint("Fail: '${e.message}'.");
                    }
                  },
                  child: const Text("Select Video"),
                )
        ],
      )),
    );
  }
}

class AndroidPlayer extends StatelessWidget {
  final String videoUrl;
  const AndroidPlayer({required this.videoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: MyVideoView(videoUrl: videoUrl));
  }
}

void main() => runApp(MaterialApp(
      home: MyHomePage(),
    ));
