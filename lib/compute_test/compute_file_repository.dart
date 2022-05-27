import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:flutter/foundation.dart';

import '../utils.dart';

class ComputeFileRepository {
  Future<String> writeCompute() {
    const data = null;
    return compute<dynamic, String>(writeComputFunc, data);
  }

  Future<String> readCompute() {
    const data = null;
    return compute<dynamic, String>(readComputeFunc, data);
  }

  String writeComputFunc(dynamic data) {
    final start = DateTime.now();

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
    }

    final end = DateTime.now();
    return writeMessage(i, end, start);
  }

  String readComputeFunc(dynamic data) {
    final start = DateTime.now();

    final file = File(fileName);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      final end = DateTime.now();
      return readMessage(end, start, content);
    } else {
      return "Arquivo não encontrado";
    }
  }
}
