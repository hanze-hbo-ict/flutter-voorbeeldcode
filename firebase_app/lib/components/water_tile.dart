import 'package:firebase_app/data/water_data.dart';
import 'package:firebase_app/models/water_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaterTile extends StatelessWidget {
  final WaterModel water;

  const WaterTile({super.key, required this.water});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Row(
          children: [
            const Icon(Icons.water_drop, size: 20, color: Colors.blue),
            Text(
              '${water.amount.toStringAsFixed(2)}${water.unit}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        subtitle: Text(DateTime.parse(water.dateTime.toString()).toString()),
        trailing: IconButton(
          onPressed: () {
            Provider.of<WaterData>(context, listen: false).delete(water);
          },
          icon: const Icon(Icons.delete, color: Colors.grey),
        ),
      ),
    );
  }
}
