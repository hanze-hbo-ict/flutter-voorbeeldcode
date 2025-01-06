import 'dart:async';
import 'dart:io';

import 'package:demo_ap/authservice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(httpService: AuthService()));
}

class MyApp extends StatefulWidget {
  final AuthService httpService;

  const MyApp({super.key, required this.httpService});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<String>? _futureJWT;
  Future<String?>? _currentValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login demo'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureJWT == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(hintText: 'Gebruikersnaam'),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(hintText: 'Wachtwoord'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureJWT = widget.httpService
                  .login(_usernameController.text, _passwordController.text);
            });
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  FutureBuilder<String> buildFutureBuilder() {
    return FutureBuilder<String>(
      future: _futureJWT,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return resultColumn(snapshot.data!);
        } else if (snapshot.hasError) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${snapshot.error}'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureJWT = null;
                      });
                    },
                    child: const Text("Opnieuw"))
              ]);
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Column resultColumn(String result) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(result),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    () => widget.httpService.removeToken();
                    _futureJWT = null;
                  });
                },
                child: const Text('Nog een keer')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentValue = widget.httpService.getToken();
                  });
                },
                child: const Text('Toon JWT'))
          ]),
          FutureBuilder(
              future: _currentValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!);
                } else {
                  return const Text('');
                }
              })
        ]);
  }
}
