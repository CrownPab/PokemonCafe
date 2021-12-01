import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/ui/menu/menu_item_thumbnail.dart';

class MenuCarousel extends StatefulWidget {
  final List<MenuItem> menuItems;
  final String carouselName;
  MenuCarousel({Key? key, required this.menuItems, required this.carouselName})
      : super(key: key);
  _MenuCarousel createState() => _MenuCarousel();
}

class _MenuCarousel extends State<MenuCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.carouselName,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )),
          const Divider(),
          SizedBox(
              height: 130,
              child: Expanded(
                  child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: widget.menuItems
                    .map((e) => MenuItemThumbnail(item: e))
                    .toList(),
              ))),
          const Divider(),
        ],
      ),
    );
  }
}
