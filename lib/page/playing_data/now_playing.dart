import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/component/gambar.dart';
import 'package:streaming_app/data_api/api.dart';
import 'package:streaming_app/page/details_data/details_page.dart';
import 'package:streaming_app/provider/playing_provider.dart';

class playing_page extends StatelessWidget {
  const playing_page({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<nowPlaying>(
        builder: (context, value, child) {
          // Check if the list of movies is not empty
          if (value.movies.isEmpty) {
            // If the list is empty, display a message or widget indicating so
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.theaters,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Now_Playing",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          mainAxisExtent: 230,
                          crossAxisSpacing: 11,
                          mainAxisSpacing: 11, // Lebar setiap item
                        ),
                        itemCount: value.movies.length,
                        itemBuilder: (BuildContext ctx, index) {
                          final movie = value.movies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(id: movie["id"])));
                            },
                            child: Container(
                              color: Colors.black54,
                              padding: EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gambar(
                                      width: 180,
                                      height: 180,
                                      title:
                                          "${api.url_gambar_Original}${movie["poster_path"]}",
                                      radius: 10),
                                  Text(
                                    movie["title"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines:
                                        1, // Menampilkan teks hanya dalam satu baris
                                    overflow: TextOverflow
                                        .ellipsis, // Menggunakan elipsis jika teks terlalu panjang
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "${movie["vote_average"]} (${movie["vote_count"]})",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
