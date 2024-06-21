import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:streaming_app/component/stack_position.dart';
import 'package:streaming_app/page/details_data/details_page.dart';
import 'package:streaming_app/provider/discover_provider.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<Discover>(context, listen: false).fetchPlaying(),
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
          return Consumer<Discover>(
            builder: (context, value, child) {
              if (value.movies.isEmpty) {
                return Center(
                  child: Text('No movies found'),
                );
              }

              return SizedBox(
                height: 300,
                child: CarouselSlider.builder(
                  itemCount: value.movies.length > 5 ? 5 : value.movies.length,
                  itemBuilder: (context, index, realIndex) {
                    final movie = value.movies[index];
                    if (movie != null) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage(id: movie["id"]),
                          ));
                        },
                        child: StackPosition(
                          movie: movie,
                          height: 300,
                          radius: 12,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
