import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class ThemeChanger with ChangeNotifier {
  ThemeChanger(this._themeData);

  ThemeData _themeData;

  getTheme() {
    _updateBar(_themeData);
    return _themeData;
  }

  setTheme(ThemeData theme) {
    _themeData = theme;
    _updateBar(_themeData);

    notifyListeners();
  }
}

_updateBar(ThemeData _themeData) {
  if (_themeData == ThemeData.dark()) {
    _updateStatusBarColor(_themeData.primaryColor);
  }
  if (_themeData == ThemeData.light()) {
    _updateStatusBarColor(_themeData.primaryColor);
  }
}

Future _updateStatusBarColor(Color backgroundColor) async {
  // Set status bar color
  await FlutterStatusbarcolor.setStatusBarColor(backgroundColor);

  // Check the constrast between the colors and set the status bar icons colors to white or dark
  if (useWhiteForeground(backgroundColor)) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
}
