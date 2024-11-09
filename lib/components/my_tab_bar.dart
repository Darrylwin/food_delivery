import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabsController,
  });

  final TabController tabsController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabs: [
          Tab(
            child: Icon(Icons.home),
          ),
          Tab(
            child: Icon(Icons.settings),
          ),
          Tab(
            child: Icon(Icons.person),
          ),
        ],
        controller: tabsController,
      ),
    );
  }
}
