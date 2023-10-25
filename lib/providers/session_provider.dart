import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/models/user_model.dart';
import 'package:neko_list/services/mal_services.dart';

class SessionProvider extends ChangeNotifier {
  UserDetails _user = UserDetails(
    id: 0,
    name: 'name',
    picture: '',
    animeStatistics: {},
  );

  UserDetails get user => _user;

  fetchUser() {
    MyAnimelistApi().getUserDetails().then((userData) {
      _user = userData;
      notifyListeners();
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
      Future.delayed(const Duration(seconds: 10)).then((val) {
        return fetchUser();
      });
    });
  }
}
