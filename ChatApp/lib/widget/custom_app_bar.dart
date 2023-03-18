import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double? preferredHeight;
  final Widget? customLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.preferredHeight,
    this.customLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: Alignment.bottomLeft,
        child: Text(title),
      ),
      actions: actions,
      iconTheme: Theme.of(context).iconTheme,
      leading: customLeading ??
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight ?? kToolbarHeight);
}
