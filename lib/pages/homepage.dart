// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';

import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  Function changeThemeColourFunc;

  HomePage({super.key, required this.changeThemeColourFunc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the hive hox
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  // Reference to which TODOs to show (checked, unchecked)
  bool showChecked = true; // TODOs that are done
  bool showUnchecked = true; // TODOs that are yet to be done

  @override
  void initState() {
    // If this is the first time opening app, create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();
  // final List todos = [
  //   ["My first todo", false]
  // ];

  void saveNewTodo() {
    setState(() {
      db.toDoList.add([_controller.text, false, null]);
      db.loadData();
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTodo,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.toDoList[index][2] = DateTime.now();
    });
    db.updateDatabase();
  }

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    // Update the color picker
    setState(() {
      pickerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "TODO",
          style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
        ),
        shadowColor: Colors.transparent,
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              bool checkboxValue = db.toDoList[index][1];
              if ((showChecked && checkboxValue) ||
                  (showUnchecked && !checkboxValue)) {
                return TodoTile(
                  textValue: db.toDoList[index][0],
                  checkboxValue: checkboxValue,
                  deleteFunction: (context) => deleteTask(index),
                  onChanged: (value) => checkBoxChanged(value, index),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Colors.white.withOpacity(0.0),
                Colors.grey.withOpacity(0.0)
              ])),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.color_lens),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Pick a colour"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ColorPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      widget.changeThemeColourFunc(pickerColor);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Confirm")),
                                ElevatedButton(
                                    onPressed: () {
                                      changeColor(Colors.amber);
                                      widget.changeThemeColourFunc(pickerColor);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Default")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: createNewTodo,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  // onPressed: () => showAboutDialog(context: context),
                  onPressed: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              SwitchListTile(
                                title: Text("Show completed?"),
                                value: showChecked,
                                onChanged: (bool value) => setState(() {
                                  showChecked = !showChecked;
                                }),
                              ),
                              SwitchListTile(
                                title: Text("Show incomplete?"),
                                value: showUnchecked,
                                onChanged: (bool value) => setState(() {
                                  showUnchecked = !showUnchecked;
                                }),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Confirm"))
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ).then((value) => setState(
                        () {},
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
