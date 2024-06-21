import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f1D2B),
      appBar: AppBar(
        title: Text('Bantuan & Dukungan',
            style: TextStyle(color: Colors.white)), // Set text color to white
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff1f1D2B),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ExpansionTile(
            iconColor: Colors.indigo.shade300,
            collapsedIconColor: Colors.white,
            leading: Icon(Icons.key, color: Colors.lightBlueAccent),
            title: Text('Bagaimana cara mereset kata sandi saya?',
                style:
                    TextStyle(color: Colors.white)), // Set text color to white
            children: <Widget>[
              ListTile(
                title: Text(
                  'Untuk mereset kata sandi Anda, pergi ke Pengaturan > Akun > Reset Kata Sandi.',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              )
            ],
          ),
          ExpansionTile(
            iconColor: Colors.indigo.shade300,
            collapsedIconColor: Colors.white,
            leading:
                Icon(Icons.contacts_outlined, color: Colors.lightBlueAccent),
            title: Text('Bagaimana cara menghubungi dukungan?',
                style:
                    TextStyle(color: Colors.white)), // Set text color to white
            children: <Widget>[
              ListTile(
                title: Text(
                  'Anda dapat menghubungi dukungan melalui email di support@example.com atau hubungi kami di +123456789.',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              )
            ],
          ),
          ExpansionTile(
            iconColor: Colors.indigo.shade300,
            collapsedIconColor: Colors.white,
            leading:
                Icon(Icons.person_3_outlined, color: Colors.lightBlueAccent),
            title: Text('Bagaimana cara memperbarui informasi profil?',
                style:
                    TextStyle(color: Colors.white)), // Set text color to white
            children: <Widget>[
              ListTile(
                title: Text(
                  'Untuk memperbarui informasi profil Anda, pergi ke Pengaturan > Profil dan lakukan perubahan yang diperlukan.',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              )
            ],
          ),
          ExpansionTile(
            iconColor: Colors.indigo.shade300,
            collapsedIconColor: Colors.white,
            leading: Icon(Icons.android, color: Colors.lightBlueAccent),
            title: Text(
              'Bagaimana cara menggunakan aplikasi?',
              style: TextStyle(color: Colors.white),
            ), // Set text color to white
            children: <Widget>[
              ListTile(
                title: Text(
                  'Tekan disini',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Code to open email app or dialer
              },
              child: Text('Hubungi Dukungan'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  minimumSize: Size(20, 50) // Background color
                  // Text Color
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
