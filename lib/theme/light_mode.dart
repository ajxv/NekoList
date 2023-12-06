import 'package:flutter/material.dart';

// LIGHT MODE

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  highlightColor: Colors.blueGrey.shade200,
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.grey.shade900,
    ),
    headlineSmall: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
  ),
  // ColorScheme
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.white,
    secondary: Colors.grey.shade100,
    onPrimary: Colors.grey.shade900,
    onBackground: Colors.grey.shade900,
    onSecondary: Colors.grey.shade900,
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),

  // NavigationBar Theme (bottom)
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white,
    indicatorColor: Colors.blueGrey,
    shadowColor: Colors.grey.shade900,
    surfaceTintColor: Colors.blueGrey.shade200,

    // navigation bar labels
    labelTextStyle: MaterialStateTextStyle.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TextStyle(color: Colors.grey.shade800);
      }
      return TextStyle(color: Colors.grey.shade600);
    }),
    iconTheme: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const IconThemeData(color: Colors.white);
      }
      return IconThemeData(color: Colors.grey.shade600);
    }),
  ),

  // TabBar Theme
  tabBarTheme: TabBarTheme(
    labelColor: Colors.grey.shade900,
    unselectedLabelColor: Colors.grey,
    indicatorColor: Colors.blueGrey,
  ),

  // FloatingActionButton Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey.shade200,
  ),

  // slider Theme
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.blueGrey,
  ),

  // textfield cursor color
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey.shade700),
);
