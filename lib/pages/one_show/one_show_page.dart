import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wechat_demo/gen/assets.gen.dart';

class OneShowPage extends StatefulWidget {
  const OneShowPage({super.key});

  @override
  State<StatefulWidget> createState() => _OneShowPageState();
}

class _OneShowPageState extends State<OneShowPage> {
  Widget textWidget(String text) {
    return Text(text);
  }

  Widget imageWidget() {
    return  Stack(
      children: [
        Image.asset(Assets.images.topOne.path),
        const CircleAvatar(
          backgroundColor: Colors.white70,
          foregroundImage: NetworkImage(
              'https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302'),
          radius: 60,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[textWidget("文本"), imageWidget()],
      ),
    ));
  }
}
