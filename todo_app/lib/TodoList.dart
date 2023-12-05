// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dingen om te doen')),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  // Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(title: Text(title));
  }

  // Generate a single item widget
  Future<AlertDialog?> _displayDialog(BuildContext context) async {
    return showDialog<AlertDialog?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Voeg een ding aan de lijst toe'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Tekst hier'),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Toevoegen'),
                onPressed: () {
                  _addTodoItem(_textFieldController.text);
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Annuleren'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> todoWidgets = <Widget>[];
    for (String title in _todoList) {
      todoWidgets.add(_buildTodoItem(title));
    }
    return todoWidgets;
  }
}
