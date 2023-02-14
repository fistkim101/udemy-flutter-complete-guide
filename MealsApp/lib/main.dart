import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filters _filters;
  List<Meal> _favoriteMeals = [];

  @override
  void initState() {
    _filters = Filters(
      isGlutenFree: true,
      isVegan: true,
      isVegetarian: true,
      isLactoseFree: true,
    );
    super.initState();
  }

  void _addFavoriteMeal(Meal meal) => _favoriteMeals.add(meal);

  void _removeFavoriteMeal(Meal targetMeal) =>
      _favoriteMeals.removeWhere((meal) => meal.id == targetMeal.id);

  bool _isFavoriteMeal(String mealId) =>
      _favoriteMeals.any((meal) => meal.id == mealId);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'RaleWay',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.black87,
              ),
              bodyText2: TextStyle(
                color: Colors.black87,
              ),
              headline1: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (_) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(
              filters: _filters,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              isFavoriteMeal: _isFavoriteMeal,
              addFavoriteMeal: _addFavoriteMeal,
              removeFavoriteMeal: _removeFavoriteMeal,
            ),
        FilterScreen.routeName: (context) => FilterScreen(
              filters: _filters,
            ),
        FavoriteScreen.routeName: (context) => FavoriteScreen(
              favoriteMeals: _favoriteMeals,
            ),
      },
    );
  }
}
