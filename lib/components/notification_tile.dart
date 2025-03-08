import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const NotificationTile({
    super.key,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.2), // Increased opacity from 0.1 to 0.2
                  spreadRadius: 2, // Increased from 1 to 2
                  blurRadius: 8, // Decreased from 10 to 8
                  offset: const Offset(0, 3), // Increased y-offset from 2 to 3
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 149, 212, 251).withOpacity(.3)
                    : const Color(
                        0xFF2E353D), // Couleur plus profonde et élégante pour le dark mode
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.check,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(255, 0, 55, 255).withOpacity(.5)
                    : const Color(
                        0xFF64FFDA), // Couleur turquoise claire pour un bon contraste
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFF2C3A4B)
                          : const Color.fromARGB(255, 195, 195, 195),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF808B9A),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xFFAFB8C6),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
