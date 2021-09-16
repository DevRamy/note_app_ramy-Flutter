// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app_ramy/Add%20Note%20Screen/main_add_note_screen.dart';
import 'package:note_app_ramy/Constant/constant_colors.dart';
import 'package:note_app_ramy/Database/helper_methods.dart';
import 'package:note_app_ramy/Database/sql_database.dart';
import 'package:note_app_ramy/Note%20Screen/main_note_screen.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentSliderValue = 20;
  bool multiScreen = true;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getAllNoteFromDatabase();
  }

  void getAllNoteFromDatabase() async {
    // ignore: avoid_print
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
          title: Text("All Note"),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, size: 30),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Container(
                          margin: EdgeInsets.all(10.0),
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constrains) {
                              double alertWidth = constrains.maxWidth;
                              double alertHeight = constrains.maxHeight;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    'View Mode',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Todo : One Page View
                                      GestureDetector(
                                        child: Container(
                                          width: alertWidth / 2.5,
                                          height: alertHeight * 0.8,
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: !multiScreen
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          child: Image.asset(
                                              'images/one note page.png'),
                                        ),
                                        onTap: () async {
                                          await DBProvider.db.getAllNote();
                                          multiScreen = false;
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      // Todo : Multi Page View
                                      GestureDetector(
                                        child: Container(
                                          width: alertWidth / 2.5,
                                          height: alertHeight * 0.8,
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: multiScreen
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          child: Image.asset(
                                              'images/multi note.png'),
                                        ),
                                        onTap: () async {
                                          await DBProvider.db.getAllNote();
                                          multiScreen = true;
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          )),
                    );
                  },
                );
              },
            ),
          ],
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
                // Todo: Multi Page Mode
                Visibility(
                  visible: multiScreen,
                  child: Expanded(
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: allNote.length,
                      itemBuilder: (context, index) {
                        var indexNote = allNote[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          child: RawMaterialButton(
                            // Todo: Delete Note Button
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Note!'),
                                    content: Text(
                                        'Would you like to delete of this Note?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await DBProvider.db
                                              .deleteNote(indexNote.id());
                                          getAllNoteFromDatabase();
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        // ignore: prefer_const_constructors
                                        child: Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            // Todo: Edit Note Button
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoteScreen(
                                    id: indexNote.id(),
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
                              height: deviceSize.width / 2,
                              width: deviceSize.width / 2,
                              decoration: BoxDecoration(
                                color: kBlueNote,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: LayoutBuilder(
                                builder: (context, constrains) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Todo: Note Title
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 8.0),
                                          child: Text(
                                            indexNote.title(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: currentSliderValue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Todo: Note Body
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            indexNote.noteBody(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      // ignore: prefer_const_constructors
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    ),
                  ),
                ),
                // Todo: One Page Mode
                Visibility(
                  visible: !multiScreen,
                  child: Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: kThemColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0),
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constrains) {
                          double layoutWidth = constrains.maxWidth;
                          double layoutHeight = constrains.maxHeight;
                          return ListView.builder(
                            itemCount: allNote.length,
                            itemBuilder: (context, index) {
                              var indexNote = allNote[index];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 15.0),
                                width: layoutWidth,
                                height: layoutHeight,
                                decoration: BoxDecoration(
                                  color: kBlueNote,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Page: ${index + 1} \n',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        'Title: ${indexNote.title()}',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 8.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text(
                                            indexNote.noteBody(),
                                            style: TextStyle(
                                              fontSize: currentSliderValue - 4,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
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
