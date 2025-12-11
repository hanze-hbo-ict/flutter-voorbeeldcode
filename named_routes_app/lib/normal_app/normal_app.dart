import 'package:demo_app/normal_app/plaatje_card_normal.dart';
import 'package:demo_app/route_app/plaatje_card_named.dart';
import 'package:demo_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalApp extends StatelessWidget {
  const AnimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Awesome Animal App 🐈🐕🐓⾺',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NormalHome());
  }
}

// VOORBEELD 1
// routering met normale Navigator.push

class NormalHome extends StatefulWidget {
  const NormalHome({super.key});

  @override
  State<NormalHome> createState() => _NormalHomeState();
}

class _NormalHomeState extends State<NormalHome> {
  @override
  void initState() {
    Provider.of<AnimalProvider>(context, listen: false).loadAnimals(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animalData = Provider.of<AnimalProvider>(context).animalList;
    return Scaffold(
      appBar: AppBar(title: const Text('Awesome Animal App  🐈🐕🐓⾺')),
      body: Center(
          child: ListView.builder(
        itemCount: animalData.length,
        itemBuilder: (context, idx) {
          final animal = animalData[idx];
          return AnimalCardNormal(animal: animal);
        },
      )),
    );
  }
}
