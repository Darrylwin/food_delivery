import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({
    super.key,
    required this.controller,
    required this.sort,
  });
  TextEditingController controller = TextEditingController();
  bool sort = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: Theme.of(context).brightness == Brightness.light
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                        0.25), // Augmentation de l'opacité de 0.2 à 0.25
                    spreadRadius: 3, // Augmentation du spreadRadius de 2 à 3
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: TextField(
          controller: controller,
          cursorColor:
              const Color(0xFF666a6d), // Ajout de la couleur du curseur
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF666a6d),
            ),
            suffixIcon: sort
                ? const Icon(
                    Icons.filter_list,
                    color: Color(0xff575b5e),
                  )
                : null,
            filled: true,
            hintText: 'Search...',
            hintStyle: const TextStyle(
              color: Color(0xFFacaeb4),
            ),
            fillColor: Theme.of(context).colorScheme.surface,
            focusColor: Theme.of(context).colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
