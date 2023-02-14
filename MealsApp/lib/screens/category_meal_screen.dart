import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/models.dart';
import '../widgets/widget.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = 'category-meal';
  final Filters filters;

  CategoryMealScreen({
    @required this.filters,
  });

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  bool _isFirstLoaded = true;
  List<Meal> _displayedMeals;
  Category _selectedCategory;

  @override
  void didChangeDependencies() {
    if (_isFirstLoaded) {
      _selectedCategory = ModalRoute.of(context).settings.arguments as Category;
      _displayedMeals = meals
          .where((meal) {
            if (widget.filters.isGlutenFree && meal.isGlutenFree) {
              return true;
            }
            if (widget.filters.isLactoseFree && meal.isLactoseFree) {
              return true;
            }
            if (widget.filters.isVegan && meal.isVegan) {
              return true;
            }
            if (widget.filters.isVegetarian && meal.isVegetarian) {
              return true;
            }

            return false;
          })
          .where((meal) => meal.categories.contains(_selectedCategory.id))
          .toList();
    }
    _isFirstLoaded = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(category.title),
        title: Text(_selectedCategory.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          meal: _displayedMeals[index],
        ),
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
