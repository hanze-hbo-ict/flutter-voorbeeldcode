import 'package:demo_app/views/device_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'service/location_service.dart';
import 'models/userlocation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Map Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // Voorbeeld 1
        // Standaard map met optie om naar locatie te gaan
        // home: const MapScreen());

        // VOORBEELD 2:
        // Luchthavens in het noorden
        // home: const SimpleMarkers());

        // VOORBEELD 3
        // Markers waar je op kunt klikken
        // home: const InteractiveMarkers());

        // VOORBEELD 4
        // werken met device-location
        home: const DeviceLocation());
  }
}
