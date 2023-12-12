import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  final _myBox = Hive.box('myBox');
  List todoList = [];
  // if is the 1st time ever oopening the app
  void createInitialData() {
    todoList = [
      ['Make some exercices', false],
      ['Learn new things', false]
    ];
  }

  void loadData() {
    todoList = _myBox.get('TodoList');
  }

  void updateData() async {
    await _myBox.put('TodoList', todoList);
  }
}
