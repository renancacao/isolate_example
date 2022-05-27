import 'dart:async';

import 'package:flutter/material.dart';

import 'spawn_file_repository.dart';

class SpawnScreen extends StatefulWidget {
  const SpawnScreen({Key? key}) : super(key: key);

  @override
  State<SpawnScreen> createState() => _SpawnScreenState();
}

class _SpawnScreenState extends State<SpawnScreen> {
  late StreamController<String> _controller;
  late Stream<String> _stream;

  final repository = SpawnFileRepository();

  @override
  void initState() {
    _controller = StreamController();
    _stream = _controller.stream;
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 15);

    return StreamBuilder<String>(
        stream: _stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Isolate Spawn"),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () async => _write(),
                        child: const Text("Gerar arquivo", style: style),
                      ),
                      TextButton(
                        onPressed: () async => _read(),
                        child: const Text("Ler arquivo", style: style),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: CircularProgressIndicator(),
                  ),
                  Text(snapshot.data ?? "", style: style),
                ],
              ),
            ),
          );
        });
  }

  void _write() {
    repository.writeSpawn().listen((value) => _controller.sink.add(value));
  }

  void _read() {
    repository.readSpawn().listen((value) => _controller.sink.add(value));
  }
}
