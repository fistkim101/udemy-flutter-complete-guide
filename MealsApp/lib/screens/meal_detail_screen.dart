import 'package:flutter/material.dart';

import '../models/models.dart';

class MealDetailScreen extends StatefulWidget {
  static const String routeName = '/meal-detail';
  Function isFavoriteMeal;
  Function addFavoriteMeal;
  Function removeFavoriteMeal;

  MealDetailScreen({
    @required this.isFavoriteMeal,
    @required this.addFavoriteMeal,
    @required this.removeFavoriteMeal,
  });

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget _buildIngredients(BuildContext context, Meal selectedMeal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView.builder(
        itemBuilder: (ctx, index) => Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(selectedMeal.ingredients[index])),
        ),
        itemCount: selectedMeal.ingredients.length,
      ),
    );
  }

  Widget _buildSteps(BuildContext context, Meal selectedMeal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 300,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView.builder(
        itemBuilder: (ctx, index) => Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text('# ${(index + 1)}'),
              ),
              title: Text(
                selectedMeal.steps[index],
              ),
            ),
            Divider()
          ],
        ),
        itemCount: selectedMeal.steps.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'ingredients',
              style: Theme.of(context).textTheme.headline1,
            ),
            _buildIngredients(
              context,
              meal,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'steps',
              style: Theme.of(context).textTheme.headline1,
            ),
            _buildSteps(
              context,
              meal,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          widget.isFavoriteMeal(meal.id) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          setState(() {
            if (!widget.isFavoriteMeal(meal.id)) {
              widget.addFavoriteMeal(meal);
            } else {
              widget.removeFavoriteMeal(meal);
            }
          });
        },
      ),
    );
  }
}
