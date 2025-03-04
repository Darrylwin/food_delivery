import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Color(0xff181E22),
    secondary: Color(0xFF0D5EF9), // Bouton bleu
    tertiary: Color.fromARGB(255, 52, 51, 51),
    surface: Color(0xFFF9F9F9), // Couleur des cartes
    inversePrimary: Color(0xFFF3F4F4),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xff28303F),
    unselectedItemColor: Color(0xff94979F),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: const Color(0xFFF9F9F9),
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(30),
  //     borderSide: BorderSide.none,
  //   ),
  // ),
  iconTheme: const IconThemeData(
    color: Color(0xff292D32),
  ),
);
