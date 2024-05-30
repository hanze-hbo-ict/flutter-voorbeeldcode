import 'package:flutter/material.dart';

// Deze code maakt een Dismissable die je twee kanten op kunt swipen

class BetterDismissibleApp extends StatefulWidget {
  const BetterDismissibleApp({super.key});

  @override
  State<BetterDismissibleApp> createState() => _BetterDismissibleAppState();
}

class _BetterDismissibleAppState extends State<BetterDismissibleApp> {
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
          background: _getPrimaryBackground(),
          secondaryBackground: _getSecondaryBackground(),
          onDismissed: (DismissDirection direction) =>
              setState(() => items.removeAt(index)),
          child: ListTile(title: Text(item)),
        );
      },
    );
  }

  Widget _getPrimaryBackground() {
    return const ColoredBox(
        color: Colors.orange,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.star, color: Colors.white),
          ),
        ));
  }

  Widget _getSecondaryBackground() {
    return const ColoredBox(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
    );
  }
}
