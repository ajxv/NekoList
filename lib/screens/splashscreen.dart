import 'package:flutter/material.dart';

import '../helpers/secure_storage.dart';
import 'auth/login.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _secureStorage = SecureStorage();
  var _isAuth = false;

  @override
  void initState() {
    super.initState();
    _secureStorage.getAuthStatus().then((value) => _isAuth = value);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => _isAuth ? const HomePage() : const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 41, 50, 1),
      body: Center(
        child: Image.asset(
          'assets/images/logo_transparent.png',
          width: 250,
        ),
      ),
    );
  }
}
