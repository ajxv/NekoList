import 'package:flutter/material.dart';
import 'package:neko_list/screens/homepage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/oauth_services.dart' as auth_helper;

class MalOauthWebView extends StatefulWidget {
  const MalOauthWebView({super.key});

  @override
  State<StatefulWidget> createState() => _MalOauthWebViewState();
}

class _MalOauthWebViewState extends State<MalOauthWebView> {
  late WebViewController _controller;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  void clearCookies() async {
    await cookieManager.clearCookies();
  }

  @override
  void initState() {
    super.initState();
    clearCookies();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (NavigationRequest request) {
        if (request.url.contains("code=")) {
          auth_helper.processAuthResponse(request.url).then((value) {
            if (value) {
              Fluttertoast.showToast(
                msg: "Login Successful",
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
              );
            }
          });
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..loadRequest(auth_helper.buildAuthUrl());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
