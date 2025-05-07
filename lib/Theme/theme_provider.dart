import 'package:flutter/material.dart';
import 'package:habit_tracker/Theme/theme.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData getThemeFromBox() {
    //get the theme from the box
    var box = Hive.box('settingsBox');
    if (box.get('theme') == 'dark') {
      return _themeData = darkMode;
    } else {
      return _themeData = lightMode;
    }
  }

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    var box = Hive.box('settingsBox');
    if (_themeData == lightMode) {
      _themeData = darkMode;
      //set the theme in the box
      box.put('theme', 'dark');
    } else {
      _themeData = lightMode;
      box.put('theme', 'light');
    }
    notifyListeners();
  }
}
