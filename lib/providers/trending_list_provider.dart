import 'package:flutter/material.dart';

import '../services/mal_services.dart';

class TrendingListProvider extends ChangeNotifier {
  Map list = {};

  bool _isLoading = false;

  get isLoading => _isLoading;

  get getAnimeSuggestions =>
      list.containsKey('animeSuggestion') ? list['animeSuggestion'] : [];

  get getTopAiringAnimes =>
      list.containsKey('topAiringAnime') ? list['topAiringAnime'] : [];

  get getTopAnimes => list.containsKey('topAnime') ? list['topAnime'] : [];

  get getPopularAnimes =>
      list.containsKey('popularAnime') ? list['popularAnime'] : [];

  get getTopMangas => list.containsKey('topManga') ? list['topManga'] : [];

  get getTopManhwas => list.containsKey('topManhwa') ? list['topManhwa'] : [];

  get getPopularMangas =>
      list.containsKey('popularManga') ? list['popularManga'] : [];

  Future<void> refresh() async {
    for (var k in list.keys) {
      list[k].clear();
    }

    return getData();
  }

  void getData() async {
    _isLoading = true;

    // ANIME
    // get top airing animes
    await MyAnimelistApi()
        .getTrendingAnimes(rankingType: 'airing', limit: 10)
        .then((data) {
      list['topAiringAnime'] = data.data;
      notifyListeners();
    });

    // get anime suggestions
    await MyAnimelistApi().getAnimeSuggestions(limit: 10).then((data) {
      list['animeSuggestion'] = data.data;
      notifyListeners();
    });

    // get top anime of all time
    await MyAnimelistApi()
        .getTrendingAnimes(rankingType: 'all', limit: 10)
        .then((data) {
      list['topAnime'] = data.data;
      notifyListeners();
    });

    // get popular animes
    await MyAnimelistApi()
        .getTrendingAnimes(rankingType: 'bypopularity', limit: 10)
        .then((data) {
      list['popularAnime'] = data.data;
      notifyListeners();
    });

    // MANGA
    // get top mangas
    await MyAnimelistApi()
        .getTrendingMangas(rankingType: 'manga', limit: 10)
        .then((data) {
      list['topManga'] = data.data;
      notifyListeners();
    });

    // get top manhwas
    await MyAnimelistApi()
        .getTrendingMangas(rankingType: 'manhwa', limit: 10)
        .then((data) {
      list['topManhwa'] = data.data;
      notifyListeners();
    });

    // get popular manga/manhwas/all
    await MyAnimelistApi()
        .getTrendingMangas(rankingType: 'bypopularity', limit: 10)
        .then((data) {
      list['popularManga'] = data.data;
      notifyListeners();
    });

    _isLoading = false;
    notifyListeners();
  }
}