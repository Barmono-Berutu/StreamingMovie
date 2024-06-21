import 'package:flutter/material.dart';
import 'package:streaming_app/page/profile_data/about_data/nama.dart';
import 'package:readmore/readmore.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                color: Colors.amber.shade500,
                child: Container(
                  width: 800,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.movie_filter_outlined,
                          color: Color(0xff1f1D2B), size: 130),
                      Text(
                        'Tentang Aplikasi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff1f1D2B),
                        ),
                      ),
                      SizedBox(height: 10),
                      ReadMoreText(
                        'Jadikan waktu luangmu lebih berarti dengan menikmati koleksi film terbaru dan klasik melalui aplikasi Movie App Flutter kami. Sajikan malam film yang tak terlupakan bersama keluarga dan teman-teman. Dari aksi hingga drama, kami memiliki segala jenis film yang Anda inginkan. Bergabunglah dengan komunitas pecinta film kami dan temukan rekomendasi yang tepat untuk setiap suasana hati. Rencanakan maraton film akhir pekan Anda dengan mudah menggunakan aplikasi Movie App Flutter. Nikmati kenyamanan menonton film di rumah dengan koleksi terbesar film dalam satu aplikasi. Dapatkan akses eksklusif ke konten film terbaru dan update industri hiburan langsung dari aplikasi Movie App Flutter. Dengan fitur penilaian dan ulasan pengguna, Anda dapat menemukan film yang sempurna untuk dinikmati. Unduh aplikasi Movie App Flutter sekarang dan mulailah menikmati hiburan berkualitas. ',
                        trimMode: TrimMode.Line,
                        textAlign: TextAlign.justify,
                        trimLines: 10,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        lessStyle: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.web, color: Color(0xff1f1D2B)),
                            onPressed: () {
                              // Open website
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.mail,
                              color: Color(0xff1f1D2B),
                            ),
                            onPressed: () {
                              // Open email client
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.phone, color: Color(0xff1f1D2B)),
                            onPressed: () {
                              // Make phone call
                            },
                          ),
                        ],
                      ),
                      Text(
                        'Development Team:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 80,
                        child: PageView(
                          children: [
                            Nama(
                              title: "Barmono Berutu",
                            ),
                            Nama(
                              title: "Jhon Harefa",
                            ),
                            Nama(
                              title: "Renaldi Aritonang",
                            ),
                            Nama(
                              title: "Hendryo Marpapung",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
