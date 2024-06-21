import 'package:flutter/material.dart';

class Movie {
  final int id;
  final String gambar;
  final String title;
  final String rating;
  final DateTime dateTime;

  Movie(
      {required this.id,
      required this.gambar,
      required this.rating,
      required this.title,
      required this.dateTime});
}

class Simpan extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];

  List<Movie> get movies => _filteredMovies;

  void addData(
      int id, String gambar, String title, String rating, DateTime dateTime) {
    _movies.add(Movie(
      id: id,
      gambar: gambar,
      rating: rating,
      title: title,
      dateTime: dateTime,
    ));
    _filteredMovies = _movies; // Default to show all movies initially
    notifyListeners();
  }

  void deleteData(int id) {
    _movies.removeWhere((movie) => movie.id == id);
    _filteredMovies.removeWhere((movie) => movie.id == id);
    notifyListeners();
  }

  void deleteAllData() {
    _movies.clear();
    _filteredMovies.clear();
    notifyListeners();
  }

  bool isSaved(int id) {
    return _movies.any((movie) => movie.id == id);
  }

  void filterMovies(DateTime dateTime) {
    _filteredMovies = _movies.where((movie) {
      return movie.dateTime.year == dateTime.year &&
          movie.dateTime.month == dateTime.month &&
          movie.dateTime.day == dateTime.day &&
          movie.dateTime.hour == dateTime.hour &&
          movie.dateTime.minute == dateTime.minute;
    }).toList();
    notifyListeners();
  }

  void clearFilter() {
    _filteredMovies = _movies;
    notifyListeners();
  }

  void tampilkanSemua() {
    _filteredMovies = List.from(
        _movies); // Menggunakan List.from untuk membuat salinan _movies
    notifyListeners();
  }
}
