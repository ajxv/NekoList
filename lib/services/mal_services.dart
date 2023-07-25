import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:neko_list/models/user_model.dart';
import 'package:neko_list/models/user_animelist_model.dart';
import 'package:neko_list/models/anime_info_model.dart';

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

  Future<AnimeInfo> getAnimeInfo({required animeId}) async {
    var accessToken = await _secureStorage.getAccessToken();
    String fields =
        "id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics";

    Uri url = Uri.parse("$baseUrl/anime/$animeId?fields=$fields");
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
      return AnimeInfo.fromJson(jsonDecode(response.body));
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
