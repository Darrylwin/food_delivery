import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;

  const MyTextFiled({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(filled :true,fillColor: Theme.of(context).colorScheme.tertiary,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          hintText: hintText,
          hintStyle:
              TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
