import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qmlkit_example/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    startServer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [],
      home: MainPage(),
    );
  }

  Future startServer() async {
    HttpServer server =
        await HttpServer.bind(InternetAddress.anyIPv4, 9999, shared: true);
    print("Server running on IP : " +
        server.address.toString() +
        " On Port : " +
        server.port.toString());
    server.listen((HttpRequest request) {
      request.response.write("Hello World");
      request.response.close();
    });
  }
}
