import 'dart:io';

import 'models.dart';

class PlaceModel {
  final String id;
  final String name;
  final LocationModel location;
  final File imageFile;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageFile,
  });
}
