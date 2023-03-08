import 'package:flutter/material.dart';

import '../models/models.dart';

class PlaceDetailScreen extends StatelessWidget {
  static String routeName = '/place-detail';

  final PlaceModel place;

  const PlaceDetailScreen({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(place.name),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.file(
              place.imageFile,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 15,
            ),
            Text('name : ${place.name}'),
            const SizedBox(
              height: 15,
            ),
            Text('location : ${place.toString()}'),
          ],
        ),
      ),
    );
  }
}
