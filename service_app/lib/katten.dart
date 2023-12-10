import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

class KattenImageScreen extends StatefulWidget {
  const KattenImageScreen({super.key});

  @override
  State<KattenImageScreen> createState() => _CatImageState();
}

class _CatImageState extends State<KattenImageScreen> {
  Key _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
          _getCatImage(),
          _getButton(),
        ]))));
  }

  Widget _getCatImage() {
    print('build');
    NetworkImage img = NetworkImage(
        'https://cataas.com/cat?type=square&v=${DateTime.now().millisecondsSinceEpoch}');
    return Container(
        key: _refreshKey,
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: img,
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(150.0)),
            border: Border.all(
              color: Colors.green,
              width: 4.0,
            )));
  }

  Widget _getButton() {
    return ElevatedButton(
        onPressed: () => setState(() => _refreshKey = UniqueKey()),
        child: const Text('Doe andere kat'));
  }
}
