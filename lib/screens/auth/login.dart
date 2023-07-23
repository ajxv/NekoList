import 'package:flutter/material.dart';
import 'oauth_webview.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MalOauthWebView(),
              ),
            );
          },
          child: const Text("Login with MyAnimelist"),
        ),
      ),
    );
  }
}
