import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

Future<List<Todo>> fetchTodos() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1/todos'));

  if (response.statusCode == 200) {
    // server gaf 200 Ok terug, dus we kunnen de data parsen naar json.
    final body = jsonDecode(response.body);
    return List.from(body.map((json) => Todo.fromJson(json)));
  } else {
    // foutmelding, dus we gooien een exceptie
    throw Exception('Hier ging iets niet goed 🧐');
  }
}

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
        'completed': bool completed,
      } =>
        Todo(
          userId: userId,
          id: id,
          title: title,
          completed: completed,
        ),
      _ => throw const FormatException('Failed to load todos 😡'),
    };
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  //late Future<List<Todo>> futureTodo;
  List<Todo> futureTodo = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final todos = await fetchTodos();
    setState(() => futureTodo = todos);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Todo Voorbeeld'),
          ),
          body: _getTodos()),
    );
  }

  Widget _getTodos() {
    return ListView.separated(
        itemCount: futureTodo.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = futureTodo[index];
          return ListTile(
            leading: item.completed
                ? const Icon(Icons.done)
                : const Icon(Icons.today_rounded),
            title: Text(item.title),
          );
        });
  }
}
