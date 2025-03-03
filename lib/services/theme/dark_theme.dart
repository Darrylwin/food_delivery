import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF181E22), // Couleur du fond
  primaryColor: Colors.white,
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    secondary: Color(0xFF0D5EF9), // Bouton bleu
    tertiary:  Color.fromARGB(255, 215, 214, 214),
    surface: Color(0xFF2C3039), // Couleur des cartes
  ),
  // cardTheme: const CardTheme(
  //   color: Color(0xFF2C3039),
  //   elevation: 4,
  // ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF181E22),
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181E22),
    selectedItemColor: Colors.white,
    unselectedItemColor: Color(0xff94979F),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2C3039),
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
    color: Colors.white,
  ),
);
