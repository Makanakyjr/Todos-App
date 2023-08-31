import 'dart:convert';

import 'package:api_dart/todo_model.dart';

import 'package:http/http.dart' as http;


String url = "https://jsonplaceholder.typicode.com/todos";

Future<List<Todo>> fetchTodos() async {
  Uri uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    print(response.body);
    final jsonData = jsonDecode(response.body) as List;
    List<Todo> todos = [];
    todos = List<Todo>.from(
      jsonData.map(
        (json) => Todo.fromJson(json),
      ),
    );
    print(todos);
    return todos;
  } else {
    throw Exception("Unable to fetch todos");
  }
}

Stream<List<Todo>> getTodoStream() async* {
  Uri uri = Uri.parse(url);
  while (true) {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      final jsonData = jsonDecode(response.body) as List;
      List<Todo> todos = [];
      todos = List<Todo>.from(
        jsonData.map(
          (json) => Todo.fromJson(json),
        ),
      );
      await Future.delayed(const Duration(seconds: 3));
      yield todos;
    } else {
      throw Exception("Unable to fetch todos");
    }
  }
}
