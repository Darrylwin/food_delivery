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
      child: TextField(
        controller: controller,
        cursorColor: const Color(0xFF666a6d), // Ajout de la couleur du curseur
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF666a6d),
          ),
          suffixIcon:this.sort ? const Icon(
            Icons.filter_list,
            color: Color(0xff575b5e),
          ) : null,
          filled: true,
          hintText: 'Search...',
          hintStyle: const TextStyle(
            color: Color(0xFFacaeb4),
          ),
          fillColor: const Color(0xFFf9f9f9),
          focusColor: const Color(0xFFf9f9f9),
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
    );
  }
}
