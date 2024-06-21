import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data_api/api.dart';

class nowPlaying extends ChangeNotifier {
  List<dynamic> _movies = [];

  List<dynamic> get movies => _movies;

  nowPlaying() {
    fetchPlaying();
  }

  Future<void> fetchPlaying() async {
    Uri url = Uri.parse("${api.url_api}/movie/upcoming?api_key=${api.api_key}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      _movies = jsonDecode(response.body)["results"];
      notifyListeners();
    } else {
      throw Exception("gagal mengambil data");
    }
  }
}
