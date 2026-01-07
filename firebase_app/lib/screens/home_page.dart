import 'package:firebase_app/components/water_tile.dart';
import 'package:firebase_app/data/water_data.dart';
import 'package:firebase_app/models/water_model.dart';
import 'package:firebase_app/screens/about_page.dart';
import 'package:firebase_app/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _amountcontroller = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    Provider.of<WaterData>(context, listen: false).getWater().then(
      (waters) => {
        if (waters.isNotEmpty)
          {setState(() => _isLoading = false)}
        else
          {setState(() => _isLoading = true)},
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Water'),
          elevation: 4,
          actions: const [IconButton(onPressed: null, icon: Icon(Icons.map))],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          children: [
            !_isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.waterDataList.length,
                    itemBuilder: (context, idx) {
                      final WaterModel water = value.waterDataList[idx];
                      return WaterTile(water: water);
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addWater();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void saveWater() async {
    Provider.of<WaterData>(context, listen: false).addWater(
      WaterModel(
        amount: double.parse(_amountcontroller.text),
        dateTime: DateTime.now(),
        unit: 'ml',
      ),
    );

    if (!context.mounted) return;
  }

  void addWater() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Water toevoegen'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Hoeveel water?'),
            const SizedBox(height: 20),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: _amountcontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('hoeveelheid'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _amountcontroller.clear();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              saveWater();
              Navigator.of(context).pop();
              _amountcontroller.clear();
              //saveWaterAmount(_amountcontroller.text);
            },
            child: const Text('Opslaan'),
          ),
        ],
      ),
    );
  }
}
