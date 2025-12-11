import 'package:demo_app/models/animal_model.dart';

class AnimalDetailsArgument {
  final AnimalModel animal;
  final String boodschap;

  AnimalDetailsArgument(this.boodschap, {required this.animal});
}
