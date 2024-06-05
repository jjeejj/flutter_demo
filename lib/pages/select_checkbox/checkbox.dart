import 'package:flutter/material.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({super.key});

  @override
  State<StatefulWidget> createState() => _CheckBoxPage();
}

class _CheckBoxPage extends State<CheckBoxPage> {
  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildSelectTitle(),
        buildSelect(
          isSelect: false,
          text: '橙子',
        ),
        buildSelect(
          isSelect: false,
          text: '香蕉',
        ),
        buildSelect(
          isSelect: false,
          text: '桃子',
        ),
        buildSelect(
          isSelect: false,
          text: '🍐梨',
        ),
      ],
    );
  }

  Widget buildSelectTitle() {
    return const Text("请选择想要吃的食物");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
}

class buildSelect extends StatefulWidget {
  bool isSelect;
  String text;

  buildSelect({super.key, required this.text, required this.isSelect});

  @override
  State<StatefulWidget> createState() => _buildSelect();
}

class _buildSelect extends State<buildSelect> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: widget.isSelect,
            onChanged: (value) {
              setState(() {
                widget.isSelect = value!;
              });
            }),
        Text(widget.text)
      ],
    );
  }
}
