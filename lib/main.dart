import 'package:flutter/material.dart';
import 'package:neko_list/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login.dart';
import 'helpers/secure_storage.dart';
import 'screens/homepage.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _secureStorage = SecureStorage();
  var _isAuth = false;

  Future<void> fetchAuthState() async {
    _isAuth = await _secureStorage.getAuthStatus();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchAuthState(),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'NekoList',
            theme: Provider.of<ThemeProvider>(context).themeData,
            // darkTheme: darkMode,
            // ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            //   useMaterial3: true,
            // ),
            home: _isAuth ? const HomePage() : const LoginPage(),
          );
        });
  }
}
