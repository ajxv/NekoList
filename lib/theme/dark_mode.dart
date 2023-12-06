import 'package:flutter/material.dart';

// DARK MODE

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  highlightColor: Colors.blueGrey,

  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.grey.shade100,
    ),
    headlineSmall: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
  ),
  // ColorScheme
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade600,
    onPrimary: Colors.grey.shade300,
    onBackground: Colors.white,
    onSecondary: Colors.grey.shade300,
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),

  // NavigationBar Theme (bottom)
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.black,
    indicatorColor: Colors.blueGrey,
    shadowColor: Colors.grey.shade900,
    // surfaceTintColor: Colors.grey.shade500,

    labelTextStyle: MaterialStateTextStyle.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const TextStyle(color: Colors.white);
      }
      return const TextStyle(color: Colors.grey);
    }),
    iconTheme: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const IconThemeData(color: Colors.white);
      }
      return const IconThemeData(color: Colors.grey);
    }),
  ),

  // TabBar Theme
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey,
    indicatorColor: Colors.blueGrey,
  ),

  // FloatingActionButton Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey,
  ),

  // slider Theme
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.blueGrey,
  ),

  // textfield cursor color
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white70),
);
