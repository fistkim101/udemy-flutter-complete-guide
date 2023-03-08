import 'package:flutter/material.dart';

void main() {
  runApp(GreatPlacesApp());
}

class GreatPlacesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.bottomLeft,
            child: Text('Great Places App'),
          ),
        ),
        body: Container(),
      ),
    );
  }
}
