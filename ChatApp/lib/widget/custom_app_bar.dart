import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: Alignment.bottomLeft,
        child: Text(title),
      ),
      actions: actions,
    );
  }
}
