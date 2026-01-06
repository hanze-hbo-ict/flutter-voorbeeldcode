import 'package:database_app/database/database_helper.dart';

import '../models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoService {
  const TodoService();

  Future<List<Todo>> fetchTodos() async {
    final response =
        await http.get(Uri.parse('https://datminor.nl/todos.json'));

    if (response.statusCode == 200) {
      // server gaf 200 Ok terug, dus we kunnen de data parsen naar json.
      // We moeten hier expliciet aangeven dat dit een datastructuur van
      // <String, dynamic> is, anders ziet Dart de data als <dynamic, dynamic>.
      // Je moet (ook in andere talen) natuurlijk dynamic vermijden, want da's
      // eigenlijk hetzelfde als zeggen dat je niet weet wat voor typen je krijgt.

      final List<Map<String, dynamic>> body =
          (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
      return Future.wait<Todo>(body.map((json) => _getTodo(json)));
      //return List.from(body.map((json) async => await _getTodo(json)));
    } else {
      // foutmelding, dus we gooien een exceptie
      print(response.statusCode);
      throw Exception('Hier ging iets niet goed 🧐');
    }
  }

  /* 
  Hier kijken we of een Todo met een specifiek id al in de 
  database op het device is opgeslagen. Als dat het geval is
  maken we een Todo aan op basis van *die* data; anders maken
  we een nieuwe Todo aan op basis van de json die we binnenkregen
  */
  Future<Todo> _getTodo(json) async {
    final id = json['id'];
    final db = DatabaseHelper.instance;
    try {
      Todo todo = await db.fetchTodo(id);
      return todo;
    } on Exception {
      return Todo.fromJson(json);
    }
  }
}
