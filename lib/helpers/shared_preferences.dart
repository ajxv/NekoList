import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  // Create storage
  static SharedPreferences? _sharedPreference;

  // keys
  final String _isDarkMode = 'isDarkMode';
  final String _showNSFW = 'showNSFW';

  // get shared preference instance
  static Future<SharedPreferences> getSharedPreferences() async {
    // get new instance if null
    _sharedPreference ??= await SharedPreferences.getInstance();

    return _sharedPreference!;
  }

  // Theme
  Future setTheme(bool isDarkMode) async {
    final sharedPreference = await getSharedPreferences();

    await sharedPreference.setString(
        _isDarkMode, isDarkMode ? "true" : "false");
  }

  Future<String> getTheme() async {
    final sharedPreference = await getSharedPreferences();
    String s = sharedPreference.getString(_isDarkMode) ?? "true";

    return s == "true" ? 'dark' : 'light';
  }

  // Theme
  Future setShowNSFW(bool showNSFW) async {
    final sharedPreference = await getSharedPreferences();

    await sharedPreference.setBool(_showNSFW, showNSFW);
  }

  Future<bool> getShowNSFW() async {
    final sharedPreference = await getSharedPreferences();
    bool b = sharedPreference.getBool(_showNSFW) ?? false;

    return b;
  }

  // clear sharedPreferences
  Future clear() async {
    final sharedPreference = await getSharedPreferences();
    await sharedPreference.clear();
  }
}
