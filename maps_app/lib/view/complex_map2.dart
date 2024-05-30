import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../service/location_service.dart';
import '../model/userlocation.dart';

class InteractiveMap extends StatelessWidget {
  const InteractiveMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(0.0, 0.0);

  void _scrollToLocation() {
    if (_formKey.currentState!.validate()) {
      String location = _locationController.text;
      // Perform geocoding to get coordinates from the entered location (not included in this example)

      // For demo purposes, directly setting coordinates of Cupertino, CA
      double lat = 37.3230;
      double lng = -122.0322;

      LatLng newLocation = LatLng(lat, lng);

      _mapController.move(
          newLocation, 15.0); // Move the map to the new location
      setState(() {
        _currentLocation = newLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Map'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: LatLng(53.241440630171795, 6.5332570758746265),
                initialZoom: 9,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: _currentLocation,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                  ),
                ]),
                // MarkerLayer(markers: _getMarkers()),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Enter Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: _scrollToLocation,
                    child: Text('Scroll To Location'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
