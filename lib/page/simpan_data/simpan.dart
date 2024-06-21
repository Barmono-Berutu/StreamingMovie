import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/component/gambar.dart';
import 'package:streaming_app/data_api/api.dart';
import 'package:streaming_app/page/details_data/details_page.dart';
import 'package:streaming_app/provider/simpan_provider.dart';

class SimpanPage extends StatelessWidget {
  const SimpanPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Saved",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (selectedDate != null) {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  final selectedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  // Filter movies based on selectedDateTime
                  Provider.of<Simpan>(context, listen: false)
                      .filterMovies(selectedDateTime);
                } else {
                  // Clear the filter if no time is selected
                  Provider.of<Simpan>(context, listen: false).clearFilter();
                }
              } else {
                // Clear the filter if no date is selected
                Provider.of<Simpan>(context, listen: false).clearFilter();
              }
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'delete_all') {
                Provider.of<Simpan>(context, listen: false).deleteAllData();
              } else if (value == "show") {
                Provider.of<Simpan>(context, listen: false).tampilkanSemua();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete_all',
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Hapus Semua"),
                ),
              ),
              PopupMenuItem(
                value: 'show',
                child: ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text("Perlihatkan Film"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<Simpan>(
        builder: (context, value, child) {
          if (value.movies.isEmpty) {
            return Center(
              child: Text("No saved movies for the selected date and time"),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 120,
                        mainAxisExtent: 240,
                        crossAxisSpacing: 11,
                        mainAxisSpacing: 11,
                      ),
                      itemCount: value.movies.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final movie = value.movies[index];
                        return InkWell(
                          onLongPress: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(32)),
                              ),
                              context: context,
                              builder: (BuildContext context) => Container(
                                height: 250,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsPage(id: movie.id),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      leading:
                                          Icon(Icons.remove_red_eye_outlined),
                                      title: Text("Lihat Details"),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.play_arrow),
                                      title: Text("Putar Film"),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.share),
                                      title: Text("Bagikan"),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Provider.of<Simpan>(context,
                                                listen: false)
                                            .deleteData(movie.id);
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text("Hapus"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(id: movie.id),
                              ),
                            );
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
                                  title: "${api.url_gambar}${movie.gambar}",
                                  radius: 10,
                                ),
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      movie.rating,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
