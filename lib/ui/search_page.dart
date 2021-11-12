import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final String query;

  SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Search Page')),
    );
  }
}
