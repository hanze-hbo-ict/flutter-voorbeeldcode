class WaterModel {
  final String? id;
  final double amount;
  final DateTime dateTime;
  final String unit;

  WaterModel({
    this.id,
    required this.amount,
    required this.dateTime,
    required this.unit,
  });

  factory WaterModel.fromJson(Map<String, dynamic> jsonData, String id) {
    return WaterModel(
      id: id,
      amount: jsonData['amount'],
      dateTime: DateTime.parse(jsonData['datetime']),
      unit: jsonData['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'datetime': DateTime.now(), 'unit': unit};
  }
}
