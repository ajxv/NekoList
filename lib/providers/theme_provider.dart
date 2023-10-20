import 'package:flutter/material.dart';
import 'package:neko_list/helpers/storage.dart';

import '../theme/dark_mode.dart';
import '../theme/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  final SecureStorage _storage = SecureStorage();

  ThemeData _themeData = darkMode;

  ThemeData get themeData {
    getTheme().then((value) => null);
    return _themeData;
  }

  Future<void> getTheme() async {
    String theme = await _storage.getTheme();

    theme == 'dark' ? _themeData = darkMode : _themeData = lightMode;
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() async {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }

    await _storage.setTheme(_themeData == darkMode);
  }
}
