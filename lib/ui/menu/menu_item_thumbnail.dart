import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/ui/product_page.dart';

class MenuItemThumbnail extends StatelessWidget {
  final MenuItem item;
  final String collectionName;
  MenuItemThumbnail({Key? key, required this.item, this.collectionName = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProductPage(menuItem: item, collectionName: collectionName))),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(5.0),
          child: Column(children: [
            Container(
              height: 70,
              child: Hero(
                  tag: item.id + collectionName + 'image',
                  child: Image.asset('assets/images/coffee-cup.png'
                      // item.image,
                      )),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
            ),
            const SizedBox(height: 2.0),
            Text(
              item.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12.0),
            )
          ]),
        ));
  }
}
