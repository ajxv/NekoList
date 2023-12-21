import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/models/user_model.dart';
import 'package:neko_list/services/mal_services.dart';

import '../helpers/shared_preferences.dart';

class SessionProvider extends ChangeNotifier {
  UserDetails _user = UserDetails(
    id: 0,
    name: 'name',
    picture: '',
    animeStatistics: {},
  );

  bool _showNSFW = false;

  UserDetails get user => _user;

  bool get showNSFW => _showNSFW;

  Map<String, double> get animeStat => {
        'Watching': _user.animeStatistics['num_items_watching']!,
        'Completed': _user.animeStatistics['num_items_completed']!,
        'On Hold': _user.animeStatistics['num_items_on_hold']!,
        'Dropped': _user.animeStatistics['num_items_dropped']!,
        'Planned': _user.animeStatistics['num_items_plan_to_watch']!,
      };

  fetchUser() async {
    await MyAnimelistApi().getUserDetails().then((userData) {
      _user = userData;
      notifyListeners();
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
      Future.delayed(const Duration(seconds: 10)).then((val) {
        return fetchUser();
      });
    });

    await SharedPreference().getShowNSFW().then((b) {
      _showNSFW = b;
    });
  }

  setShowNSFW(bool value) {
    SharedPreference().setShowNSFW(value).then((b) {
      _showNSFW = b;
      notifyListeners();
    });
  }
}
