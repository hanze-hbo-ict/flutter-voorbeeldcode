import 'package:flutter/material.dart';

class DismissibleApp extends StatefulWidget {
  const DismissibleApp({super.key});

  @override
  State<DismissibleApp> createState() => _DismissibleAppState();
}

class _DismissibleAppState extends State<DismissibleApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Dismissable itemlist')),
        body: _getListItems());
  }

  Widget _getListItems() {
    final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) =>
              setState(() => items.removeAt(index)),
          child: ListTile(title: Text(item)),
        );
      },
    );
  }
}
