class Todo {
  int id;
  String title;
  bool completed;
  bool? highPriority;

  Todo(
      {required this.id,
      required this.title,
      required this.completed,
      this.highPriority});

  //Named constructor
  Todo.empty({required this.id, this.title = " ", required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json["id"], title: json["title"], completed: json["completed"]);
  }

  Map<String, dynamic> toJson(Todo todo) => {
        "id": todo.id,
        "title": todo.title,
        "completed": false,
      };

  @override
  String toString() {
    return "Todo(title: $title, completed: $completed)";
  }
}