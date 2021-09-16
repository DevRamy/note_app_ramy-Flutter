import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Home Screen/main_home_screen.dart';
// ignore: unused_import
import 'Note Screen/main_note_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
