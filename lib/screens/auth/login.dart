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
      backgroundColor: const Color.fromRGBO(168, 191, 255, 1),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Center(
              child: Image.asset(
                'assets/images/neko_pixelated.png',
                width: 300,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => const Color.fromRGBO(113, 138, 198, 1))),
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
