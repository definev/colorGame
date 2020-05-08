import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  String _nameTheme;

  ThemeChanger(this._themeData, this._nameTheme);

  getTheme() => _themeData;
  getName() => _nameTheme;
  setTheme(ThemeData theme, String name) {
    _themeData = theme;
    _nameTheme = name;

    notifyListeners();
  }
}
