import 'package:flutter/material.dart';

import 'sync_file_repository.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({Key? key}) : super(key: key);

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  String content = "";

  final repository = SyncFileRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 15);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sync"),
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
                  onPressed: _write,
                  child: const Text("Gerar arquivo", style: style),
                ),
                TextButton(
                  onPressed: _read,
                  child: const Text("Ler arquivo", style: style),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: CircularProgressIndicator(),
            ),
            Text(content, style: style),
          ],
        ),
      ),
    );
  }

  void _write() {
    setState(() {
      content = repository.writeSync();
    });
  }

  void _read() {
    setState(() {
      content = repository.readSync();
    });
  }
}
