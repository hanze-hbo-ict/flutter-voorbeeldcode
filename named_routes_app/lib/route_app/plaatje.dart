import 'package:demo_app/models/animal_model.dart';
import 'package:demo_app/route_app/util.dart';
import 'package:flutter/material.dart';

class AnimalPicture extends StatelessWidget {
  const AnimalPicture({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as AnimalDetailsArgument;
    AnimalModel animal = args.animal;
    String boodschap = args.boodschap;

    return Scaffold(
        appBar: AppBar(
          title: Text('$boodschap ${animal.naam}'),
        ),
        body: Center(child: Image.asset('assets/${animal.naam}.jpeg')));
  }
}
