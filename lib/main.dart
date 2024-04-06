import 'package:flutter/material.dart';
import 'package:expenses/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 12, 231, 85),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 12, 231, 85),
  brightness: Brightness.dark,
);

TextTheme kTextTheme = const TextTheme(
  bodyMedium: TextStyle(
    color: Colors.black45,
    fontSize: 18,
  ),
  headlineMedium: TextStyle(
    color: Colors.black54,
    fontSize: 32,
  ),
);
TextTheme kDarkTextTheme = const TextTheme(
  bodyMedium: TextStyle(
    color: Colors.white60,
    fontSize: 18,
  ),
  headlineMedium: TextStyle(
    color: Colors.white70,
    fontSize: 32,
  ),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData(
        colorScheme: kDarkColorScheme,
        brightness: Brightness.dark,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: kDarkColorScheme.primary,
          foregroundColor: kDarkColorScheme.onPrimary,
          elevation: 2.5,
          scrolledUnderElevation: 5,
          shadowColor: Colors.black45,
          titleSpacing: 25,
        ),
        cardTheme: const CardTheme(
          elevation: 3,
          shadowColor: Colors.black45,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
        ),
        iconTheme: IconThemeData(
          size: kDarkTextTheme.bodyMedium?.fontSize != null
              ? kDarkTextTheme.bodyMedium!.fontSize! * 1.5
              : null,
          color: kDarkTextTheme.bodyMedium?.color,
        ),
        textTheme: kDarkTextTheme,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: kColorScheme,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
          elevation: 2.5,
          scrolledUnderElevation: 5,
          shadowColor: Colors.black45,
          titleSpacing: 25,
        ),
        cardTheme: const CardTheme(
          elevation: 3,
          shadowColor: Colors.black45,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
        ),
        iconTheme: IconThemeData(
          size: kTextTheme.bodyMedium?.fontSize != null
              ? kTextTheme.bodyMedium!.fontSize! * 1.5
              : null,
          color: kTextTheme.bodyMedium?.color,
        ),
        textTheme: kTextTheme,
      ),
      home: const Expenses(),
    ),
  );
  // });
}
