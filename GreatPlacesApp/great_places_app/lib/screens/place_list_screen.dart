import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class PlaceListScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  @override
  Widget build(BuildContext context) {
    final PlaceListState placeListState = context.watch<PlaceListState>();

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.bottomLeft,
          child: Text('Great Places App'),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlaceAddScreen()),
              );
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: placeListState.places.length,
        itemBuilder: (context, index) =>
            PlaceItem(place: placeListState.places[index]),
      ),
    );
  }
}
