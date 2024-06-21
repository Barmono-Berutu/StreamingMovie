import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
    colorScheme: ColorScheme.dark(
      background: Color(0xff1f1D2B),
      inversePrimary: Colors.amber,
      primary: Colors.white,
    ),
    chipTheme: ChipThemeData(
        labelStyle: TextStyle(color: Colors.amber),
        side: BorderSide(color: Colors.amber) // Atur kecerahan untuk tema gelap
        ),
    iconTheme: IconThemeData(color: Colors.amber),
    // Mengatur warna ikon untuk tema gelap
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(
          255, 28, 26, 50), // Atur warna latar belakang untuk tema gelap
      selectedItemColor:
          Colors.amber, // Atur warna item yang dipilih untuk tema gelap
      unselectedItemColor:
          Colors.amber, // Atur warna item yang tidak dipilih untuk tema gelap
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff1f1D2B),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.amber, backgroundColor: Color(0xff1f1D2B)));

ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade100,
      inversePrimary: Colors.black,
      primary: Colors.black,
    ),
    chipTheme: ChipThemeData(
        labelStyle: TextStyle(color: Colors.white),
        side: BorderSide(color: Colors.white) // Atur kecerahan untuk tema gelap
        ),
    iconTheme: IconThemeData(
        color: Colors.red), // Mengatur warna ikon untuk tema terang
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(color: Colors.white),
      backgroundColor:
          Colors.white, // Atur warna latar belakang untuk tema terang
      selectedItemColor:
          Colors.white, // Atur warna item yang dipilih untuk tema terang
      unselectedItemColor:
          Colors.black, // Atur warna item yang tidak dipilih untuk tema terang
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade100,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white, backgroundColor: Color(0xff1f1D2B)));

class ThemeProv extends ChangeNotifier {
  ThemeData _themeData = dark;

  ThemeData get themeData => _themeData;

  bool get isLight => _themeData == light;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = isLight ? dark : light;
    notifyListeners();
  }
}
