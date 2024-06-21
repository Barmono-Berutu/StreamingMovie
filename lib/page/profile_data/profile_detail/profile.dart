import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  ProfileDetail({Key? key}) : super(key: key);

  final userName = FirebaseAuth.instance.currentUser!;
  final userDb = FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Detail"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: userDb.doc(userName.email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Data = snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/bXi6IQiQDHD00JFio5ZSZOeRSBh.jpg'),
                    ),
                    const SizedBox(height: 20),
                    itemProfile(
                        'Name', Data["username"], CupertinoIcons.person),
                    const SizedBox(height: 10),
                    itemProfile('Phone', '081234567891', CupertinoIcons.phone),
                    const SizedBox(height: 10),
                    itemProfile('email', userName.email!, CupertinoIcons.mail),
                    const SizedBox(height: 10),
                    itemProfile('date of birth', '11 januari 2000',
                        CupertinoIcons.calendar),
                    const SizedBox(height: 10),
                    itemProfile('bio', Data["bio"],
                        CupertinoIcons.line_horizontal_3_decrease_circle),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("error ${snapshot.error}"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(iconData),
    );
  }
}
