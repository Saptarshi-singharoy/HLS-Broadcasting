import 'package:flutapp/widgets/my_video_view.dart';
import 'package:flutter/material.dart';

class AndroidPlayer extends StatelessWidget {
  final String videoUrl;
  const AndroidPlayer({required this.videoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: MyVideoView(videoUrl: videoUrl));
  }
}
