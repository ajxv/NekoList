import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/search_model.dart';
import '../models/user_model.dart';
import '../models/user_animelist_model.dart';
import '../models/anime_info_model.dart';

import '/helpers/secure_storage.dart';
import '/helpers/constants.dart' as constants;

import './oauth_services.dart' as auth_services;

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
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return getUserDetails();
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
        "$baseUrl/users/@me/animelist?nsfw=true&fields=list_status,num_episodes&${status}sort=$sort&limit=$limit&offset=$offset");

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
    } else if (response.statusCode == 401) {
      await auth_services.refreshAccessToken();
      return getUserAnimeList(
          status: status, sort: sort, limit: limit, offset: offset);
    } else {
      return Future.error(response.body);
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
        "id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,source,average_episode_duration,rating,pictures,related_anime,related_manga,recommendations,studios,statistics,opening_themes,ending_themes";

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
    } else if (response.statusCode == 401) {
      await auth_services.refreshAccessToken();
      return getAnimeInfo(animeId: animeId);
    } else {
      return Future.error("Failed to load UserAnimeList");
    }
    // } on SocketException {
    //   return Future.error("SocketException: Check your internet connection");
    // } catch (e) {
    //   return Future.error(e.toString());
    // }
  }

  // Search Anime/Manga
  Future<SearchResult> search(
      {required query, required contentType, limit = 100, offset = 0}) async {
    var accessToken = await _secureStorage.getAccessToken();

    Uri url =
        Uri.parse("$baseUrl/$contentType?q=$query&limit=$limit&offset=$offset");

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
      return SearchResult.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      await auth_services.refreshAccessToken();
      return search(
          query: query, contentType: contentType, limit: limit, offset: offset);
    } else {
      return Future.error("Failed to load SearchResults");
    }
    // } on SocketException {
    //   return Future.error("SocketException: Check your internet connection");
    // } catch (e) {
    //   return Future.error(e.toString());
    // }
  }

  // update anime in userAnimeList
  Future<bool> updateListAnime({
    required int animeId,
    required String status,
    required int epsWatched,
    required int score,
  }) async {
    var accessToken = await _secureStorage.getAccessToken();

    Uri url = Uri.parse("$baseUrl/anime/$animeId/my_list_status");
    var data = {
      'status': status,
      'score': score.toString(),
      'num_watched_episodes': epsWatched.toString(),
    };

    // try {
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      await auth_services.refreshAccessToken();
      return updateListAnime(
        animeId: animeId,
        status: status,
        epsWatched: epsWatched,
        score: score,
      );
    } else {
      return false;
    }
    // } on SocketException {
    //   return Future.error("SocketException: Check your internet connection");
    // } catch (e) {
    //   return Future.error(e.toString());
    // }
  }

  // remove Anime from userAnimeList
  Future<bool> removeListAnime({required int animeId}) async {
    var accessToken = await _secureStorage.getAccessToken();

    Uri url = Uri.parse("$baseUrl/anime/$animeId/my_list_status");

    // try {
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      await auth_services.refreshAccessToken();
      return removeListAnime(animeId: animeId);
    } else {
      return false;
    }
    // } on SocketException {
    //   return Future.error("SocketException: Check your internet connection");
    // } catch (e) {
    //   return Future.error(e.toString());
    // }
  }
}
