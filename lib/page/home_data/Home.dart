import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/component/button.dart';
import 'package:streaming_app/component/notifikasi.dart';
import 'package:streaming_app/page/Layanan/chat_screen.dart';
import 'package:streaming_app/page/genre_details_data/genre_details.dart';
import 'package:streaming_app/page/home_data/Popular.dart';
import 'package:streaming_app/page/home_data/upcoming.dart';
import 'package:streaming_app/page/home_data/discover_page.dart';
import 'package:streaming_app/page/search_data/search_page.dart';
import 'package:streaming_app/page/see_all_page/see_all.dart';
import 'package:streaming_app/provider/discover_provider.dart';
import 'package:streaming_app/provider/genre_provider.dart';
import 'package:streaming_app/provider/upcoming.dart';
import 'package:streaming_app/provider/top_rated_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.email!.split('@')[0];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              capitalize(user.toString()),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("watch the movie", style: TextStyle(fontSize: 18)),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                        height: 300,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500/bXi6IQiQDHD00JFio5ZSZOeRSBh.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    );
                  });
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  "https://image.tmdb.org/t/p/w500/bXi6IQiQDHD00JFio5ZSZOeRSBh.jpg"),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => NotificationScreen()));
                },
                icon: Icon(Icons.notifications_none_rounded),
                iconSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    "1",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        tooltip: "Laporan",
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => ChatScreen()));
        },
        shape: CircleBorder(),
        child: Icon(
          Icons.message,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Consumer<Genres>(
                  builder: (context, value, child) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: (value.genre != true && value.genre.isNotEmpty)
                          ? value.genre.map<Widget>((genre) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => GenreDetails(
                                                nama: genre["name"],
                                                Id: genre["id"])));
                                  },
                                  child: Chip(
                                    label: Text(
                                      genre['name'] ?? '',
                                    ),
                                    backgroundColor: Colors.black87,
                                  ),
                                ),
                              );
                            }).toList()
                          : [SizedBox.shrink()],
                    );
                  },
                ),
              ),
              Button(
                icon: Icon(
                  Icons.tv,
                ),
                title: "Discover",
                onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SeeAll(
                          judul: "Discover",
                          consumerProv: Provider.of<Discover>(context))))
                },
              ),
              DiscoverPage(),
              Button(
                icon: Icon(
                  Icons.local_fire_department,
                ),
                title: "Popular",
                onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SeeAll(
                          judul: "Popular",
                          consumerProv: Provider.of<topRated>(context))))
                },
              ),
              PopularPage(),
              Button(
                icon: Icon(
                  Icons.timer,
                ),
                title: "Upcoming",
                onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SeeAll(
                          judul: "Upcoming",
                          consumerProv: Provider.of<Upcoming>(context))))
                },
              ),
              UpcomingData()
            ],
          ),
        ),
      ),
    );
  }
}
