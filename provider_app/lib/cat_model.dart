class CatModel {
  final String naam;
  final String plaatje;
  final String omschrijving;

  CatModel(
      {required this.naam, required this.plaatje, required this.omschrijving});

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
        naam: json['naam'] as String,
        plaatje: json['plaatje'] as String,
        omschrijving: json['omschrijving'] as String);
  }
}
