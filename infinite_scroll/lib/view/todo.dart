import 'package:flutter/material.dart';
import '../model/Todo.dart';
import '../service/todo_service.dart';

class TodoApp extends StatefulWidget {
  final TodoService todoservice;

  const TodoApp({required this.todoservice, super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Todo> futureTodo = [];
  final _curpage = 1;
  final _itemsPerPage = 10;

  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadTodos() async {
    final todos = await widget.todoservice.fetchTodos(_itemsPerPage);
    setState(() => futureTodo = todos);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      // Reached the end of the list, load more data
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    isLoading = true;
    final todos = await widget.todoservice.fetchTodos(_curpage * _itemsPerPage);
    setState(() {
      isLoading = false;
      futureTodo.addAll(todos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Scrolling todo voorbeeld'),
          ),
          body: _getTodos()),
    );
  }

  Widget _getTodos() {
    return ListView.separated(
      controller: _scrollController,
      separatorBuilder: (context, index) => const Divider(),
      itemCount: futureTodo.length + 1,
      itemBuilder: (context, index) {
        if (index == futureTodo.length) {
          return _buildLoader();
        } else {
          return ListTile(
            leading: futureTodo[index].completed
                ? const Icon(Icons.done)
                : const Icon(Icons.today_rounded),
            title: Text(futureTodo[index].title),
          );
        }
      },
    );
  }

  Widget _buildLoader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
