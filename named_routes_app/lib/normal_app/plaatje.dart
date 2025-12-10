import 'package:demo_app/models/animal_model.dart';
import 'package:flutter/material.dart';

class AnimalPicture extends StatelessWidget {
  final AnimalModel animal;

  const AnimalPicture({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(animal.naam),
        ),
        body: Center(child: Image.asset('assets/${animal.naam}.jpeg')));
  }
}
