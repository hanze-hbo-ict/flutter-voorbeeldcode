import 'package:demo_app/provider.dart';
import 'package:demo_app/route_app/beschrijving.dart';
import 'package:demo_app/route_app/plaatje.dart';
import 'package:demo_app/route_app/plaatje_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouterAnimalApp extends StatelessWidget {
  const RouterAnimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Awesome Animal App 🐈🐕🐓⾺',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RoutingHome(),
        initialRoute: '/',
        routes: {
          '/home': (context) => const RouterAnimalApp(),
          '/omschrijving': (context) => const Beschrijving(),
          '/plaatje': (context) => const AnimalPicture(),
        }
        // routes: {
        //   '/': (context) => const RoutingHome(),
        //   '/omschrijving': (context) => Beschrijving()
        // };
        );
  }
}

// VOORBEELD 2
// Routering met named routes

class RoutingHome extends StatefulWidget {
  const RoutingHome({super.key});

  @override
  State<RoutingHome> createState() => _RoutingHomeState();
}

class _RoutingHomeState extends State<RoutingHome> {
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
          return AnimalCard(animal: animal);
        },
      )),
    );
  }
}
