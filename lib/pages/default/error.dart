import 'package:flutter/cupertino.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: Center(
      child: Text('error'),
    ));
  }
}
