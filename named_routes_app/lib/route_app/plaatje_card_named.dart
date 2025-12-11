import 'package:demo_app/models/animal_model.dart';
import 'package:demo_app/route_app/util.dart';
import 'package:flutter/material.dart';

class AnimalCardNamedRoute extends StatelessWidget {
  final AnimalModel animal;
  const AnimalCardNamedRoute({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return RouteNavigationWidget(animal: animal);
  }
}

class RouteNavigationWidget extends StatelessWidget {
  const RouteNavigationWidget({
    super.key,
    required this.animal,
  });

  final AnimalModel animal;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(
            title: Text(animal.naam),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/${animal.naam}.jpeg'),
            ),
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: const Icon(Icons.description),
                onTap: () => Navigator.pushNamed(context, '/omschrijving',
                    arguments:
                        AnimalDetailsArgument('omschrijving', animal: animal)),
              ),
              GestureDetector(
                child: const Icon(Icons.summarize),
                onTap: () => Navigator.pushNamed(context, '/plaatje',
                    arguments:
                        AnimalDetailsArgument('plaatje', animal: animal)),
              ),
            ],
          )
        ]));
  }
}
