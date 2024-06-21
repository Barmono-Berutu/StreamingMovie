import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/component/stack_position.dart';
import 'package:streaming_app/page/details_data/details_page.dart';

class SeeAll extends StatelessWidget {
  final consumerProv;
  final String judul;
  const SeeAll({super.key, required this.consumerProv, required this.judul});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
        ),
      ),
      body: ListView.builder(
        itemCount: consumerProv.movies.length,
        itemBuilder: (context, index) {
          final movie = consumerProv.movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(id: movie["id"])));
            },
            child: Container(
                padding: EdgeInsets.all(8.0),
                // margin: EdgeInsets.all(8.0),
                child: StackPosition(
                  movie: movie,
                  height: 280,
                  radius: 12,
                )),
          );
        },
      ),
    );
  }
}
