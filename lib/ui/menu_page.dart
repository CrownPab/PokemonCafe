import 'package:flutter/material.dart';
import 'package:pokemon_cafe/ui/profile_card.dart';
import 'package:pokemon_cafe/ui/search_bar.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SearchBar(), ProfileCard()],
    );
  }
}
