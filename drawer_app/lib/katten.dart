import 'dart:ffi';

import 'package:drawer_app/screens/about_page.dart';
import 'package:drawer_app/screens/settings_page.dart';
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Katten🐈🐈‍⬛!'),
          elevation: 4,
          actions: const [IconButton(onPressed: null, icon: Icon(Icons.map))],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_getCatImage(), _getButton()],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Text("Katten app"),
              ),
              ListTile(
                title: const Text("Instellingen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Version 1.0"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCatImage() {
    NetworkImage img = NetworkImage(
      'https://cataas.com/cat?type=square&v=${DateTime.now().millisecondsSinceEpoch}',
    );
    return Container(
      key: _refreshKey,
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(image: img, fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(Radius.circular(150.0)),
        border: Border.all(color: Colors.green, width: 4.0),
      ),
    );
  }

  Widget _getButton() {
    return ElevatedButton(
      onPressed: () => setState(() => _refreshKey = UniqueKey()),
      child: const Text('Doe andere kat'),
    );
  }
}
