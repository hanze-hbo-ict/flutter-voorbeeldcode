import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class DeviceLocation extends StatefulWidget {
  const DeviceLocation({super.key});

  @override
  State<StatefulWidget> createState() => _LocationManager();
}

class _LocationManager extends State<DeviceLocation> {
  Location location = Location();
  final MapController _controller = MapController();
  bool _mapCreated = false;

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late Future<LocationData> _locationData;

  @override
  void initState() {
    super.initState();
    _getPermissions();
    _locationData = _getLocation();
    location.onLocationChanged.listen((event) {
      setState(() {
        _locationData = _getLocation();
      });
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
            appBar: AppBar(title: const Text('Centreren op de locatie')),
            body: _locationText(context)));
  }

  Widget _locationText(BuildContext context) {
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
            if (_mapCreated) {
              LocationData data = snapshot.data!;
              double lat = data.latitude!;
              double lng = data.longitude!;
              double heading = data.heading!;
              _controller.moveAndRotate(LatLng(lat, lng), 16, -heading);
            }
            return updateableMap(context);
          }
        });
  }

  Widget updateableMap(BuildContext context) {
    LatLng foo = _mapCreated ? _controller.camera.center : const LatLng(53, 6);

    _mapCreated = true;

    return Stack(children: [
      FlutterMap(
        mapController: _controller,
        options: const MapOptions(
          initialCenter: LatLng(53.241440630171795, 6.5332570758746265),
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'nl.hanze.mad',
          ),
          MarkerLayer(markers: [
            Marker(
                point: foo,
                child: const Icon(
                  Icons.agriculture_rounded,
                  size: 60,
                ))
          ])
        ],
      )
    ]);
  }
}
