import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'screens/screens.dart';

void main() {
  runApp(const GreatPlacesApp());
}

class GreatPlacesApp extends StatelessWidget {
  const GreatPlacesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<PlaceListProvider, PlaceListState>(
          create: (_) => PlaceListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        ),
        routes: {
          PlaceListScreen.routeName: (context) => PlaceListScreen(),
        },
      ),
    );
  }
}
