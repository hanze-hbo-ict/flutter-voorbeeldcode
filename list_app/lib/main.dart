import 'package:flutter/material.dart';

void main() => runApp(const ListApp());

class ListApp extends StatelessWidget {
  const ListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('ListViews')),
        body: const BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  const BodyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _prettyInfiniteList(context));
  }
}

Widget _staticList(BuildContext context) {
  return ListView(
    children: const <Widget>[
      ListTile(
        title: Text('Black'),
      ),
      ListTile(
        title: Text('White'),
      ),
      ListTile(
        title: Text('Grey'),
      ),
    ],
  );
}

Widget _dynamicList(BuildContext context) {
  final landen = [
    'Nederland',
    'België',
    'Frankrijk',
    'Spanje',
    'Duitsland',
    'Zwitserland',
    'Italië',
    'Polen',
    'Tjechië',
    'Hongarije',
    'Servië'
  ];

  return ListView.builder(
      itemCount: landen.length,
      itemBuilder: (ctx, idx) => ListTile(title: Text(landen[idx])));
}

Widget _infiniteList(BuildContext context) {
  return ListView.separated(
    itemBuilder: (ctx, idx) => ListTile(title: Text('Regel nummer $idx')),
    itemCount: 100,
    separatorBuilder: (ctx, idx) => const Divider(),
  );
}

Widget _prettyInfiniteList(BuildContext context) {
  return ListView.separated(
      itemBuilder: (ctx, idx) => ListTile(
            title: Text('Regel nummer $idx'),
            subtitle: const Text('klik hier om dingen te doen.'),
          ),
      separatorBuilder: (ctx, idx) =>
          const Divider(height: 3, thickness: 3, color: Colors.blue),
      itemCount: 100);
}
