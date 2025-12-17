import 'package:database_app/database/database_helper.dart';
import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../service/todo_service.dart';

class TodoApp extends StatefulWidget {
  final TodoService todoservice;

  const TodoApp({required this.todoservice, super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Todo> futureTodo = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final todos = await widget.todoservice.fetchTodos();
    setState(() => futureTodo = todos);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Database demo app'),
          ),
          body: _getTodos()),
    );
  }

  Widget _getTodos() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: futureTodo.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: futureTodo[index].completed
              ? const Icon(Icons.check)
              : const Icon(Icons.today_rounded),
          title: TitleWidget(todo: futureTodo[index]),
        );
      },
    );
  }
}

class TitleWidget extends StatelessWidget {
  final Todo todo;

  const TitleWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(todo.title),
      onTap: () {
        DatabaseHelper.instance.insertTodo(todo);
      },
    );
  }
}
