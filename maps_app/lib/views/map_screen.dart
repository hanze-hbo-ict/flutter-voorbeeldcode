import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng _currentLocation = const LatLng(0.0, 0.0);

  void _scrollToLocation() {
    if (_formKey.currentState!.validate()) {
      List<String> location = _locationController.text.split(',');
      double lat = double.parse(location[0]);
      double lng = double.parse(location[1]);

      LatLng newLocation = LatLng(lat, lng);

      _mapController.move(
          newLocation, 10.0); // Move the map to the new location
      setState(() {
        _currentLocation = newLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter map demo'),
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
                  userAgentPackageName: 'nl.hanze.mad',
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
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Locatie gescheiden door komma',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Locatie invoeren 😡';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: _scrollToLocation,
                    child: const Text('Scroll naar locatie'),
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
