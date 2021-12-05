import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/ui/menu/menu_carousel.dart';
import 'package:pokemon_cafe/ui/profile_card.dart';
import 'package:pokemon_cafe/ui/search_bar.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MenuPage extends StatefulWidget {
  _MenuPage createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  Map<String, List<MenuItem>>? menuSelection;
  double scrollDepth = 0;

  Widget _menuLoader(ViewModel model) {
    if (menuSelection != null) {
      return Expanded(
          child: NotificationListener<ScrollUpdateNotification>(
        child: ListView(
          shrinkWrap: true,
          children: menuSelection!.entries
              .map((e) => MenuCarousel(menuItems: e.value, carouselName: e.key))
              .toList(),
        ),
        onNotification: (notification) {
          setState(() {
            if (notification.scrollDelta != null) {
              scrollDepth += notification.scrollDelta!;
            }
          });
          return true;
        },
      ));
    } else {
      model
          .getAllMenuItems()
          .then((value) => setState(() => menuSelection = value));
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => Column(
              children: [
                SearchBar(),
                ProfileCard(
                  scrollDepth: scrollDepth,
                ),
                _menuLoader(model)
              ],
            ));
  }
}
