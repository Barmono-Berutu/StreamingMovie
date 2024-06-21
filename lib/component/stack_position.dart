import 'package:flutter/material.dart';

import 'package:streaming_app/component/gambar.dart';
import 'package:streaming_app/data_api/api.dart'; // Pastikan API Anda diimpor dengan benar

class StackPosition extends StatelessWidget {
  final double radius;
  final movie;
  final double height;

  const StackPosition({
    Key? key,
    required this.radius,
    required this.movie,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (movie != null && movie["backdrop_path"] != null)
          Gambar(
            width: double.infinity,
            height: height,
            radius: radius,
            title: "${api.url_gambar_Original}${movie["backdrop_path"]}",
          )
        else
          Container(
            width: double.infinity,
            height: height,
            color: Colors.grey, // Atur warna yang sesuai
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.white,
            ),
          ),
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (movie != null && movie["poster_path"] != null)
                Gambar(
                  width: 108,
                  height: 160,
                  radius: 12,
                  title: "${api.url_gambar_Original}${movie["poster_path"]}",
                )
              else
                Container(
                  width: 108,
                  height: 160,
                  color: Colors.grey, // Atur warna yang sesuai
                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 8),
              Text(
                movie != null ? movie["title"] : "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  Text(
                    movie != null
                        ? "${movie["vote_average"]} (${movie["vote_count"]})"
                        : "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
