import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/component/gambar.dart';
import 'package:streaming_app/data_api/api.dart';
import 'package:streaming_app/page/details_data/details_page.dart';
import 'package:streaming_app/provider/upcoming.dart';

class UpcomingData extends StatelessWidget {
  const UpcomingData({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<Upcoming>(context, listen: false).fetchPlaying(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading movies'),
          );
        } else {
          return Consumer<Upcoming>(
            builder: (context, value, child) {
              if (value.movies.isEmpty) {
                return Center(
                  child: Text('No upcoming movies found'),
                );
              }

              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.movies.length > 5 ? 5 : value.movies.length,
                  itemBuilder: (context, index) {
                    final movie = value.movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(id: movie["id"]),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Gambar(
                              width: 130,
                              height: 300,
                              radius: 12,
                              title:
                                  "${api.url_gambar_Original}${movie["poster_path"]}",
                            ),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie["title"],
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
                                        SizedBox(width: 5),
                                        Text(
                                          "${movie["vote_average"]} (${movie["vote_count"]})",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      movie["overview"],
                                      maxLines: 3,
                                      style: TextStyle(color: Colors.white38),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
