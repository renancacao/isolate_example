import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:async';

import 'package:isolates_example/utils.dart';

class SpawnFileRepository {
  Stream<String> writeSpawn() {
    ReceivePort receivePort = ReceivePort();

    Isolate.spawn<SendPort>(writeFunc, receivePort.sendPort);

    return receivePort.map((event) => event.toString());
  }

  Stream<String> readSpawn() {
    ReceivePort receivePort = ReceivePort();

    Isolate.spawn<SendPort>(readFunc, receivePort.sendPort);

    return receivePort.map((event) => event.toString());
  }

  void writeFunc(SendPort sendPort) {
    final start = DateTime.now();

    sendPort.send("");

    final file = File(fileName);
    if (file.existsSync()) {
      file.deleteSync();
    }

    file.createSync();

    int i = 0;
    for (i = 0; i < tot; i++) {
      file.writeAsStringSync(
        Random().nextInt(256).toString() + ", ",
        mode: FileMode.append,
      );
      sendPort.send(i.toString());
    }

    final end = DateTime.now();
    Isolate.exit(
      sendPort,
      writeMessage(i, end, start),
    );
  }

  void readFunc(SendPort sendPort) {
    final start = DateTime.now();

    sendPort.send("");

    final file = File(fileName);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      final end = DateTime.now();
      Isolate.exit(
        sendPort,
        readMessage(end, start, content),
      );
    } else {
      Isolate.exit(
        sendPort,
        "Arquivo não encontrado",
      );
    }
  }
}
