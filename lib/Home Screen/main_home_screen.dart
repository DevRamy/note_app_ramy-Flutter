import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_ramy/Add%20Note%20Screen/main_add_note_screen.dart';
import 'package:note_app_ramy/Constant/constant_colors.dart';
import 'package:note_app_ramy/Database/helper_methods.dart';
import 'package:note_app_ramy/Database/sql_database.dart';
import 'package:note_app_ramy/Note%20Screen/main_note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentSliderValue = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNoteFromDatabase();
  }

  void getAllNoteFromDatabase() async {
    print('getAllNoteFromDatabase executed');
    await DBProvider.db.getAllNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
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
            child: Column(
              children: [
                // Todo: Slider Change Text Size
                Slider(
                  value: currentSliderValue,
                  min: 20,
                  max: 100,
                  divisions: 6,
                  label: currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      currentSliderValue = value;
                    });
                  },
                ),
                // Todo: Multi Screen Mode
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: allNote.length,
                    itemBuilder: (context, index) {
                      var indexNote = allNote[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteScreen(
                                  dateTime: indexNote.dateTime(),
                                  title: indexNote.title(),
                                  noteBody: indexNote.noteBody(),
                                ),
                              ),
                            ).then((value) {
                              getAllNoteFromDatabase();
                              setState(() {});
                            });
                          },
                          constraints: BoxConstraints.tightFor(
                            height: deviceSize.width / 2,
                            width: deviceSize.width / 3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: kBlueNote,
                            ),
                            child: Column(
                              children: <Widget>[
                                //Todo : Note Title
                                // ignore: prefer_const_constructors
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: TextField(
                                    // ignore: prefer_const_constructors
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: indexNote.title()),
                                    // ignore: prefer_const_constructors
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    // ignore: prefer_const_constructors
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: currentSliderValue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                //Todo : Note Body
                                // ignore: prefer_const_constructors
                                Expanded(
                                  // ignore: prefer_const_constructors
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    child: Text(
                                      indexNote.noteBody(),
                                      textAlign: TextAlign.center,
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    // ignore: prefer_const_constructors
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  ),
                ),
              ],
            ),
          ),
        ),
        //Todo: Add New Note Button
        floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: const [
              Icon(Icons.create_new_folder_rounded,
                  color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text("Add Note"),
            ],
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(),
            ),
          ).then((value) {
            getAllNoteFromDatabase();
            setState(() {});
          }),
        ),
      ),
    );
  }
}
