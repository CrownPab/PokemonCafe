import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';

class MenuItemThumbnail extends StatelessWidget {
  final MenuItem item;
  MenuItemThumbnail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      child: Column(children: [
        Container(
          height: 70,
          child: Image.asset(
            item.image,
          ),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        ),
        const SizedBox(height: 2.0),
        Text(
          item.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12.0),
        )
      ]),
    );
  }
}
