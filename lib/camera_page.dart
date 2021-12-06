import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:pokemon_cafe/ui/profile_page.dart';
import 'main.dart';
import 'dart:io';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image/image.dart' as img;


class CameraPage extends StatefulWidget {
  CameraPage({Key? key}) : super(key: key);
  _CameraPage createState() => _CameraPage();
}

class _CameraPage extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeController;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras.last, ResolutionPreset.medium);
    _initializeController = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(title: Text("Camera Demo")),
        body: FutureBuilder(
          future: _initializeController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var image = await _controller.takePicture();
            model.setImage(Image.file(File(image.path)));
            print(image.path);
             Navigator.pop(context);
          },
          child: Icon(Icons.camera),
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String image;
  const ImageViewer({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Viewer"),
      ),
      body: Center(
        child: Image.file(File(image)),
      ),
    );
  }
}
