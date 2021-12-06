import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokemon_cafe/account.dart';
import 'package:pokemon_cafe/crud.dart';
import 'package:pokemon_cafe/data/poki_api.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  Account? account;
  PokiStats? stats;
  @override
  Widget build(BuildContext context) {
    // Temporary List for Badges
    final List<Map> myProducts =
        List.generate(4, (index) => {"id": index, "name": "Product $index"})
            .toList();

    bool _isLoaded(ViewModel model) {
      if (account == null) {
        model.getAccount().then((value) {
          if (value != null) {
            print(value.id);
            print(value.email);
            setState(() {
              account = value;
            });
          }
        });
        return false;
      }
      return true;
    }

    List<Widget> _loadPokemonStats(ViewModel model) {
      if (stats == null) {
        model.getPokemonStats('charmander').then((value) {
          setState(() {
            stats = value;
          });
        });
        return [LinearProgressIndicator()];
      }
      return stats!
          .toMap()
          .entries
          .map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.key,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(e.value.toString())
                ],
              ))
          .toList();
    }

    return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(tabs: [
                    Tab(icon: Icon(Icons.person_sharp)),
                    Tab(
                      icon: Icon(Icons.star_border_purple500_rounded),
                    )
                  ]),
                  title: const Text('Profile Page'),
                ),
                body: !_isLoaded(model)
                    ? const Center(child: CircularProgressIndicator())
                    : TabBarView(
                        children: [
                          ListView(
                            children: [
                              Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 250,
                                            width: 250,
                                            child: Stack(
                                                clipBehavior: Clip.none,
                                                fit: StackFit.expand,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 140.0,
                                                    backgroundImage:
                                                        NetworkImage(account!
                                                            .profileImageUrl),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: -15,
                                                    height: 100,
                                                    width: 100,
                                                    child: RaisedButton(
                                                      onPressed: () {},
                                                      elevation: 2.0,
                                                      color: Colors.white,
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: const Image(
                                                        image: AssetImage(
                                                            'assets/images/charmander.gif'),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                account!.pokemonLevel
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              SizedBox(
                                                height: 25.0,
                                                width: 325.0,
                                                child: LinearProgressIndicator(
                                                  value:
                                                      account!.currentXpAmount /
                                                          100,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.blue),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  color: Colors.lightBlue[100]),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "UserName: ${account!.userName}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      "Preferred Store: ${account!.preferredStore}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      "Favourite Drink: ${account!.favDrink}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      "Favourite Food: ${account!.favFood}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      "Birthday: ${account!.birthday}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      "Email: ${account!.email}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      "First Name: ${account!.firstName}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Text(
                                      "Last Name: ${account!.lastName}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20),
                                    ),
                                    Card(
                                      child: Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Charmander Stats',
                                              ),
                                            ]..addAll(_loadPokemonStats(model)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 20.0)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: myProducts.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    account!.badges.toString(),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(15)),
                                );
                              }),
                        ],
                      ),
                backgroundColor: Colors.lightBlue[200],
              ),
            ));
  }
}
