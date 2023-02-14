import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widget.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite-meal';
  final List<Meal> favoriteMeals;

  FavoriteScreen({
    @required this.favoriteMeals,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.favoriteMeals.isEmpty
        ? Center(
            child: Text('empty favorite meals.'),
          )
        : ListView.builder(
            itemBuilder: (context, index) => MealItem(
              meal: widget.favoriteMeals[index],
            ),
            itemCount: widget.favoriteMeals.length,
          );
  }
}
