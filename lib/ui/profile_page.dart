import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1465367903981772816/9RTbOQY2_400x400.jpg'),
            )
          ],
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://pbs.twimg.com/media/FFJEaJEVgAU9E56?format=jpg&name=900x900'),
                          height: 300,
                          width: 300,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("12", 
                              style: TextStyle(
                              color: Colors.black,
                              )
                              ,),
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
                  color: Colors.lightBlue[100]
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "UserName: CrownPab",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Preferred Store: 1365 Wilson Rd N",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Favourite Item: Pokechino",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Birthday: May 10th 1999",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Gender: Male",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                      SizedBox(height: 12.0),
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
                        child: ElevatedButton(onPressed: () {}, child: const Text('Change Password')),
                      )
                    ],
                  ),
                )
              ],
            ),
            Icon(Icons.directions_ferry_outlined)
          ],
        ),
        backgroundColor: Colors.lightBlue[200],
      ),
    );
  }
}
