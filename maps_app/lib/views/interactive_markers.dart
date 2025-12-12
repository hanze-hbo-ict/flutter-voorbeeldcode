import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/airfields.dart';

class InteractiveMarkers extends StatefulWidget {
  const InteractiveMarkers({super.key});

  @override
  State<InteractiveMarkers> createState() => _InteractiveMarkers();
}

class _InteractiveMarkers extends State<InteractiveMarkers> {
  late bool hasBeenTabbed;
  late AirField currentAirfield;

  @override
  void initState() {
    super.initState();
    hasBeenTabbed = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Luchthavens in het noorden')),
            body: Stack(children: [
              _getMap(),
              if (hasBeenTabbed)
                Center(
                    child: GestureDetector(
                  child: Image.network(
                    currentAirfield.imageLocation,
                  ),
                  onTap: () => setState(() {
                    hasBeenTabbed = false;
                  }),
                ))
            ])));
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
          userAgentPackageName: 'nl.hanze.mad',
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
            child: GestureDetector(
                child: const Icon(
                  Icons.airplanemode_active_rounded,
                  size: 60,
                  color: Colors.red,
                ),
                onTap: () => setState(() {
                      if (!hasBeenTabbed) {
                        currentAirfield = el;
                        hasBeenTabbed = true;
                      } else {
                        hasBeenTabbed = false;
                      }
                    }))))
        .toList();
  }
}
