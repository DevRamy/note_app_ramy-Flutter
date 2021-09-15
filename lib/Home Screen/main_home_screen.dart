import 'package:flutter/material.dart';
import 'package:note_app_ramy/Add%20Note%20Screen/main_add_note_screen.dart';
import 'package:note_app_ramy/Constant/constant_colors.dart';
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
          automaticallyImplyLeading: false,
          backgroundColor: kThemColor,
          title: const Center(
            child: Text("All Note"),
          ),
        ),
        body: Center(
          child: Container(
            color: kThemColor,
          ),
        ),
        //Todo: Add New Note Button
        floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: const [
              Icon(Icons.edit, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text("Add Note"),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNoteScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
