import 'dart:convert';

import 'package:demo_app/cat_model.dart';
import 'package:flutter/material.dart';

class CatProvider with ChangeNotifier {
  List<CatModel> _catList = [];

  List<CatModel> get catList => _catList;

  Future<void> loadCats(BuildContext context) async {
    try {
      final jsonString =
          await DefaultAssetBundle.of(context).loadString('assets/data.json');
      _catList = parse(jsonString);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  static List<CatModel> parse(String jsonString) {
    List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson
        .map((e) => CatModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
