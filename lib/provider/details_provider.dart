import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data_api/api.dart';

class Details extends ChangeNotifier {
  dynamic _movies;

  dynamic get movies => _movies;

  Future<void> fetchDetails(int id) async {
    Uri url = Uri.parse("${api.url_api}/movie/$id?api_key=${api.api_key}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      if (decodedData != null) {
        _movies = decodedData;
        notifyListeners();
      } else {
        throw Exception("Data tidak valid");
      }
    } else {
      throw Exception("Gagal mengambil data: ${response.statusCode}");
    }
  }

  void clearDetails() {
    _movies = null;
    notifyListeners();
  }
}
