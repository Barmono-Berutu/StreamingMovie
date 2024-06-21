import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Edit_Profil extends StatefulWidget {
  Edit_Profil({Key? key}) : super(key: key);

  @override
  State<Edit_Profil> createState() => _Edit_ProfilState();
}

class _Edit_ProfilState extends State<Edit_Profil> {
  final userName = FirebaseAuth.instance.currentUser!;
  final userDb = FirebaseFirestore.instance.collection("user");
  Future<void> editData(String valueData) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit $valueData"),
              content: TextField(
                decoration: InputDecoration(hintText: "Data Baru"),
                onChanged: (value) => {newValue = value},
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: Text("Update"))
              ],
            ));

    if (newValue.trim().length > 0) {
      await userDb.doc(userName.email).update({valueData: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Edit"),
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
                child: SingleChildScrollView(
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
                          'Name', Data["username"], CupertinoIcons.person,
                          onTap: () => editData("username")),
                      const SizedBox(height: 10),
                      itemProfile(
                        'Phone',
                        '081234567891',
                        CupertinoIcons.phone,
                        onTap: () {
                        
                        },
                      ),
                      const SizedBox(height: 10),
                      itemProfile(
                          'email', userName.email!, CupertinoIcons.mail),
                      const SizedBox(height: 10),
                      itemProfile(
                        'date of birth',
                        '11 januari 2000',
                        CupertinoIcons.calendar,
                        onTap: () {
                          // Add onTap functionality for Date of Birth
                          // For example, you can show a date picker
                        },
                      ),
                      const SizedBox(height: 10),
                      itemProfile('bio', Data["bio"],
                          CupertinoIcons.line_horizontal_3_decrease_circle,
                          onTap: () => editData("bio")),
                    ],
                  ),
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

  Widget itemProfile(String title, String subtitle, IconData iconData,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }
}
