import 'dart:io';
import 'dart:math';
import 'dart:async';

import '../utils.dart';

class AsyncFileRepository {
  Stream<String> writeAsync() async* {
    final start = DateTime.now();

    yield "";

    final file = File(fileName);
    if (await file.exists()) {
      await file.delete();
    }

    await file.create();

    int i;
    for (i = 0; i < tot; i++) {
      await file.writeAsString(
        Random().nextInt(256).toString() + ", ",
        mode: FileMode.append,
      );
      yield i.toString();
    }

    final end = DateTime.now();
    yield writeMessage(i, end, start);
    return;
  }

  Stream<String> readAsync() async* {
    final start = DateTime.now();

    yield "";

    final file = File(fileName);
    if (await file.exists()) {
      final content = await file.readAsString();
      final end = DateTime.now();
      yield readMessage(end, start, content);
    } else {
      yield "Arquivo não encontrado";
    }

    return;
  }
}
