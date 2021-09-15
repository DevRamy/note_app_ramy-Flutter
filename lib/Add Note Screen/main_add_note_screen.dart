import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_ramy/Constant/constant_colors.dart';
import 'package:note_app_ramy/Database/note_class.dart';
import 'package:note_app_ramy/Database/sql_database.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  double currentSliderValue = 18;
  String dateTime =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()).toString();
  String? title;
  String? noteBody;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kThemColor,
          // ignore: prefer_const_constructors
          title: Center(
            // ignore: prefer_const_constructors
            child: Text("Add new Note"),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          color: kThemColor,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Slider(
                  value: currentSliderValue,
                  min: 18,
                  max: 100,
                  divisions: 10,
                  label: currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      currentSliderValue = value;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    color: kBlueNote,
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.all(
                      // ignore: prefer_const_constructors
                      Radius.circular(18),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      //Todo : Note Title
                      TextField(
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Note Title",
                        ),
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          title = value;
                        },
                      ),
                      //Todo : Note Body
                      // ignore: prefer_const_constructors
                      Expanded(
                        // ignore: prefer_const_constructors
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "your Note",
                          ),
                          style:
                              // ignore: prefer_const_constructors
                              TextStyle(
                                  fontSize: currentSliderValue,
                                  fontWeight: FontWeight.bold),
                          onChanged: (value) {
                            noteBody = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Todo: Save Note Button
        floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: const [
              Icon(Icons.save, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text("Save Note"),
            ],
          ),
          onPressed: () async {
            await DBProvider.db.createNote(
                Note(dateTime: dateTime, title: title!, noteBody: noteBody!));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
