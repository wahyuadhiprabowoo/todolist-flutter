import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onTodoChanged;
  final onDeleteitem;
  TodoItem(
      {super.key,
      required this.todo,
      required this.onTodoChanged,
      required this.onDeleteitem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: ListTile(
        contentPadding:
            EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading:
            Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
        trailing: Container(
            margin: EdgeInsetsDirectional.symmetric(vertical: 6),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8)),
            child: IconButton(
                onPressed: () {
                  onDeleteitem(todo.id);
                },
                icon: Icon(
                  Icons.delete,
                  size: 18,
                  color: Colors.white,
                ))),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
      ),
    );
  }
}
