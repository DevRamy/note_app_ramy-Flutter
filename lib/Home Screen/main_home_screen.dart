import 'package:flutter/material.dart';
import 'package:note_app_ramy/Note%20Screen/main_note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Note"),
        ),
        body: Center(
          child: Container(
            color: Colors.red,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Add Note"),
          onPressed: () {},
        ),
      ),
    );
  }
}
