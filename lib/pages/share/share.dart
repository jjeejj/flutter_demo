import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wechat_demo/utils/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SharePage extends StatelessWidget {
  final GlobalKey _screeShotKey = GlobalKey();

  SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: _screeShotKey,
        child: GestureDetector(
          onTap: () {
            _save();
          },
          child: const Text("截图"),
        ));
  }

  Future<ByteData?> _capturePngToByteData() async {
    try {
      RenderRepaintBoundary boundary = _screeShotKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      double dpr = ui.window.devicePixelRatio;
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData;
    } catch (e) {
      // LoggerHelper.e("_capturePngToByteData err", error: e);
    }
    return null;
  }

  void _save() async {
    ByteData? byteData = await _capturePngToByteData();
    Uint8List sourceBytes = byteData!.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    String storePath = tempDir.path;
    File file = File('$storePath/fs.png');
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsBytesSync(sourceBytes);

    // 分享
    Share.shareXFiles([XFile('$storePath/fs.png')]);
  }
}
