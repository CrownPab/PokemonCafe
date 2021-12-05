import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokemon_cafe/crud.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Object?>> user = readItems();  
  
    // Temporary List for Badges
    final List<Map> myProducts =
        List.generate(4, (index) => {"id": index, "name": "Product $index"})
            .toList();

    return DefaultTabController(
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
        body: TabBarView(
          children: [
            Column(
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
                                    const CircleAvatar(
                                      radius: 140.0,
                                      backgroundImage: NetworkImage(
                                          'https://pbs.twimg.com/profile_images/1465367903981772816/9RTbOQY2_400x400.jpg'),
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
                                        padding: EdgeInsets.all(8.0),
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
                              children: const [
                                Text(
                                  "12",
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
                                    value: 0.3,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.blue),
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
                        "UserName: ",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "Preferred Store: 1365 Wilson Rd N",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "Favourite Item: Pokechino",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "Birthday: May 10th 1999",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "Gender: Male",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "Email: GaganPabla377@gmail.com",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Change Password')),
                      )
                    ],
                  ),
                )
              ],
            ),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: myProducts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    child: const Image(
                      image: AssetImage('assets/images/Boulderbadge.webp'),
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
    );
  }
}
