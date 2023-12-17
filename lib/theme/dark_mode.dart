import 'package:flutter/material.dart';

// DARK MODE

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  highlightColor: const Color.fromRGBO(245, 111, 108, 1),
  splashColor: const Color.fromARGB(50, 0, 0, 0),

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
    background: const Color.fromARGB(255, 12, 14, 20),
    primary: const Color.fromRGBO(130, 0, 36, 1),
    secondary: const Color.fromRGBO(171, 65, 65, 1),
    tertiary: Colors.red.shade300.withOpacity(0.2),
    onPrimary: Colors.grey.shade300,
    onBackground: Colors.white70,
    onSecondary: Colors.grey.shade300,
    onTertiary: Colors.grey.shade300,
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),

  // NavigationBar Theme (bottom)
  navigationBarTheme: NavigationBarThemeData(
    // surfaceTintColor: Colors.grey.shade500,
    backgroundColor: const Color.fromARGB(255, 53, 0, 15),

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
