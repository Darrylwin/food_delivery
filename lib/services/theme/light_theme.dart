import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.black,
  colorScheme: const ColorScheme.light(
    primary: Color(0xff181E22),
    secondary: Color(0xFF0D5EF9), // Bouton bleu
    tertiary: Color.fromARGB(255, 52, 51, 51),
    surface: Color.fromARGB(255, 254, 237, 237), // Couleur des cartes
  ),
  // cardTheme: const CardTheme(
  //   color: Colors.white,
  //   elevation: 2,
  // ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xff28303F),
    unselectedItemColor: Color(0xff94979F),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF9F9F9),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0D5EF9), // Couleur du bouton bleu
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xff292D32),
  ),
);
