import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wechat_demo/utils/logger.dart';
import 'package:http/http.dart' as http;

import '../../components/vertical_text.dart';

class OneShowPage extends StatefulWidget {
  OneShowPage({super.key});

  bool darkModelOn = false;
  bool customTheme = false; // 是否自定义修改了主题
  String textContent = '';
  String from = '';

  @override
  State<StatefulWidget> createState() => _OneShowPageState();
}

class _OneShowPageState extends State<OneShowPage> with WidgetsBindingObserver {
  Brightness _platformBrightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    loadTextContent();
    WidgetsBinding.instance.addObserver(this);
    _updateBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _updateBrightness() {
    setState(() {
      _platformBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
    });
  }

  @override
  void didChangePlatformBrightness() {
    _updateBrightness();
    if (!widget.customTheme) {
      setState(() {
        if (_platformBrightness.name == "light") {
          widget.darkModelOn = false;
        } else {
          widget.darkModelOn = true;
        }
      });
    }
  }

  Widget textWidget() {
    // return Text(widget.textContent + widget.from);
    return AnimatedOpacity(
      opacity: widget.textContent != '' ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 2000),
      curve: Curves.ease,
      child: AnimatedRotation(
        turns: widget.textContent != '' ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 2000),
        child: InkWell(
          child: VerticalText(
            textContent: widget.textContent,
            from: widget.from,
            singleLineWidth: 16,
            numberOfSingleLineText: 10,
          ),
          onTap: () {
            loadTextContent();
          },
        ),
      ),
    );
  }

  Widget darkModel() {
    return Positioned(
        right: 20,
        top: 40,
        child: SizedBox(
          width: 30,
          height: 30,
          child: ElevatedButton(
            // style: ButtonStyle(
            //   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            //       const EdgeInsets.all(0)),
            // ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: () {
              setState(() {
                widget.darkModelOn = !widget.darkModelOn;
              });
            },
            child: Icon(
              widget.darkModelOn ? Icons.dark_mode_outlined : Icons.dark_mode,
              size: 25,
            ),
          ),
        ));
  }

  Widget imageWidget() {
    return const Stack(
      children: [
        // Image.asset(Assets.images.topOne.path),
        CircleAvatar(
          backgroundColor: Colors.white70,
          foregroundImage: NetworkImage(
              'https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302'),
          radius: 60,
        )
      ],
    );
  }

  // 加载请求接口返回文本
  void loadTextContent() async {
    var url = Uri.parse('https://international.v1.hitokoto.cn/?c=i');
    var response = await http.get(url);
    LoggerHelper.d(response.body);
    Map<String, dynamic> respData = jsonDecode(response.body);
    setState(() {
      widget.textContent = respData['hitokoto'];
      widget.from = respData['from_who'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[imageWidget(), textWidget()],
          ),
        ),
        darkModel()
      ],
    ));
  }
}
