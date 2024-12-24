import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({
    super.key,
    required this.image,
    required this.onTap,
  });
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 125,
        child: InkWell(
          onTap: onTap,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
