import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  // Create storage
  static SharedPreferences? _sharedPreference;

  // keys
  final String _isDarkMode = 'isDarkMode';

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

  // clear sharedPreferences
  Future clear() async {
    final sharedPreference = await getSharedPreferences();
    await sharedPreference.clear();
  }
}
