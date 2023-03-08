import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class PlaceItem extends StatefulWidget {
  final PlaceModel place;

  const PlaceItem({
    required this.place,
  });

  @override
  _PlaceItemState createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(widget.place.imageFile),
            // backgroundImage: Image.file(widget.place.imageFile),
          ),
          title: Text(widget.place.name),
          subtitle: widget.place.location.address != null
              ? Text(widget.place.location.address!)
              : Container(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceDetailScreen(
                  place: widget.place,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
