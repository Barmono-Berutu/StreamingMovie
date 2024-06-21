import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Membuat list notifikasi sebagai contoh
  List<String> notifications =
      List.generate(10, (index) => 'Notification ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: notifications.length, // Menggunakan panjang list notifikasi
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(notifications[index]), // Key unik untuk setiap item
            onDismissed: (direction) {
              // Menghapus item dari list berdasarkan index
              setState(() {
                notifications.removeAt(index);
              });

              // Menampilkan snackbar sebagai konfirmasi penghapusan
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notification dismissed'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            background: Container(
                color: Color(0xff1f1D2B)), // Warna latar saat item digeser
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    notifications[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'This is ${notifications[index]} description.',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
