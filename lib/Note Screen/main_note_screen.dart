import 'package:flutter/material.dart';
import 'package:note_app_ramy/Constant/constant_colors.dart';

class NoteScreen extends StatefulWidget {
  String title;
  String noteBody;
  String dateTime;

  NoteScreen(
      {required this.title, required this.noteBody, required this.dateTime});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  double currentSliderValue = 18;
  String? title;
  String? noteBody;
  bool saveButtonIsVisible = false;
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
            child: Text("Note"),
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
                        controller: TextEditingController(text: widget.title),
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          title = value;
                          saveButtonIsVisible == false ? true : null;
                        },
                      ),
                      //Todo : Note Body
                      // ignore: prefer_const_constructors
                      Expanded(
                        // ignore: prefer_const_constructors
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller:
                              TextEditingController(text: widget.noteBody),
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            border: InputBorder.none,
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
        floatingActionButton: Visibility(
          visible: saveButtonIsVisible,
          child: FloatingActionButton.extended(
            label: Row(
              children: const [
                Icon(Icons.edit, color: Colors.white, size: 20),
                SizedBox(width: 5),
                Text("Save Changes"),
              ],
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
