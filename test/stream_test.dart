import 'dart:async';

void main() {
  final controller = StreamController<int>();

  final stream = controller.stream;
  stream.listen((event) {
    print('received data $event');
  });
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);

  controller.close();
}
