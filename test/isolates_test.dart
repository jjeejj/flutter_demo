import 'dart:async';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test isolate', (WidgetTester widgetTester) async {
    print(Isolate.current.debugName);
  });
  testWidgets('new isolate', (WidgetTester widgetTester) async {
    // Isolate timeIsolate;
    // final mainControlPort = ReceivePort()
    //   ..listen((message) {
    //     print('send back to mainIsolate: $message');
    //   });
    // void timerTick(SendPort sendPort) async {
    //   print('Current isolate ${Isolate.current.debugName} start');
      // Timer.periodic(const Duration(seconds: 1), (timer) {
      //   final ts = DateTime.now().toIso8601String();
      //   sendPort.send(ts);
      // });
    // }

    // timeIsolate = await Isolate.spawn(timerTick, mainControlPort.sendPort);
    // timeIsolate.kill();
  });
}
