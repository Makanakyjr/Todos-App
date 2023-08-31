import 'package:api_dart/services/todo_api.dart';
import 'package:api_dart/todo_model.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos App"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: IntrinsicWidth(
              child: Row(
            children: [
              const Text("Create Todo"),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.add),
              ),
            ],
          ))),
      // Future Builder
      body: StreamBuilder(
        stream: getTodoStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return AlertDialog(
              icon: const Icon(
                Icons.warning,
              ),
              content: Text("${snapshot.error}"),
              title: const Text("Error"),
              actions: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text("Retry")),
                )
              ],
            );
          } else if (snapshot.hasData) {
            List<Todo> todos = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) => CheckboxListTile(
                value: todos[index].completed,
                title: Text(todos[index].title),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              itemCount: todos.length,
            );
          }
          return const Center(
            child: Text("Todo is Empty"),
          );
        },
      ),
    );
  }
}