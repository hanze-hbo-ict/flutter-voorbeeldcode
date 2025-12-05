import 'package:demo_app/cat_card.dart';
import 'package:demo_app/cat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CatProvider(), child: const CatApp()));
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Awesome Cat App 🐈🐈‍⬛',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<CatProvider>(context, listen: false).loadCats(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catData = Provider.of<CatProvider>(context).catList;
    return Scaffold(
      appBar: AppBar(title: const Text('Awesome Cat App 🐈🐈‍⬛')),
      body: Center(
          child: ListView.builder(
        itemCount: catData.length,
        itemBuilder: (context, idx) {
          final cat = catData[idx];
          return CatCard(cat: cat);
        },
      )),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.countertops),
            label: "${catData.length} katten"),
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home")
      ]),
    );
  }
}
