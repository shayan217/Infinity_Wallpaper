import 'package:apis_integration/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WallpaperScreen(),
    );
  }
}

