import 'package:demo_app/models/animal_model.dart';
import 'package:demo_app/route_app/util.dart';
import 'package:flutter/material.dart';

class Beschrijving extends StatefulWidget {
  const Beschrijving({super.key});

  @override
  State<StatefulWidget> createState() => _BeschrijvingState();
}

class _BeschrijvingState extends State<Beschrijving> {
  int _idx = 0;
  late String _curDesc;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as AnimalDetailsArgument;
    AnimalModel animal = args.animal;
    String boodschap = args.boodschap;

    _curDesc = switch (_idx) {
      0 => animal.frans,
      1 => animal.nederlands,
      2 => animal.duits,
      _ => 'Huh?'
    };
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.app_settings_alt_outlined), label: 'Français'),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings_outlined),
                label: 'Nederlands'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_sharp), label: 'Deutch')
          ],
          currentIndex: _idx,
          selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedItemColor:
              Theme.of(context).colorScheme.onSecondaryContainer,
          onTap: (value) {
            setState(() {
              _idx = value;
            });
          },
        ),
        appBar: AppBar(
          title: Text('$boodschap ${animal.naam}'),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _curDesc,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
                fontSize: 18,
              ),
            ),
          ),
        ));
  }
}
