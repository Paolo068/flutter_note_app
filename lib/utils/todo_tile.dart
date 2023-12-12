import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool? taskCompleted;
  final Function(bool?)? onChanged;
  final void Function(BuildContext)? onTaskDelete;
  final void Function()? onTap;
  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.onChanged,
    required this.onTaskDelete, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Slidable(
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: onTaskDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
            )
          ]),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[100]),
            child: Row(
              children: [
                // checkbox
                Checkbox(value: taskCompleted, onChanged: onChanged),
                // Task name
                Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration:
                          taskCompleted! ? TextDecoration.lineThrough : null),
                ),
                // const Spacer(),
                // IconButton(
                //     onPressed: onTaskDelete,
                //     icon: Icon(
                //       Icons.delete,
                //       color: Colors.deepPurple[400],
                //     ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
