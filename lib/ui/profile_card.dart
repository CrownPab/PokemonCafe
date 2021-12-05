import 'package:flutter/material.dart';
import 'package:pokemon_cafe/ui/profile_page.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfilePage())),
        child: Card(
            elevation: 2.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('User Name'),
                  Text('Super cool Graphics'),
                  Text('Some XP'),
                  Text('absolutely massive')
                ],
              ),
            )));
  }
}
