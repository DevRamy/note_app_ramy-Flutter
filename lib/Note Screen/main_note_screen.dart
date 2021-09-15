import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  String title;
  String note;
  String dateTime;

  NoteScreen({required this.title, required this.note, required this.dateTime});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Note"),
        ),
        body: Container(),
      ),
    );
  }
}
