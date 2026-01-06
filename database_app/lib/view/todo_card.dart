import 'package:database_app/database/database_helper.dart';
import 'package:database_app/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  State<StatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Todo todo = widget.todo;
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    final TextEditingController titleController =
        TextEditingController(text: todo.title);
    final TextEditingController userIdController =
        TextEditingController(text: todo.userId.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo met id ${todo.id}'),
      ),
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(color: colorScheme.onSecondary)),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Omschrijving',
                style: textTheme.headlineSmall,
              ),
              TextFormField(
                controller: titleController,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'UserID',
                style: textTheme.headlineSmall,
              ),
              TextFormField(
                controller: userIdController,
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  "Not completed",
                  style: todo.completed
                      ? textTheme.bodyLarge
                      : textTheme.bodyMedium,
                ),
                Switch(
                  value: todo.completed,
                  onChanged: (bool val) {
                    setState(() {
                      todo.completed = !todo.completed;
                    });
                  },
                ),
                Text(
                  "completed",
                  style: todo.completed
                      ? textTheme.bodyLarge
                      : textTheme.bodyMedium,
                )
              ]),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Color.fromRGBO(100, 100, 0, .5),
                            content: Text('Data opslaan')),
                      );
                      DatabaseHelper.instance.updateTodo(
                          id: todo.id,
                          title: titleController.value.text,
                          userid: int.parse(userIdController.value.text),
                          completed: todo.completed);
                    });
                  },
                  child: const Text('Wijzigingen opslaan'))
            ],
          ),
        ),
      ),
    );
  }
}
