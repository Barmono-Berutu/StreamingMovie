import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data_api/api.dart';

class Genres extends ChangeNotifier {
  List<dynamic> _genre = [];

  List<dynamic> get genre => _genre;

  Genres() {
    fetchPlaying();
  }

  Future<void> fetchPlaying() async {
    Uri url =
        Uri.parse("${api.url_api}/genre/movie/list?api_key=${api.api_key}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      _genre = jsonDecode(response.body)["genres"];
      notifyListeners();
    } else {
      throw Exception("gagal mengambil data");
    }
  }
}
