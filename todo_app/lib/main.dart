import 'package:flutter/material.dart';
import 'TodoList.dart';
import 'TodoListPersistent.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'To-Do List', home: TodoListPersistent());
  }
}
