import 'package:flutter/material.dart';

class ConstranintsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 300,
          height: 300,
          color: Colors.amber,
          alignment: Alignment.center,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
          )),
    );
  }

  void performLayout() {}
}
