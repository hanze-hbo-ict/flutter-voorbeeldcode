import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  double rightValue = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Title",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: const Text('demo')),
        body: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: _getAnimatedText()),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                rightValue = MediaQuery.of(context).size.width;
              });
            },
            child: const Text(
              "GO!",
              style: TextStyle(fontSize: 24),
            )),
      ),
    );
  }

  Widget _getAnimatedText() {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          // left: 0,
          left: rightValue, //.of(context).size.width,
          // beetje magic number, maar om de tekst wat omhoog te krijgen...
          // misschien moet je hier nog wat proberen te doen met de Center-widget
          top: MediaQuery.of(context).size.height / 2 - 150,
          duration: const Duration(milliseconds: 1000),
          child: const Center(
            child: Text("🚗", style: TextStyle(fontSize: 48.0)),
          ),
          onEnd: () => setState(() {
            rightValue = rightValue < 1 ? MediaQuery.of(context).size.width : 0;
          }),
        ),
      ],
    );
  }
}
