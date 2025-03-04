import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({
    super.key,
    required this.image,
    required this.onTap,
  });

  final void Function()? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 125,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Image.asset(
            image,
          ),
        ),
      ),
    );
  }
}
