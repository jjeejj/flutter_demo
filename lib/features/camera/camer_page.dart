import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/features/camera/video_player_page.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController; // 相机控制器

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) =>
        camera.lensDirection == CameraLensDirection.front); // 获取前置摄像头
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() {
      _isLoading = false;
    });
  }

  void initState() {
    super.initState();
    _initCamera();
  }

  _recordVideo() async {
    if (_isRecording) {
      // 关闭录视频
      final file = await _cameraController.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });
      // 播放视频
      final route = MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) {
            return VideoPlayerPage(filePath: file.path);
          });
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('相机功能'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            tooltip: '返回',
          ),
        ),
        body: Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('相机功能'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            tooltip: '返回',
          ),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(
                    _isRecording ? Icons.stop : HugeIcons.strokeRoundedRecord,
                    color: Colors.red,
                    size: 24.0,
                  ),
                  onPressed: () => _recordVideo(),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
