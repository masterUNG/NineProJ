import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nineproj/states/authen.dart';

void main() {
  HttpOverrides.global = MyHttpOverride();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Authen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
      ),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
