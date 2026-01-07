import 'package:firebase_app/models/water_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WaterData extends ChangeNotifier {
  List<WaterModel> waterDataList = [];

  void addWater(WaterModel water) async {
    final url = Uri.https(dotenv.env['FIREBASE_URL']!, 'water.json');

    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'amount': double.parse(water.amount.toString()),
        'unit': 'ml',
        'datetime': DateTime.now().toString(),
      }),
    );
    if (resp.statusCode == 200) {
      final tmp = json.decode(resp.body) as Map<String, dynamic>;
      waterDataList.add(
        WaterModel(
          amount: water.amount,
          dateTime: water.dateTime,
          unit: water.unit,
          id: tmp['name'],
        ),
      );
    }
    notifyListeners();
  }

  Future<List<WaterModel>> getWater() async {
    final url = Uri.https(dotenv.env['FIREBASE_URL']!, 'water.json');

    final resp = await http.get(url);
    if (resp.statusCode == 200 && resp.body != 'null') {
      final extData = json.decode(resp.body) as Map<String, dynamic>;
      for (var w in extData.entries) {
        waterDataList.add(
          WaterModel(
            id: w.key,
            amount: w.value['amount'],
            dateTime: DateTime.parse(w.value['datetime']),
            unit: w.value['unit'],
          ),
        );
      }
    }
    notifyListeners();
    return waterDataList;
  }

  void delete(WaterModel water) async {
    final url = Uri.https(
      dotenv.env['FIREBASE_URL']!,
      'water/${water.id}.json',
    );
    http.delete(url);
    waterDataList.removeWhere((el) => el.id == water.id);
    notifyListeners();
  }
}
