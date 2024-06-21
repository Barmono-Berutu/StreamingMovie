import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data_api/api.dart';


class Search extends ChangeNotifier {
  List<dynamic> _movies = [];

  List<dynamic> get movies => _movies;

  Future<void> fetchSearch(String query) async {
    Uri url = Uri.parse(
        "${api.url_api}/search/movie?query=$query&api_key=${api.api_key}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      _movies = jsonDecode(response.body)["results"];
      notifyListeners();
    } else {
      throw Exception("gagal mengambil data");
    }
  }

  void clearSearch() {
    _movies.clear();
    notifyListeners();
  }
}
