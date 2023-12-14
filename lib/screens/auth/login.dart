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
      backgroundColor: const Color.fromRGBO(37, 41, 50, 1),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 350,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => const Color.fromRGBO(245, 111, 108, 0.9))),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MalOauthWebView(),
                  ),
                );
              },
              child: const Text(
                "Login with MyAnimelist",
                style: TextStyle(color: Color.fromRGBO(246, 246, 246, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
