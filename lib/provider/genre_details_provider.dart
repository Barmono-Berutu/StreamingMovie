import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data_api/api.dart';

class GenreDetailsProv extends ChangeNotifier {
  List<dynamic> _movies = [];

  List<dynamic> get movies => _movies;

  Future<void> fetchGenreDetailsProv(int id) async {
    Uri url = Uri.parse(
        "${api.url_api}/discover/movie?api_key=${api.api_key}&with_genres=$id");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      _movies = jsonDecode(response.body)["results"];
      notifyListeners();
    } else {
      throw Exception("gagal mengambil data");
    }
  }
}
