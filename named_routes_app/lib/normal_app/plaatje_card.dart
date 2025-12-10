import 'package:demo_app/normal_app/beschrijving.dart';
import 'package:demo_app/models/animal_model.dart';
import 'package:demo_app/normal_app/plaatje.dart';
import 'package:demo_app/route_app/util.dart';
import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final AnimalModel animal;
  const AnimalCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return StandardNavigationWidget(animal: animal);
  }
}

class StandardNavigationWidget extends StatelessWidget {
  const StandardNavigationWidget({
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
                    arguments: AnimalDetailsArgument(animal: animal)),
              ),
              GestureDetector(
                child: const Icon(Icons.summarize),
                onTap: () => Navigator.pushNamed(context, '/plaatje',
                    arguments: AnimalDetailsArgument(animal: animal)),
              ),
            ],
          )
        ]));
  }
}
