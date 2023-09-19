import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> _foundTodo = [];
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  //
  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _delelteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: _todoController.text));
    });
    _todoController.clear();
  }

  void _searchItem(String enteredKeyword) {
    List<ToDo> results = [];
    enteredKeyword.isEmpty
        ? results = todosList
        : results = todosList
            .where((i) => i.todoText!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
    setState(() {
      _foundTodo = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 2,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),
            CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
            ),
          ],
        ),
        // backgroundColor: Colors.white24,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SearchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 48, bottom: 24),
                          child: Text("All Todo's"),
                        ),
                        for (ToDo todo in _foundTodo.reversed)
                          TodoItem(
                            todo: todo,
                            onTodoChanged: _handleToDoChange,
                            onDeleteitem: _delelteTodoItem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: "Add a new todo..",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, bottom: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(60, 60), elevation: 8),
                      onPressed: () => _addTodoItem(_todoController.text),
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        onChanged: (value) => _searchItem(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 24),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(fontSize: 14)),
      ),
    );
  }
}
