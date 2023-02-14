import 'package:flutter/material.dart';

import '../widgets/widget.dart';
import '../models/models.dart';

class FilterScreen extends StatefulWidget {
  static const String routeName = '/filters';

  final Filters filters;

  FilterScreen({
    @required this.filters,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget _buildSwitchListTile({
    BuildContext context,
    String title,
    String subtitle,
    bool targetValue,
    Function updateValue,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: targetValue,
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
        ),
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Adjust your meal selection',
            style: Theme.of(context).textTheme.headline1,
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  context: context,
                  title: 'Gluten Free',
                  subtitle: 'only contain gluten-free meals.',
                  targetValue: widget.filters.isGlutenFree,
                  updateValue: (newValue) {
                    setState(() {
                      widget.filters.isGlutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  context: context,
                  title: 'Vegan',
                  subtitle: 'only contain vegan meals.',
                  targetValue: widget.filters.isVegan,
                  updateValue: (newValue) {
                    setState(() {
                      widget.filters.isVegan = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  context: context,
                  title: 'Vegetarian',
                  subtitle: 'only contain vegetarian meals.',
                  targetValue: widget.filters.isVegetarian,
                  updateValue: (newValue) {
                    setState(() {
                      widget.filters.isVegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  context: context,
                  title: 'Lactose Free',
                  subtitle: 'only contain lactose-free meals.',
                  targetValue: widget.filters.isLactoseFree,
                  updateValue: (newValue) {
                    setState(() {
                      widget.filters.isLactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
