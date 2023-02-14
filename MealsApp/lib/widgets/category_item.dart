import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/category_meal_screen.dart';

import '../models/models.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({
    this.category,
  });

  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealScreen.routeName,
      arguments: category,
    );

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return CategoryMealScreen(
    //         category: category,
    //       );
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          this.category.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              this.category.color.withOpacity(0.6),
              this.category.color,
            ],
          ),
        ),
      ),
    );
  }
}
