// Single subscription stream
import 'dart:async';

Stream<int> singleStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

// Broadcast stream
Stream<int> broadcastStream() {
  var controller = StreamController<int>.broadcast();
  controller.addStream(singleStream());
  return controller.stream;
}

void streamDemo() {
  // Работа с single subscription stream
  singleStream().listen((data) {
    print('Single Stream data: $data');
  });

  // Работа с broadcast stream
  Stream<int> bStream = broadcastStream();
  bStream.listen((data) {
    print('Broadcast Stream data 1: $data');
  });
  bStream.listen((data) {
    print('Broadcast Stream data 2: $data');
  });
}
