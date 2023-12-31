import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/mal_services.dart';
import '../widgets/list_entry_card_widget.dart';

class AnimeListProvider extends ChangeNotifier {
  // List animeStatuses = [
  //   "watching",
  //   "plan_to_watch",
  //   "on_hold",
  //   "completed",
  //   "dropped",
  //   "all"
  // ];

  // Map defaultListDataValues = {
  //   'isLoading': false,
  //   'hasMore': true,
  //   'offset': 0,
  //   'data': []
  // };

  Map listData = {
    "watching": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "plan_to_watch": {
      'isLoading': false,
      'hasMore': true,
      'offset': 0,
      'data': []
    },
    "on_hold": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "completed": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "dropped": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "all": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []}
  };

  bool hasMoreItems(status) => listData[status]['hasMore'];
  List getCardList(status) => listData[status]['data'];

  // fetch data
  void getAnimeCards(status, {int limit = 100}) {
    var currentList = listData[status];

    if (currentList['isLoading']) return;
    currentList['isLoading'] = true;

    MyAnimelistApi()
        .getUserAnimeList(
            status: status, offset: currentList['offset'], limit: limit)
        .then((userAnimeList) {
      List<ListEntryCard> cardList = [];

      cardList = userAnimeList.data
          .map((data) => ListEntryCard(
                isAnime: true,
                entryId: data.node.id,
                imageUrl: data.node.mainPicture.medium,
                title: data.node.title,
                subtitle: Text(
                  "${data.listStatus.numEpisodesWatched}/${data.node.numEpisodes != 0 ? data.node.numEpisodes : '?'}",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                userRating: data.listStatus.score,
                isAiring: data.node.airingStatus == 'currently_airing',
                labelMaxLines: 1,
              ))
          .toList();

      currentList['data'].addAll(cardList);
      currentList['isLoading'] = false;
      currentList['offset'] += limit;

      currentList['hasMore'] = !(cardList.length < limit);

      notifyListeners();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      Future.delayed(const Duration(seconds: 10)).then((val) {
        refresh(status);
      });
    });
  }

  void refresh(status) {
    var currentList = listData[status];
    // set default values
    currentList['isLoading'] = false;
    currentList['hasMore'] = true;
    currentList['offset'] = 0;
    currentList['data'].clear();

    notifyListeners();
  }
}

class MangaListProvider extends ChangeNotifier {
  // List animeStatuses = [
  // "reading",
  // "plan_to_read",
  // "on_hold",
  // "completed",
  // "dropped",
  // "all"
  // ];

  // Map defaultListDataValues = {
  //   'isLoading': false,
  //   'hasMore': true,
  //   'offset': 0,
  //   'data': []
  // };

  Map listData = {
    "reading": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "plan_to_read": {
      'isLoading': false,
      'hasMore': true,
      'offset': 0,
      'data': []
    },
    "on_hold": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "completed": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "dropped": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []},
    "all": {'isLoading': false, 'hasMore': true, 'offset': 0, 'data': []}
  };

  bool hasMoreItems(status) => listData[status]['hasMore'];
  List getCardList(status) => listData[status]['data'];

  // fetch data
  void getMangaCards(status, {int limit = 100}) {
    var currentList = listData[status];

    if (currentList['isLoading']) return;
    currentList['isLoading'] = true;

    MyAnimelistApi()
        .getUserMangaList(
            status: status, offset: currentList['offset'], limit: limit)
        .then((userMangaList) {
      List<ListEntryCard> cardList = [];

      cardList = userMangaList.data
          .map((data) => ListEntryCard(
                isAnime: false,
                entryId: data.node.id,
                imageUrl: data.node.mainPicture.medium,
                title: data.node.title,
                subtitle: Text(
                  "${data.listStatus.numChaptersRead}/${data.node.numChapters != 0 ? data.node.numChapters : '?'}",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                userRating: data.listStatus.score,
                labelMaxLines: 1,
                isAiring: data.node.publishingStatus == 'currently_publishing',
              ))
          .toList();

      currentList['data'].addAll(cardList);
      currentList['isLoading'] = false;
      currentList['offset'] += limit;

      currentList['hasMore'] = !(cardList.length < limit);

      notifyListeners();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      Future.delayed(const Duration(seconds: 10)).then((val) {
        refresh(status);
      });
    });
  }

  void refresh(status) {
    var currentList = listData[status];
    // set default values
    currentList['isLoading'] = false;
    currentList['hasMore'] = true;
    currentList['offset'] = 0;
    currentList['data'].clear();

    notifyListeners();
  }
}
