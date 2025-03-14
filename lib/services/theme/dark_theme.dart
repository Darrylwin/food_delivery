import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF181E22), // Couleur du fond
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    tertiary: Color.fromARGB(255, 215, 214, 214),
    surface: Color(0xFF2C3039), // Couleur des cartes
    inversePrimary: Color(0xFF24292D),
  ),
  // cardTheme: const CardTheme(
  //   color: Color(0xFF2C3039),
  //   elevation: 4,
  // ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181E22),
    selectedItemColor: Colors.white,
    unselectedItemColor: Color(0xff94979F),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: const Color(0xFF2C3039),
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(30),
  //     borderSide: BorderSide.none,
  //   ),
  // ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);
