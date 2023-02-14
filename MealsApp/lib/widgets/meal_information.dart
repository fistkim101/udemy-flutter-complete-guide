import 'package:flutter/material.dart';

class MealInformation extends StatelessWidget {
  final Icon icon;
  final String text;

  MealInformation({
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        icon,
        const SizedBox(
          width: 6,
        ),
        Text(text),
      ],
    );
  }
}
