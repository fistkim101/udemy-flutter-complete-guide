import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/enum/enum.dart';
import 'package:flutter_complete_guide/widgets/meal_information.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  MealItem({
    @required this.meal,
  });

  void _selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments: meal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectMeal(context),
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 5,
                  child: Container(
                    width: 250,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      meal.title,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  MealInformation(
                    icon: Icon(Icons.schedule),
                    text: '${meal.duration.toString()} min',
                  ),
                  MealInformation(
                    icon: Icon(Icons.work),
                    text: '${meal.complexity.toText}',
                  ),
                  MealInformation(
                    icon: Icon(Icons.attach_money),
                    text: '${meal.affordability.toText}',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
