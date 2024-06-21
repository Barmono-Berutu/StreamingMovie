import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:streaming_app/page/login_data/auth_page.dart';
import 'package:streaming_app/page/profile_data/about_data/about_page.dart';
import 'package:streaming_app/page/profile_data/help_data/help.dart';
import 'package:streaming_app/page/profile_data/profile_detail/edit_profil.dart';
import 'package:streaming_app/page/profile_data/profile_detail/profile.dart';
import 'package:streaming_app/page/profile_data/settings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 120,
                height: 120,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/bXi6IQiQDHD00JFio5ZSZOeRSBh.jpg'),
                )),
            const SizedBox(height: 15),
            Text(
              user!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Edit_Profil()));
              },
              child: Text(
                "Edit Profile",
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  foregroundColor: Theme.of(context).colorScheme.background,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                  minimumSize: Size(200, 50)),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            //menu
            ProfileMenuWidget(
              title: "User",
              textColor: Theme.of(context).colorScheme.primary,
              icon: LineIcons.userCog,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDetail(),
                  ),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Help",
              textColor: Theme.of(context).colorScheme.primary,
              icon: LineIcons.helpingHands,
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => HelpPage()));
              },
            ),
            ProfileMenuWidget(
              title: "About",
              textColor: Theme.of(context).colorScheme.primary,
              icon: LineIcons.info,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ProfileMenuWidget(
              title: "Settings",
              textColor: Theme.of(context).colorScheme.primary,
              icon: LineIcons.cog,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),

            ProfileMenuWidget(
              title: "Logout",
              textColor: Colors.red,
              icon: Icons.output_rounded,
              endIcon: false,
              onPress: () async {
                print("click");
                try {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                            child: Container(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Apakah anda yakin ingin keluar ? "),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            minimumSize: Size(50, 50),
                                          ),
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Auth_Page(),
                                              ),
                                            );
                                          },
                                          child: Text("Ya")),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            minimumSize: Size(50, 50),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Tidak")),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                } catch (e) {
                  print("Error signing out: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Colors.indigoAccent,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18).apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 18.0,
              ),
            )
          : null,
    );
  }
}
