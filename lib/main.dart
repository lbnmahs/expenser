import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.greenAccent);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.blueGrey
);

void main() {
  runApp(
    MaterialApp(
      // Dark Theme Config
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7)
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kDarkColorScheme.onSecondaryContainer
          ),
        )
      ),

      // Light Theme Config
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: kColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7)
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kColorScheme.onSecondaryContainer
          ),
        )
      ),
      home: const Expenses(),
    )
  );
}


