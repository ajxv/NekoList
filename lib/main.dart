import 'package:flutter/material.dart';
import 'screens/auth/login.dart';
import 'helpers/secure_storage.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
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
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
              useMaterial3: true,
            ),
            home: _isAuth ? const HomePage() : const LoginPage(),
          );
        });
  }
}
