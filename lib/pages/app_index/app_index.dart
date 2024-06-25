import 'package:flutter/cupertino.dart';

class AppIndexPage extends StatefulWidget {
  const AppIndexPage({super.key});

  @override
  State<StatefulWidget> createState() => _AppIndexPageState();
}

class _AppIndexPageState extends State<AppIndexPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: Center(
      child: Text('index页面'),
    ));
  }
}
