import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/component/bottom_navbar.dart';
import 'package:streaming_app/component/gambar.dart';
import 'package:streaming_app/data_api/api.dart';
import 'package:streaming_app/page/details_data/details_page.dart';
import 'package:streaming_app/provider/search.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  late Search
      _searchProvider; // Variabel untuk menyimpan referensi ke Search provider

  @override
  void initState() {
    super.initState();
    // Mendapatkan instance Search provider saat initState
    _searchProvider = Provider.of<Search>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _searchProvider.clearSearch();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => BottomNavbar())));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<Search>(builder: (context, value, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),

                    controller: _textController, // Gunakan controller di sini
                    decoration: InputDecoration(
                      suffixIconColor: Colors.white,
                      suffixIcon: Icon(Icons.search_rounded),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fillColor: Colors.black54,
                      filled: true,
                    ),
                    onChanged: (query) {
                      value.fetchSearch(query);
                    },
                  ),
                ),
                Expanded(
                  child: value.movies.isEmpty
                      ? Text(
                          'No results found.',
                          style: TextStyle(color: Colors.white),
                        )
                      : ListView.builder(
                          itemCount: value.movies.length,
                          itemBuilder: (context, index) {
                            final movie = value.movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(id: movie["id"])));
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(8),
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    movie["poster_path"] != null
                                        ? Gambar(
                                            width: 130,
                                            height: 200,
                                            radius: 12,
                                            title:
                                                "${api.url_gambar_Original}${movie["poster_path"]}",
                                          )
                                        : Container(
                                            width: 130,
                                            height: 200,
                                            color: Colors
                                                .grey, // Atur warna yang sesuai
                                            child: Icon(
                                              Icons.image_not_supported,
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              style: TextStyle(
                                                  color: Colors.white38),
                                            ),
                                          ],
                                        ),
                                      ),
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
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    // Hapus controller saat widget tidak lagi digunakan
    _textController.dispose();
    super.dispose();
  }
}
