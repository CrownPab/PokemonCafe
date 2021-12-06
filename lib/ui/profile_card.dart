import 'package:flutter/material.dart';
import 'package:pokemon_cafe/ui/profile_page.dart';
import 'package:pokemon_cafe/ui/shared/level_text.dart';
import 'package:pokemon_cafe/ui/shared/xp_text.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileCard extends StatelessWidget {
  double scrollDepth;
  double maxHeight = 110;
  double minHeight = 30;
  ProfileCard({Key? key, required this.scrollDepth}) : super(key: key);

  double _getHeight() {
    double height = (maxHeight - scrollDepth);

    if (height < minHeight) {
      return minHeight;
    }
    return height;
  }

  double _normalizedHeight(double min, double max) {
    double normalized = (_getHeight() - minHeight) / (maxHeight - minHeight);
    return ((max - min) * normalized) + min;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            child: Card(
                borderOnForeground: false,
                elevation: 2.0,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: _getHeight(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        Positioned(
                            left: 0,
                            top: _getHeight() / 2 -
                                _normalizedHeight(20, 50) / 2,
                            child: Container(
                              height: _normalizedHeight(20, 50),
                              width: _normalizedHeight(20, 50),
                              decoration: BoxDecoration(
                                  color: Colors.red[200],
                                  shape: BoxShape.circle),
                            )),
                        Positioned(
                            right: 0,
                            top: minHeight / 2,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  shape: BoxShape.circle),
                            )),
                        Positioned(
                            top: _normalizedHeight(10, 25),
                            left: _normalizedHeight(20, 50) + 10,
                            child: Text(
                              model.currentAccount?.userName ?? 'Username',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _normalizedHeight(22, 25),
                              ),
                            )),
                        Positioned(
                            top: _normalizedHeight(10, 25) + 30,
                            left: _normalizedHeight(20, 50) + 10,
                            child: Text(
                              (model.currentAccount?.firstName ?? '') +
                                  ', ' +
                                  (model.currentAccount?.lastName ?? ''),
                              style: TextStyle(
                                  fontSize: _normalizedHeight(12, 15),
                                  color: Colors.black.withOpacity(
                                      _normalizedHeight(0, 1) - 0.4 < 0
                                          ? 0
                                          : _normalizedHeight(0, 1) - 0.4)),
                            )),
                        Positioned(
                            child: XPText(
                                xp: model.currentAccount?.currentXpAmount ?? 0,
                                fontSize: _normalizedHeight(12, 15)),
                            right: 70 + _normalizedHeight(20, 0),
                            bottom: 14),
                        Positioned(
                            child: LevelText(
                                level: model.currentAccount?.pokemonLevel ?? 1,
                                fontSize: _normalizedHeight(20, 26)),
                            right: 40 - _normalizedHeight(0, 40),
                            bottom: 12)
                      ],
                    )))));
  }
}
