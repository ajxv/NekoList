import 'package:flutter/material.dart';
import 'package:neko_list/screens/splashscreen.dart';
import 'package:provider/provider.dart';

import 'providers/entry_status_provider.dart';
import 'providers/list_provider.dart';
import 'providers/session_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/trending_list_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SessionProvider()),
        ChangeNotifierProvider(create: (context) => AnimeListProvider()),
        ChangeNotifierProvider(create: (context) => MangaListProvider()),
        ChangeNotifierProvider(create: (context) => TrendingListProvider()),
        ChangeNotifierProvider(create: (context) => EntryStatusProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NekoList',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashScreen(),
    );
  }
}
