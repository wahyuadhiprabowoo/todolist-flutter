class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  // ujicoba data static
  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: "todoText", isDone: true),
      ToDo(id: '02', todoText: "todoText1", isDone: true),
      ToDo(id: '03', todoText: "todoTex2"),
    ];
  }
}
