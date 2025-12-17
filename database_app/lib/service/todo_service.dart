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
      final body = jsonDecode(response.body);
      return List.from(body.map((json) => Todo.fromJson(json)));
    } else {
      // foutmelding, dus we gooien een exceptie
      print(response.statusCode);
      throw Exception('Hier ging iets niet goed 🧐');
    }
  }
}
