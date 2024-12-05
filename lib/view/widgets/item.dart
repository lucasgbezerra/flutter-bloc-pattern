import 'package:bloc_pattern/data/models/taskModel.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.task, required this.deleteFunc});
  final TaskModel task;
  final Function deleteFunc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: Colors.blue,
      leading: Icon(task.isCompleted == null || task.isCompleted == false ? Icons.check_box_outline_blank : Icons.check),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          deleteFunc();
        }
      )
    );
  }
}