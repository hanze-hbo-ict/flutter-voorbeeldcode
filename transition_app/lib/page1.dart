import 'package:flutter/material.dart';
import 'page2.dart';

class CircularSplashScreen extends StatelessWidget {
  const CircularSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationDemo());
  }
}

class NavigationDemo extends StatelessWidget {
  const NavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  borderRadius: const BorderRadius.all(Radius.circular(150.0)),
                  border: Border.all(
                    color: Colors.green,
                    width: 4.0,
                  ))),
          ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const StartScreen())),
              child: const Text('Ga los')),
        ])));
  }
}
