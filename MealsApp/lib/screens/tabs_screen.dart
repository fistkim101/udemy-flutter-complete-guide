import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/category_screen.dart';
import 'package:flutter_complete_guide/screens/favorite_screen.dart';

import '../widgets/widget.dart';
import '../models/models.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen({
    @required this.favoriteMeals,
  });

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentScreenIndex = 0;
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    _screens = [
      {'screen': CategoryScreen(), 'title': 'Categories'},
      {
        'screen': FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': 'Favorites'
      },
    ];
    super.initState();
  }

  void _selectTab(int screenIndex) {
    setState(() {
      _currentScreenIndex = screenIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens[_currentScreenIndex]['title'] as String,
        ),
      ),
      drawer: MainDrawer(),
      body: _screens[_currentScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _currentScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
