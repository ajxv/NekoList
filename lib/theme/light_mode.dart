import 'package:flutter/material.dart';

// LIGHT MODE

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  highlightColor: const Color.fromRGBO(58, 68, 97, 1),
  splashColor: Colors.transparent,

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
    background: const Color.fromRGBO(240, 233, 233, 1),
    primary: const Color.fromRGBO(130, 0, 36, 1),
    secondary: Colors.grey.shade100,
    onPrimary: Colors.grey.shade100,
    onBackground: Colors.grey.shade900,
    onSecondary: Colors.grey.shade900,
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),

  // NavigationBar Theme (bottom)
  navigationBarTheme: NavigationBarThemeData(
    // surfaceTintColor: Colors.blue.shade900,
    backgroundColor: Color.fromARGB(255, 102, 0, 29),

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
      return IconThemeData(color: Colors.grey.shade300);
    }),
  ),

  // TabBar Theme
  tabBarTheme: TabBarTheme(
    labelColor: Colors.grey.shade900,
    unselectedLabelColor: Colors.grey,
    // indicatorColor: Colors.blueGrey,
  ),

  // slider Theme
  sliderTheme: const SliderThemeData(
    activeTrackColor: Colors.blueGrey,
  ),

  // textfield cursor color
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey.shade700),
);
