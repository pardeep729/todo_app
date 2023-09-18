import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  final _mybox = Hive.box('myBox');

  // Run this method if this is 1st time ever opening this app
  // 1 item of fromat [<name>, <checkbox value>, <datetime>]
  // The `datetime` updates when deleted
  void createInitialData() {
    toDoList = [
      ["Go to work", false, null],
      ["Code an app", false, null],
    ];
  }

  void loadData() {
    toDoList = _mybox.get('TODOLIST');
  }

  void updateDatabase() {
    _mybox.put('TODOLIST', toDoList);
  }
}
