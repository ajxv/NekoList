import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/mal_services.dart';

class EntryStatusProvider extends ChangeNotifier {
  String initialStatus = '';
  final _myListStatus = {};

  get myListStatus => _myListStatus;

  // setters
  void setMyListStatus({status, score, completed, totalCount}) {
    if (status != null) _myListStatus['status'] = status;
    if (score != null) _myListStatus['score'] = score;
    if (completed != null) _myListStatus['completed'] = completed;
    if (totalCount != null) _myListStatus['totalCount'] = totalCount;

    notifyListeners();
  }

  // load status from myliststatus object
  void loadListStatus(isAnime, myListStatus, totalCount) {
    initialStatus = myListStatus.status;
    setMyListStatus(
      status: myListStatus.status,
      score: myListStatus.score,
      completed: isAnime
          ? myListStatus.numEpisodesWatched
          : myListStatus.numChaptersRead,
      totalCount: totalCount,
    );
  }

  // update status
  void updateStatus(entryId, isAnime, refreshFunction) {
    if (isAnime) {
      MyAnimelistApi()
          .updateListAnime(
        animeId: entryId,
        status: _myListStatus['status'],
        epsWatched: _myListStatus['completed'],
        score: _myListStatus['score'],
      )
          .then(
        (value) {
          Fluttertoast.showToast(msg: "Updated");

          // refresh lists
          if (initialStatus.isNotEmpty &&
              initialStatus != _myListStatus['status']) {
            refreshFunction(initialStatus);
          }

          refreshFunction(_myListStatus['status']);
          notifyListeners();
        },
      ).catchError((error) {
        Fluttertoast.showToast(msg: "Update Failed: ${error.toString()}");
      });
    } else {
      MyAnimelistApi()
          .updateListManga(
        mangaId: entryId,
        status: _myListStatus['status'],
        chapsRead: _myListStatus['completed'],
        score: _myListStatus['score'],
      )
          .then(
        (value) {
          Fluttertoast.showToast(msg: "Updated");

          // refresh lists
          if (initialStatus != _myListStatus['status']) {
            refreshFunction(initialStatus);
          }

          refreshFunction(_myListStatus['status']);
          notifyListeners();
        },
      ).catchError((error) {
        Fluttertoast.showToast(msg: "Update Failed: ${error.toString()}");
      });
    }
  }

  // remove entry from list
  void removeEntry(entryId, isAnime, refreshFunction) {
    if (isAnime) {
      MyAnimelistApi().removeListAnime(animeId: entryId).then((value) {
        // refresh list
        refreshFunction(initialStatus);
        // show toast
        Fluttertoast.showToast(msg: "Removed from List");
      }).catchError((error) {
        Fluttertoast.showToast(msg: "Update Failed: ${error.toString()}");
      });
    } else {
      MyAnimelistApi().removeListManga(mangaId: entryId).then((value) {
        // refresh list
        refreshFunction(initialStatus);
        // show toast
        Fluttertoast.showToast(msg: "Removed from List");
      }).catchError((error) {
        Fluttertoast.showToast(msg: "Update Failed: ${error.toString()}");
      });
    }
  }
}
