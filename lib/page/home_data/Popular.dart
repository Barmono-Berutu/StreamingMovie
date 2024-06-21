import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/data_api/api.dart';
import 'package:streaming_app/page/details_data/details_page.dart';
import 'package:streaming_app/provider/top_rated_provider.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<topRated>(context, listen: false).fetchPlaying(),
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
          return Consumer<topRated>(
            builder: (context, value, child) {
              if (value.movies.isEmpty) {
                return Center(
                  child: Text('No movies found'),
                );
              }

              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.movies.length > 5 ? 5 : value.movies.length,
                  itemBuilder: (context, index) {
                    final movie = value.movies[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage(id: movie["id"]),
                          ));
                        },
                        child: Image.network(
                          "${api.url_gambar_Original}${movie["poster_path"]}",
                          width: 120,
                          height: 180,
                          fit: BoxFit.cover,
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
