import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabsController,
  });

  final TabController tabsController;

  List<Tab> _buildCategoriesTabs() => FoodCategory.values
      .map(
        (category) => Tab(
          text: category.toString().split('.').last,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: _buildCategoriesTabs(),
      controller: tabsController,
    );
  }
}
