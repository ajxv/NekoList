import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:neko_list/models/user.dart';
import 'package:neko_list/models/user_animelist.dart';

import '/helpers/secure_storage.dart';
import '/helpers/constants.dart' as constants;

class MyAnimelistApi {
  final _secureStorage = SecureStorage();

  final String baseUrl = constants.apiEndpoint;

  // UserDetails
  Future<UserDetails> getUserDetails() async {
    var accessToken = await _secureStorage.getAccessToken();

    Uri url = Uri.parse("$baseUrl/users/@me?fields=anime_statistics");

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return UserDetails.fromJson(jsonDecode(response.body));
      } else {
        return Future.error("Failed to load UserDetails");
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // User AnimeList
  Future<UserAnimeList> getUserAnimeList(
      {status, sort = "list_updated_at", limit = 100, offset = 0}) async {
    var accessToken = await _secureStorage.getAccessToken();

    status = status != 'all' ? "status=$status&" : "";

    Uri url = Uri.parse(
        "$baseUrl/users/@me/animelist?fields=list_status,num_episodes&${status}sort=$sort&limit=$limit&offset=$offset");

    // try {
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return UserAnimeList.fromJson(jsonDecode(response.body));
    } else {
      return Future.error("Failed to load UserAnimeList");
    }
    // } on SocketException {
    //   return Future.error("SocketException: Check your internet connection");
    // } catch (e) {
    //   return Future.error(e.toString());
    // }
  }
}
