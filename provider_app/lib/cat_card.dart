import 'package:demo_app/cat_model.dart';
import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final CatModel cat;
  const CatCard({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        //initiallyExpanded: isDetail ? true : false,
        title: Text(cat.naam),
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/${cat.plaatje}.jpeg'),
        ),
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 75, right: 18),
              child: Column(children: [
                RichText(
                    text: TextSpan(
                        text: '${cat.omschrijving}\n',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold))),
              ]))
        ],
      ),
    );
  }
}
