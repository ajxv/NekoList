import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../helpers/constants.dart' as constants;
import '../helpers/secure_storage.dart';

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}

String generateCodeChallenge() {
  String code = generateRandomString(128);
  var hash = sha256.convert(ascii.encode(code));
  return base64Url
      .encode(hash.bytes)
      .replaceAll("=", "")
      .replaceAll("+", "-")
      .replaceAll("/", "_");
}

Uri buildAuthUrl() {
  String codeChallenge = generateCodeChallenge();

  SecureStorage().setPkce(codeChallenge);

  // return "${constants.authorizationEndpoint}?response_type=code&client_id=${constants.clientId}&redirect_uri=${constants.redirectUrl}&code_challenge=$codeChallenge";

  return Uri.https(constants.domain, constants.authorizationEndpoint, {
    'response_type': 'code',
    'client_id': constants.clientId,
    'redirect_uri': constants.redirectUrl,
    'code_challenge': codeChallenge
  });
}

Future<bool> processAuthResponse(String url) async {
  String authCode = Uri.parse(url).queryParameters['code']!;

  final secureStorage = SecureStorage();

  secureStorage.setAuthStatus(true);
  secureStorage.setAuthCode(authCode);

  await getAccessToken().then((value) {
    return true;
  });

  return true;
}

Future<String> getAccessToken() async {
  final secureStorage = SecureStorage();
  var authCode = await secureStorage.getAuthCode();
  var pkce = await secureStorage.getPkce();

  var response = await http.post(
    Uri.https(constants.domain, constants.tokenEndpoint),
    body: {
      'client_id': constants.clientId,
      'code': authCode,
      'code_verifier': pkce,
      'grant_type': 'authorization_code',
      'redirect_uri': constants.redirectUrl,
    },
    headers: {"Content-Type": 'application/x-www-form-urlencoded'},
  );

  var data = jsonDecode(response.body);

  secureStorage.setAccessToken(data['access_token']);
  // secureStorage.setTokenType(data['token_type']);
  secureStorage.setRefreshToken(data['refresh_token']);

  return data['access_token'];
}

Future<String> refreshAccessToken() async {
  final secureStorage = SecureStorage();
  var authCode = await secureStorage.getAuthCode();
  // var pkce = await secureStorage.getPkce();
  var refreshToken = await secureStorage.getRefreshToken();

  var response = await http.post(
    Uri.https(constants.domain, constants.tokenEndpoint),
    body: {
      'client_id': constants.clientId,
      'code': authCode,
      // 'code_verifier': pkce,
      'grant_type': 'refresh_token',
      'redirect_uri': constants.redirectUrl,
      'refresh_token': refreshToken,
    },
    headers: {"Content-Type": 'application/x-www-form-urlencoded'},
  );

  var data = jsonDecode(response.body);

  secureStorage.setAccessToken(data['access_token']);
  // secureStorage.setTokenType(data['token_type']);
  secureStorage.setRefreshToken(data['refresh_token']);
  return data['access_token'];
}
