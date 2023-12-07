import 'package:flutter/material.dart';

void main() => runApp(const CircularSplashScreen());

class SimpleImage extends StatelessWidget {
  const SimpleImage({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Image.network('https://bioinf.nl/~bbarnard/kip.png'),
      ),
    );
  }
}

class CenterImage extends StatelessWidget {
  const CenterImage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://bioinf.nl/~bbarnard/kip.png')
          ]),
    )));
  }
}

class CircularSplashScreen extends StatelessWidget {
  const CircularSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
          Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: const DecorationImage(
                    image: NetworkImage('https://bioinf.nl/~bbarnard/kip.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                  border: Border.all(
                    color: Colors.green,
                    width: 4.0,
                  ))),
          ElevatedButton(
              onPressed: () => print('functie hier'),
              child: const Text('Ga los')),
        ]))));
  }
}
