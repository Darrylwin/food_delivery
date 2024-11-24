import 'package:flutter/material.dart';

class PayementPage extends StatelessWidget {
  const PayementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Checkout",
        ),
      ),
    );
  }
}
