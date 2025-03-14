import 'package:flutter/material.dart';

import 'package:cinemapedia/Config/Theme/theme_app.dart';

import 'package:cinemapedia/Config/router/routers.dart';

import "package:flutter_dotenv/flutter_dotenv.dart";

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeAppP().getTheme(),
    );
  }
}
