import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const myvideoview = 'myVideoView';

class MyVideoView extends StatefulWidget {
  final String videoUrl;
  const MyVideoView({required this.videoUrl, super.key});

  @override
  State<MyVideoView> createState() => _MyVideoViewState();
}

class _MyVideoViewState extends State<MyVideoView> {
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    creationParams['videoUrl'] = widget.videoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(
            viewType: myvideoview,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          )
        : SizedBox();
  }
}
