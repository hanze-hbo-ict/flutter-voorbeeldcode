import 'package:flutter/material.dart';
import 'view/todo_list.dart';
import 'service/todo_service.dart';

void main() {
  const TodoService service = TodoService();
  runApp(const TodoApp(todoservice: service));
}
