import 'dart:convert';
import 'dart:core';

import 'package:demo_app/models/animal_model.dart';
import 'package:flutter/material.dart';

class AnimalProvider with ChangeNotifier {
  List<AnimalModel> _animalList = [];

  List<AnimalModel> get animalList => _animalList;

  Future<void> loadAnimals(BuildContext context) async {
    try {
      final jsonString =
          await DefaultAssetBundle.of(context).loadString('assets/data.json');
      _animalList = parse(jsonString);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  static List<AnimalModel> parse(String jsonString) {
    List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson
        .map((e) => AnimalModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
