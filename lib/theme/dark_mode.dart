import 'package:flutter/material.dart';

// DARK MODE

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  highlightColor: const Color.fromRGBO(240, 106, 106, 1),
  splashColor: const Color.fromRGBO(171, 65, 65, 0.5),

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
    primary: const Color.fromRGBO(68, 7, 11, 1),
    secondary: const Color.fromRGBO(171, 65, 65, 1),
    onPrimary: Colors.grey.shade300,
    onBackground: Colors.white70,
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
    // indicatorColor: Colors.blueGrey,
  ),

  // textfield cursor color
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white70),
);
