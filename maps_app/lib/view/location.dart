import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SimpleLocation extends StatefulWidget {
  const SimpleLocation({super.key});

  @override
  State<StatefulWidget> createState() => _LocationManager();
}

class _LocationManager extends State<SimpleLocation> {
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  late Future<LocationData> _locationData;

  @override
  void initState() {
    super.initState();
    _getPermissions();
    _locationData = _getLocation();
    location.onLocationChanged.listen((event) {
      print(event);
    });
  }

  void _getPermissions() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return null;
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
    }
  }

  Future<LocationData> _getLocation() async {
    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Luchthavens in het noorden')),
            body: _locationText()));
  }

  Widget _locationText() {
    return FutureBuilder<LocationData>(
        future: _locationData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
            );
          } else {
            LocationData data = snapshot.data!;
            double lat = data.latitude!;
            double long = data.longitude!;
            double heading = data.heading!;
            return Text('Location: $lat, $long; heading: $heading');
          }
        });
  }
}
