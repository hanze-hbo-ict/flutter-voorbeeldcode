import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../model/airfields.dart';

class SimpleMarkers extends StatelessWidget {
  const SimpleMarkers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Luchthavens in het noorden')),
            body: _getMap()));
  }

  Widget _getMap() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(53.241440630171795, 6.5332570758746265),
        initialZoom: 9,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: _getMarkers()),
      ],
    );
  }

  List<Marker> _getMarkers() {
    return AirField.getAirFields()
        .map((el) => Marker(
              point: el.latlong,
              width: 60,
              height: 60,
              child: const Icon(
                Icons.airplanemode_active_rounded,
                size: 60,
                color: Colors.red,
              ),
            ))
        .toList();
  }
}
