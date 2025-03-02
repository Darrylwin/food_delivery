import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
   brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1C1F26), // Couleur du fond
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Color(0xFF0D5EF9), // Bouton bleu
      surface: Color(0xFF2C3039), // Couleur des cartes
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF2C3039),
      elevation: 4,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1C1F26),
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1C1F26),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C3039),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // "Popular Menu"
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Nom des plats
      bodySmall: TextStyle(color: Colors.grey), // Nom des restaurants
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