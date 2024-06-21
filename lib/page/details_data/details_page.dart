import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/component/stack_position.dart';
import 'package:streaming_app/page/details_data/table.dart';
import 'package:streaming_app/page/details_data/vidio_list.dart';
import 'package:streaming_app/page/genre_details_data/genre_details.dart';
import 'package:streaming_app/provider/details_provider.dart';
import 'package:streaming_app/provider/simpan_provider.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<Details>(context, listen: false).fetchDetails(widget.id);
  }

  @override
  void dispose() {
    Provider.of<Details>(context, listen: false).clearDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailProv = Provider.of<Details>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Details Film"),
        actions: [
          Consumer<Simpan>(
            builder: (context, value, _) {
              final isSaved = value.isSaved(widget.id);
              return IconButton(
                onPressed: () {
                  if (detailProv.movies != null) {
                    if (isSaved) {
                      value.deleteData(widget.id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.indigo,
                          duration: Duration(seconds: 1),
                          content: Text("Saved"),
                        ),
                      );

                      value.addData(
                        widget.id,
                        detailProv.movies["poster_path"] ?? "",
                        detailProv.movies["title"] ?? "",
                        "${detailProv.movies["vote_average"]} (${detailProv.movies["vote_count"]})",
                        DateTime.now(),
                      );
                    }
                  }
                },
                icon: isSaved ? LineIcon.heartAlt() : LineIcon.heart(),
              );
            },
          )
        ],
      ),
      body: Consumer<Details>(
        builder: (context, value, child) {
          final movie = value.movies;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StackPosition(
                  movie: movie,
                  height: 280,
                  radius: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Trailer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 200, child: VidioPage(id: widget.id)),
                      SizedBox(height: 8),
                      Text(
                        "Release Date",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 6),
                          Text(
                            movie?["release_date"] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Genres",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children: (movie != null && movie["genres"] != null)
                            ? movie["genres"].map<Widget>((genre) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GenreDetails(
                                          nama: genre["name"],
                                          Id: genre["id"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Chip(
                                    side: BorderSide(color: Colors.amber),
                                    label: Text(
                                      genre['name'] ?? '',
                                      style: TextStyle(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    backgroundColor: Colors.black87,
                                  ),
                                );
                              }).toList()
                            : [
                                Text(
                                  "Genres not available",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        movie?["overview"] ?? "",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Summary",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      CustomTableRow(
                        title: "Adult",
                        content: movie != null
                            ? (movie["adult"] ? "Yes" : "No")
                            : "N/A",
                      ),
                      CustomTableRow(
                        title: "Popularity",
                        content:
                            movie != null ? '${movie["popularity"]}' : "N/A",
                      ),
                      CustomTableRow(
                        title: "Status",
                        content: movie != null ? movie["status"] : "N/A",
                      ),
                      CustomTableRow(
                        title: "Budget",
                        content: movie != null ? "${movie["budget"]}" : "N/A",
                      ),
                      CustomTableRow(
                        title: "Revenue",
                        content: movie != null ? "${movie["revenue"]}" : "N/A",
                      ),
                      CustomTableRow(
                        title: "Tagline",
                        content: movie != null ? movie["tagline"] : "N/A",
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
