import 'package:flutter/material.dart';
import 'package:notes_app/themes/theme.dart';

class ThemeProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  ThemeData _themeData = lightMode;
  // getter
  ThemeData get themeData => _themeData;
  // setter
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  // toggle methods  
  void toggleTheme(){
    if (_themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }
  // getter to check if we are in dark mode
  bool get isDarkMode => _themeData == darkMode;
}