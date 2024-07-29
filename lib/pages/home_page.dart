import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Home",
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      drawer: MyDrawer(),
    );
  }
}
