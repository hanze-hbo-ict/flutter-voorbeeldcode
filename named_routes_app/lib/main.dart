import 'package:demo_app/normal_app/normal_app.dart';
import 'package:demo_app/provider.dart';
import 'package:demo_app/route_app/router_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => AnimalProvider(), child: const RouterAnimalApp()));
