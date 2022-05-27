import 'dart:io';
import 'dart:math';

import '../utils.dart';

class SyncFileRepository {
  String writeSync() {
    final start = DateTime.now();

    final file = File(fileName);
    if (file.existsSync()) {
      file.deleteSync();
    }

    file.createSync();

    int i;
    for (i = 0; i < tot; i++) {
      file.writeAsStringSync(
        Random().nextInt(256).toString() + ", ",
        mode: FileMode.append,
      );
    }

    final end = DateTime.now();
    return writeMessage(i, end, start);
  }

  String readSync() {
    final start = DateTime.now();

    final file = File(fileName);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      final end = DateTime.now();
      return readMessage(end, start, content);
    }

    return "Arquivo não encontrado";
  }
}
