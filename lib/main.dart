import 'package:flutter/material.dart';
import 'package:pokemon_cafe/ui/home_page.dart';
import 'package:pokemon_cafe/ui/login_delegate.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ViewModel>(
        model: ViewModel.initialize(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: LoginDelegate(),
        ));
  }
}
