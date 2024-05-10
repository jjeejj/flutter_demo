import 'package:flutter/material.dart';

class TestKeyPage extends StatefulWidget {
  const TestKeyPage({super.key});

  @override
  State<StatefulWidget> createState() => _TestKeyPageState();
}

class _TestKeyPageState extends State<TestKeyPage> {
  List<Widget> items = [
    const TestKeyWidget(key:ValueKey(1),color: Colors.red),
    const TestKeyWidget(key:ValueKey(2),color: Colors.green),
    const TestKeyWidget(key:ValueKey(3),color: Colors.blue),
    // const TestKeyWidget(color: Colors.yellow),
    // const TestKeyWidget(color: Colors.orange),
    // const TestKeyWidget(color: Colors.purple),
    // const TestKeyWidget(color: Colors.pink),
    // const TestKeyWidget(color: Colors.brown),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            items.removeAt(0);
            setState(() {});
          },
          child: const Icon(Icons.remove),
        ),
        body: Column(
          children: items,
        ));
  }
}

class TestKeyWidget extends StatefulWidget {
  final Color color;
  const TestKeyWidget({super.key, required this.color});

  @override
  State<StatefulWidget> createState() => _TestKeyWidgetState();
}

class _TestKeyWidgetState extends State<TestKeyWidget> {
  int count = 0;
  void increment() {
    setState(() {
      ++count;
    });
  }

  @override
  Widget build(BuildContext context) => Container(
      color: widget.color,
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: increment,
        child: Text("$count", style: const TextStyle(color: Colors.white, fontSize: 30)),
      ));
}
