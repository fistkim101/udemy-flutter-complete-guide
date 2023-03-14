import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double? preferredHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.preferredHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: Alignment.center,
        child: Text(title),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight ?? kToolbarHeight);
}
