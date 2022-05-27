const tot = 10000;
const String fileName =
    "/data/user/0/com.example.isolates_example/app_flutter/test.txt";

String writeMessage(int i, DateTime end, DateTime start) =>
    "Arquivo gerado. ${i.toString()} itens. ${end.difference(start).inMilliseconds}ms";

String readMessage(DateTime end, DateTime start, String content) =>
    "Arquivo lido. ${end.difference(start).inMilliseconds}ms\n\n$content";
