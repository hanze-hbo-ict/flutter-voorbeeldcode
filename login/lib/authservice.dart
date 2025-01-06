import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  const AuthService();

  Future<String> login(String uname, String passwd) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': uname, 'password': passwd}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      await _storage.write(key: 'token', value: json['id_token']);
      return 'Inloggen gelukt 👍';
    } else {
      throw Exception(response.statusCode);
    }
  }

  void removeToken() async {
    await _storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}
