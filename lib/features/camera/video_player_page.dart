import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/shared/utils/logger.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String filePath; // 文件路径
  const VideoPlayerPage({super.key, required this.filePath});
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _controller = VideoPlayerController.file(File(widget.filePath));
    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
              onPressed: () {
                LoggerHelper.i("do something with the file");
              },
              icon: const Icon(Icons.check))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_controller);
          }
        },
      ),
    );
  }
}
