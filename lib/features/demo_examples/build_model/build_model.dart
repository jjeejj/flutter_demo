import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel("iyi.com/getAndroidBuildModel");

class BuildModelPage extends StatefulWidget {
  const BuildModelPage({super.key});

  @override
  State<StatefulWidget> createState() => _BuildModelPage();
}

class _BuildModelPage extends State<BuildModelPage> {
  String androidBuildModel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(androidBuildModel),
            TextButton(
              onPressed: getAndroidBuildModelInfo,
              child: const Text("获取 Build Model 信息"),
            )
          ],
        ),
      ),
    );
  }

  getAndroidBuildModelInfo() async {
    try {
      androidBuildModel = await platform.invokeMethod("getBuildModel");
    } on PlatformException catch (e) {
      androidBuildModel = "无法获取 Build Model";
    }
    setState(() {});
  }
}
