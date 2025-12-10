class AnimalModel {
  final String naam;
  final String frans;
  final String nederlands;
  final String duits;

  AnimalModel(
      {required this.naam,
      required this.frans,
      required this.nederlands,
      required this.duits});

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
        naam: json['naam'] as String,
        frans: json['fr'] as String,
        nederlands: json['nl'] as String,
        duits: json['de'] as String);
  }
}
