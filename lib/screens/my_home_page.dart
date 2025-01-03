import 'dart:io';

import 'package:flutapp/screens/intro_screen.dart';
import 'package:flutapp/widgets/android_player.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        leading: Icon(Icons.camera),
        title: Text(
          "AWS IVS Client",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Platform.isAndroid
              ? IntroScreen()
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
