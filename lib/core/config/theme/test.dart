import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final ThemeData _lightTheme = _buildTheme(false);
  final ThemeData _darkTheme = _buildTheme(true);

  ThemeData get currentTheme => _darkMode ? _darkTheme : _lightTheme;

  bool _darkMode = false;
  bool get darkMode => _darkMode;

  String _timeZone = 'GMT+1';
  String get timeZone => _timeZone;

  void setDarkMode(bool value) {
    if (_darkMode != value) {
      _darkMode = value;
      _saveDarkMode();
      notifyListeners();
    }
  }

  Future<void> loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool("darkMode") ?? false;
    notifyListeners();
  }

  Future<void> _saveDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
  }

  void setTimeZone(String value) {
    if (_timeZone != value) {
      _timeZone = value;
      saveTimeZone();
      notifyListeners();
    }
  }

  String getTimeZone() {
    return _timeZone;
  }

  Future<void> loadTimeZone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _timeZone = prefs.getString("timeZone") ?? 'GMT+1'; // Default time zone
    notifyListeners();
  }

  Future<void> saveTimeZone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('timeZone', _timeZone);
  }

  static ThemeData _buildTheme(bool isDarkMode) {
    return ThemeData(
      iconTheme: IconThemeData(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      cardColor: isDarkMode ? const Color(0xFF5B2C6F) : const Color(0xFFD0D3D4),
      primaryColor: isDarkMode ? const Color(0xFF1f1b24) : const Color(0xffffffff),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: isDarkMode ? Colors.white : const Color(0xff1C2833), fontSize: 14),
        bodyMedium: TextStyle(color: isDarkMode ? Colors.white : const Color(0xff1C2833), fontSize: 11),
      ),
    );
  }
}
