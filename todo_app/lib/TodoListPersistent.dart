// ignore_for_file: library_private_types_in_public_api

/*
In dit voorbeeld gebruik ik de database-engine drift: zie https://pub.dev/packages/drift,
https://drift.simonbinder.eu/docs/upgrading/#name en https://drift.simonbinder.eu/docs/getting-started/.
Ik had zelf wat moeite met de dependencies omdat er een nieuwe versie van dart is uitgekomen;
de dependencies die je nu vindt in pubspec.yaml werken in ieder geval op mijn machine. 

Een goed en uitgebreid voorbeeld kun je vinden op https://fluttertalk.com/flutter-crud-tutorial-using-drift-package/
*/

import 'package:flutter/material.dart';
import 'database.dart';

class TodoListPersistent extends StatefulWidget {
  const TodoListPersistent({super.key});

  @override
  _TodoListPersistentState createState() => _TodoListPersistentState();
}

class _TodoListPersistentState extends State<TodoListPersistent> {
  //final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();
  final database = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dingen om te doen')),
      body: _getItems(),
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
      database.saveItem(title);
      //_todoList.add(title);
    });
    _textFieldController.clear();
  }

  // Generate list of item widgets
  // Widget _buildTodoItem(String title) {
  //   return ListTile(title: Text(title));
  // }

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

  Widget _getItems() {
    return FutureBuilder<List<TodoItem>>(
      future: database.getItems(),
      builder: (context, s) {
        if (s.hasData) {
          if (s.data!.isNotEmpty) {
            List<TodoItem>? data = s.data;
            List<ListTile> foo =
                data!.map((e) => ListTile(title: Text(e.title))).toList();
            return Column(
                children: ListTile.divideTiles(color: Colors.green, tiles: foo)
                    .toList());
          } else {
            return const Center(
              child: Text("No data available"),
            );
          }
        }
        return Container();
      },
    );
  }
}

  // List<Widget> _getItems() {
  //   final List<Widget> todoWidgets = <Widget>[];
  //   for (String title in _todoList) {
  //     todoWidgets.add(_buildTodoItem(title));
  //   }
  //   return todoWidgets;
  //}
//}
