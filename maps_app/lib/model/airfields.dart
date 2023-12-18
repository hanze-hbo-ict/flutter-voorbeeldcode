import 'package:latlong2/latlong.dart';

class AirField {
  final String abbreviation;
  final LatLng latlong;
  final String description;
  final String imageLocation;

  const AirField(
      {required this.abbreviation,
      required this.latlong,
      required this.description,
      required this.imageLocation});

  static AirField? getAirfieldByName(String name) {
    // TODO: refactor
    for (var airfield in getAirFields()) {
      if (airfield.abbreviation == name) return airfield;
    }
  }

  static List<AirField> getAirFields() {
    return const [
      AirField(
          abbreviation: "EHDR",
          latlong: LatLng(53.12026593402495, 6.134411469636145),
          description: 'Vliegveld Drachten',
          imageLocation: 'https://mandarin.nl/vlieglessen/imgs/landing.jpeg'),
      AirField(
          abbreviation: 'EHHO',
          latlong: LatLng(52.73193143977734, 6.51809407280403),
          description: 'Vliegveld Hoogeveen',
          imageLocation:
              'https://ehho.nl/wp-content/uploads/2020/04/CircuitfotoEHHO-800x480-1-600x360.jpg'),
      AirField(
          abbreviation: 'EHAL',
          latlong: LatLng(53.45346369929646, 5.685477685142787),
          description: 'Vliegveld Ameland',
          imageLocation:
              'https://www.rtvnof.nl/wp-content/uploads/2019/10/2019-ameland-vliegveld.jpg'),
      AirField(
          abbreviation: 'EHGG',
          latlong: LatLng(53.13416949763264, 6.586948183064762),
          description: 'Vliegveld Eelde',
          imageLocation:
              'https://mandarin.nl/vlieglessen/imgs/bart-op-eelde.jpeg'),
      AirField(
          abbreviation: 'EHOW',
          latlong: LatLng(53.21193136016517, 7.04118335850168),
          description: 'Vliegveld Oostwold',
          imageLocation:
              'https://oostwold-airport.nl/wp-content/uploads/2021/08/IMG_5061-scaled.jpg'),
      AirField(
          abbreviation: 'EHST',
          latlong: LatLng(53.00294417446248, 7.021270637416611),
          description: 'Vliegveld Stadskanaal',
          imageLocation:
              'https://i.pinimg.com/736x/fe/95/b2/fe95b2519d2be565d3cb5b8e939c7664--netherlands.jpg')
    ];
  }
}

/*
class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
        'completed': bool completed,
      } =>
        Todo(
          userId: userId,
          id: id,
          title: title,
          completed: completed,
        ),
      _ => throw const FormatException('Failed to load todos 😡'),
    };
  }
}
*/
