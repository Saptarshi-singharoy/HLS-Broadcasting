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

class AndroidPlayer extends StatelessWidget {
  final String videoUrl;
  const AndroidPlayer({required this.videoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: MyVideoView(videoUrl: videoUrl));
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: Icon(Icons.clear))),
          ),
          MaterialButton(
            color: Colors.amber[600],
            onPressed: () {
              if (_controller.text != null || _controller.text.isNotEmpty) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => AndroidPlayer(
                            videoUrl: _controller.text,
                          )),
                );
              }
            },
            child: Text('Watch'),
          )
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: MyHomePage(),
    ));
