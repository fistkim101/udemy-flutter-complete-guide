import 'package:flutter/material.dart';

import '../models/models.dart';
import '../data/data.dart';
import '../widgets/widget.dart';

class CategoryMealScreen extends StatelessWidget {
  static const String routeName = 'category-meal';

  // final Category category;

  // CategoryMealScreen({
  //   this.category,
  // });

  CategoryMealScreen();

  @override
  Widget build(BuildContext context) {
    final categoryFromRoute =
        ModalRoute.of(context).settings.arguments as Category;

    final List<Meal> categoryMeals = meals
        .where((meal) => meal.categories.contains(categoryFromRoute.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        // title: Text(category.title),
        title: Text(categoryFromRoute.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          meal: categoryMeals[index],
        ),
        itemCount: categoryMeals.length,
      ),
    );
  }
}
