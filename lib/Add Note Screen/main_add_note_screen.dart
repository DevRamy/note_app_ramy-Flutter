import 'package:flutter/material.dart';
import 'package:note_app_ramy/Constant/constant_colors.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kThemColor,
          title: const Center(
            child: Text("Add new Note"),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          color: kThemColor,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: kBlueNote,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              children: const <Widget>[
                //Todo : Note Title
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note Title",
                  ),
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                //Todo : Note Body
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "your note",
                    ),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: const [
              Icon(Icons.save, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text("Save Note"),
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
