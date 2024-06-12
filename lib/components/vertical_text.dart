// 垂直文本 widget
import 'package:flutter/material.dart';

class VerticalText extends StatefulWidget {
  const VerticalText(
      {super.key,
      required this.textContent,
      required this.from,
      required this.numberOfSingleLineText,
      required this.singleLineWidth});

  final String textContent; // 要显示的文本
  final String from; // 来源谁
  final int numberOfSingleLineText; // 每列的文字数量
  final double singleLineWidth; // 每列的显示宽度

  @override
  State<StatefulWidget> createState() => VerticalTextState();
}

class VerticalTextState extends State<VerticalText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numberOfLines = // 计算有几列
        widget.textContent.length ~/ widget.numberOfSingleLineText;
    if (widget.textContent.length % widget.numberOfSingleLineText > 0) {
      numberOfLines++;
    }
    List<Widget> allTextLine = [];
    for (int i = 0; i < numberOfLines; i++) {
      String singleLineText = '';
      singleLineText = widget.textContent.substring(
          widget.numberOfSingleLineText * i,
          i < numberOfLines - 1
              ? widget.numberOfSingleLineText * (i + 1)
              : widget.textContent.length);
      allTextLine.add(Container(
        margin: const EdgeInsets.only(left: 10),
        width: widget.singleLineWidth,
        child: Text(
          singleLineText,
          style: TextStyle(fontSize: widget.singleLineWidth + 1),
          textAlign: TextAlign.left,
        ),
      ));
    }
    for (int i = 0; i < allTextLine.length / 2; i++) {
      Widget temp = allTextLine[i];
      allTextLine[i] = allTextLine[allTextLine.length - i - 1];
      allTextLine[allTextLine.length - i - 1] = temp;
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40, bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: allTextLine,
          ),
        ),
        Text(
          '- ${widget.from} -',
          style: TextStyle(fontSize: widget.numberOfSingleLineText + 1),
        )
      ],
    );
  }
}
