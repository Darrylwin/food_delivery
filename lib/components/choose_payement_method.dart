import 'package:flutter/material.dart';

class ChoosePayementMethod extends StatelessWidget {
  const ChoosePayementMethod({
    super.key,
    required this.icon,
  });
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: .7,
            blurRadius: 5,
            offset: const Offset(2, 2), // changé pour ombre à droite et en bas
          ),
        ],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              icon,
              height: 35,
              width: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              icon,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
