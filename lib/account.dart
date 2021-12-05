import 'package:flutter/material.dart';
import 'auth.dart';

class Account {
  String id;
  String birthday;
  int currentXpAmount;
  String email;
  String favDrink;
  String favFood;
  String firstName;
  String lastName;
  String password;
  int pokemonLevel;
  String preferredStore;
  String userName;
  String profileImageUrl;
  Map<String, dynamic> badges;

  Account(
      {required this.id,
      required this.birthday,
      required this.currentXpAmount,
      required this.email,
      required this.favDrink,
      required this.favFood,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.pokemonLevel,
      required this.preferredStore,
      required this.userName,
      required this.profileImageUrl,
      required this.badges});

  Map<String, dynamic> mapTo() {
    var dataMap = Map<String, dynamic>();
    dataMap['birthday'] = this.birthday;
    dataMap['CurrentXpAmount'] = this.currentXpAmount;
    dataMap['Email'] = this.email;
    dataMap['FavDrink'] = this.favDrink;
    dataMap['FavFood'] = this.favFood;
    dataMap['FirstName'] = this.firstName;
    dataMap['LastName'] = this.lastName;
    dataMap['Password'] = this.password;
    dataMap['PokemonLevel'] = this.pokemonLevel;
    dataMap['PreferredStore'] = this.preferredStore;
    dataMap['UserName'] = this.userName;
    dataMap['profileImageURL'] = this.profileImageUrl;
    dataMap['Badges'] = this.badges;
    return dataMap;
  }

  factory Account.NewAccount(String id, String email) {
    return Account(
        id: id,
        birthday: '01-01-2021',
        currentXpAmount: 0,
        email: email,
        favDrink: '',
        favFood: '',
        firstName: '',
        lastName: '',
        password: '',
        pokemonLevel: 1,
        preferredStore: '',
        userName: '',
        profileImageUrl: '',
        badges: Map.fromIterable(
            ['BoulderBadge', 'EarthBadge', 'ThunderBadge', 'VolcanoBadge'],
            key: (e) => e, value: (e) => false));
  }
  factory Account.fromMap(String id, Map<String, dynamic> map) {
    return Account(
        id: id,
        birthday: map['birthday'],
        currentXpAmount: map['CurrentXpAmount'],
        email: map['Email'],
        favDrink: map['FavDrink'],
        favFood: map['FavFood'],
        firstName: map['FirstName'],
        lastName: map['LastName'],
        password: map['Password'],
        pokemonLevel: map['PokemonLevel'],
        preferredStore: map['PreferredStore'],
        userName: map['UserName'],
        profileImageUrl: map['profileImageURL'],
        badges: (map.containsKey('Badges')) ? map['Badges'] : false);
  }
}
