import 'package:demo_app/normal_app/beschrijving.dart';
import 'package:demo_app/models/animal_model.dart';
import 'package:demo_app/normal_app/plaatje.dart';
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
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Beschrijving(animal: animal)));
                  },
                  label: const Icon(Icons.image)),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AnimalPicture(animal: animal)));
                  },
                  label: const Icon(Icons.description)),
            ],
          )
        ]));
  }
}
