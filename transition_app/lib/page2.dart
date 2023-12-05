import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Welkom bij de app",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Scherm nummer 2'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Terug naar het begin"))
                ]))));
  }
}
