import 'dart:convert';

import 'package:http/http.dart' as http;

final String wire = 'https://pokeapi.co/api/v2/';

Future<PokiStats> getStats(String name) async {
  http.Response data = await http.get(Uri.parse(wire + 'pokemon/' + name));
  return PokiStats.fromMap(jsonDecode(data.body));
}

class PokiStats {
  final int hp, attack, defense;
  final String type;

  PokiStats(
      {required this.hp,
      required this.attack,
      required this.defense,
      required this.type});

  factory PokiStats.fromMap(Map<String, dynamic> items) {
    Map<String, dynamic> values = {
      'hp': 0,
      'attack': 0,
      'defense': 0,
      'type': 'normal'
    };
    items['stats'].forEach((e) {
      if (values.containsKey(e['stat']['name'])) {
        values[e['stat']['name']] = e['base_stat'];
      }
    });
    return PokiStats(
        hp: values['hp'],
        attack: values['attack'],
        defense: values['defense'],
        type: values['type']);
  }

  Map<String, dynamic> toMap() {
    return {
      'HP': hp,
      'Attack': attack,
      'Defense': defense,
      'Type': type,
    };
  }
}
