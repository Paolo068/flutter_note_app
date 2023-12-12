import 'package:flutter/material.dart';
import 'package:flutter_note_app/data/database.dart';
import 'package:flutter_note_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  var db = TodoDatabase();
  void onTapCheckBox(value, index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
  }

  addNewTask() {
    setState(() {
      db.todoList.add([textCtrl.text, false]);
    });
    textCtrl.clear();
    Navigator.of(context).pop();
  }

  deleteTask(index) {
    setState(() {
      db.todoList.removeAt(index);
    });
  }

  updateTask(index) {
    setState(() {
      db.todoList[index][0] = textCtrl.text;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    textCtrl.dispose();
  }

  var textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[100],
        onPressed: () async {
          return showAdaptiveDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Add a new task"),
              content: TextField(
                controller: textCtrl,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    addNewTask();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Text('Todo App'),
        elevation: 0,
      ),
      backgroundColor: Colors.deepPurple[50],
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => onTapCheckBox(value, index),
              onTaskDelete: (context) => deleteTask(index),
              onTap: () {
                textCtrl.text = db.todoList[index][0];
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Edit task"),
                      content: TextField(
                        onChanged: (value) => textCtrl.text = value,
                        controller: textCtrl,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            updateTask(index);
                          },
                          child: const Text("Update"),
                        ),
                      ],
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
