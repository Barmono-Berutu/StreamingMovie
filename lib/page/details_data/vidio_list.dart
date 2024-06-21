import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/page/details_data/vidio_play.dart';
import 'package:streaming_app/provider/vidio_provider.dart';

class VidioPage extends StatelessWidget {
  final id;
  const VidioPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VidioProv>(
      builder: (context, value, child) {
        value.fetchVidio(id);
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: value.movies.length,
          itemBuilder: (context, index) {
            final movie_vidio = value.movies[index];
            final videoKey = movie_vidio["key"];
            final url = "https://img.youtube.com/vi/${videoKey}/hqdefault.jpg";
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: url.hashCode == 404
                  ? Text(
                      "halo",
                      style: TextStyle(color: Colors.amber),
                    )
                  : Stack(
                      children: [
                        Image.network(
                          url.toString(),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.play_arrow,
                                    size: 40, color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => VidioPlay(
                                      youtubeKey: videoKey,
                                      name: movie_vidio["name"],
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          },
        );
      },
    );
  }
}
