import 'package:flutter/cupertino.dart';

class AppWriteNewPage extends StatefulWidget {
  final String id;

  const AppWriteNewPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _AppWriteNewPageState();
}

class _AppWriteNewPageState extends State<AppWriteNewPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: Center(
      child: Text('write new页面'),
    ));
  }
}
