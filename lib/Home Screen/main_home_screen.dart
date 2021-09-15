import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_ramy/Add%20Note%20Screen/main_add_note_screen.dart';
import 'package:note_app_ramy/Constant/constant_colors.dart';
import 'package:note_app_ramy/Database/helper_methods.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentSliderValue = 20;
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
                    mainAxisSpacing: 10,
                    itemBuilder: (context, index) {
                      var indexNote = allNote[index];
                      return Container(
                        margin:
                            // ignore: prefer_const_constructors
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        height: deviceSize.width / 2,
                        width: deviceSize.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: kBlueNote,
                        ),
                        child: Column(
                          children: <Widget>[
                            //Todo : Note Title
                            // ignore: prefer_const_constructors
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
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
                                // ignore: prefer_const_constructors
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: TextField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                      text: indexNote.noteBody()),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  // ignore: prefer_const_constructors
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  textAlign: TextAlign.center,
                                  style:
                                      // ignore: prefer_const_constructors
                                      TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
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
              Icon(Icons.edit, color: Colors.white, size: 20),
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
            setState(() {});
          }),
        ),
      ),
    );
  }
}
