import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'dart:async';

import '../service/location_service.dart';
import '../model/userlocation.dart';

class ComplexMap extends StatelessWidget {
  const ComplexMap({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      initialData: UserLocation(
          latitude: 53.241440630171795, longitude: 6.5332570758746265),
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Scaffold(
            body: _ShowCoords(),
          )),
    );
  }
}

class _ShowCoords extends StatelessWidget {
  const _ShowCoords({super.key});

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Center(
      child: Text(
          'Location: Lat${userLocation.latitude}, Long: ${userLocation.longitude}'),
    );
  }
}
