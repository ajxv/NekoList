import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:neko_list/helpers/shared_preferences.dart';
import 'package:neko_list/models/anime_ranking_model.dart';
import '../models/manga_info_model.dart';
import '../models/search_model.dart';
import '../models/user_mangalist_model.dart';
import '../models/user_model.dart';
import '../models/user_animelist_model.dart';
import '../models/anime_info_model.dart';

import '../helpers/secure_storage.dart';
import '/helpers/constants.dart' as constants;

import './oauth_services.dart' as auth_services;

class MyAnimelistApi {
  final _secureStorage = SecureStorage();
  final _sharedPref = SharedPreference();

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
    bool showNSFW = await _sharedPref.getShowNSFW();

    status = status != 'all' ? "status=$status&" : "";

    Uri url = Uri.parse(
        "$baseUrl/users/@me/animelist?nsfw=$showNSFW&fields=list_status,num_episodes,status&${status}sort=$sort&limit=$limit&offset=$offset");

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
        return UserAnimeList.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return getUserAnimeList(
            status: status, sort: sort, limit: limit, offset: offset);
      } else {
        return Future.error(response.body);
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // animeInfo
  Future<AnimeInfo> getAnimeInfo({required animeId}) async {
    var accessToken = await _secureStorage.getAccessToken();
    String fields =
        "id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,nsfw,media_type,status,genres,my_list_status,num_episodes,start_season,source,average_episode_duration,rating,pictures,related_anime,related_manga,recommendations,studios,opening_themes,ending_themes";

    Uri url = Uri.parse("$baseUrl/anime/$animeId?fields=$fields");
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
        return AnimeInfo.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return getAnimeInfo(animeId: animeId);
      } else {
        return Future.error("Failed to load Anime Details");
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Search Anime/Manga
  Future<SearchResult> search(
      {required query, required contentType, limit = 100, offset = 0}) async {
    var accessToken = await _secureStorage.getAccessToken();
    bool showNSFW = await _sharedPref.getShowNSFW();

    Uri url = Uri.parse(
        "$baseUrl/$contentType?q=$query&limit=$limit&offset=$offset&nsfw=$showNSFW");

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
        return SearchResult.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return search(
            query: query,
            contentType: contentType,
            limit: limit,
            offset: offset);
      } else {
        return Future.error("Failed to load SearchResults");
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
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

    try {
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
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // remove Anime from userAnimeList
  Future<bool> removeListAnime({required int animeId}) async {
    var accessToken = await _secureStorage.getAccessToken();

    Uri url = Uri.parse("$baseUrl/anime/$animeId/my_list_status");

    try {
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
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

// ######################
// MANGA
// ######################

// User MangaList
  Future<UserMangaList> getUserMangaList(
      {status, sort = "list_updated_at", limit = 100, offset = 0}) async {
    var accessToken = await _secureStorage.getAccessToken();
    bool showNSFW = await _sharedPref.getShowNSFW();

    status = status != 'all' ? "status=$status&" : "";

    Uri url = Uri.parse(
        "$baseUrl/users/@me/mangalist?nsfw=$showNSFW&fields=list_status,num_chapters,status&${status}sort=$sort&limit=$limit&offset=$offset");

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
        return UserMangaList.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return getUserMangaList(
            status: status, sort: sort, limit: limit, offset: offset);
      } else {
        return Future.error(response.body);
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

// mangaInfo
  Future<MangaInfo> getMangaInfo({required mangaId}) async {
    var accessToken = await _secureStorage.getAccessToken();
    String fields =
        "id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,nsfw,media_type,status,genres,my_list_status,num_chapters,authors{first_name,last_name},pictures,background,related_anime,related_manga,recommendations";

    Uri url = Uri.parse("$baseUrl/manga/$mangaId?fields=$fields");
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
      return MangaInfo.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      await auth_services.refreshAccessToken();
      return getMangaInfo(mangaId: mangaId);
    } else {
      return Future.error("Failed to load Manga Details");
    }
    // } on SocketException {
    //   return Future.error("SocketException: Check your internet connection");
    // } catch (e) {
    //   return Future.error(e.toString());
    // }
  }

  // update Manga in userMangaList
  Future<bool> updateListManga({
    required int mangaId,
    required String status,
    required int chapsRead,
    required int score,
  }) async {
    var accessToken = await _secureStorage.getAccessToken();

    Uri url = Uri.parse("$baseUrl/manga/$mangaId/my_list_status");
    var data = {
      'status': status,
      'score': score.toString(),
      'num_chapters_read': chapsRead.toString(),
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
      return updateListManga(
        mangaId: mangaId,
        status: status,
        chapsRead: chapsRead,
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

  // remove Manga from userMangaList
  Future<bool> removeListManga({required int mangaId}) async {
    var accessToken = await _secureStorage.getAccessToken();

    Uri url = Uri.parse("$baseUrl/manga/$mangaId/my_list_status");

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
      return removeListManga(mangaId: mangaId);
    } else {
      return false;
    }
    // } on SocketException {
    //   return Future.error("SocketException: Check your internet connection");
    // } catch (e) {
    //   return Future.error(e.toString());
    // }
  }

  // ######################
  // HOME FEED
  // ######################

  // get trending animes
  /// rankingType = ['all', 'airing', 'upcoming', 'tv', 'ova', 'movie', 'special', 'bypopularity', 'favorite']
  Future getTrendingAnimes({rankingType = 'all', limit = 5}) async {
    var accessToken = await _secureStorage.getAccessToken();
    bool showNSFW = await _sharedPref.getShowNSFW();

    Uri url = Uri.parse(
        "$baseUrl/anime/ranking?ranking_type=$rankingType&limit=$limit&fields=mean&nsfw=$showNSFW");

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
        return AnimeRanking.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return getTrendingAnimes(rankingType: rankingType, limit: limit);
      } else {
        return Future.error("Failed to load AnimeRankings");
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // get trending mangas
  /// rankingType = ['all', 'manga', 'novels', 'oneshots', 'doujin', 'manhwa', 'manhua', 'bypopularity', 'favorite']
  Future getTrendingMangas({rankingType = 'all', limit = 5}) async {
    var accessToken = await _secureStorage.getAccessToken();
    bool showNSFW = await _sharedPref.getShowNSFW();

    Uri url = Uri.parse(
        "$baseUrl/manga/ranking?ranking_type=$rankingType&limit=$limit&fields=mean&nsfw=$showNSFW");

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
        return AnimeRanking.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return getTrendingMangas(rankingType: rankingType, limit: limit);
      } else {
        return Future.error("Failed to load AnimeRankings");
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // get anime reccomendations
  /// rankingType = ['all', 'manga', 'novels', 'oneshots', 'doujin', 'manhwa', 'manhua', 'bypopularity', 'favorite']
  Future getAnimeSuggestions({limit = 5}) async {
    var accessToken = await _secureStorage.getAccessToken();
    bool showNSFW = await _sharedPref.getShowNSFW();

    Uri url = Uri.parse(
        "$baseUrl/anime/suggestions?limit=$limit&fields=mean&nsfw=$showNSFW");

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
        return AnimeSuggestion.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await auth_services.refreshAccessToken();
        return getAnimeSuggestions(limit: limit);
      } else {
        return Future.error("Failed to load AnimeRankings");
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
