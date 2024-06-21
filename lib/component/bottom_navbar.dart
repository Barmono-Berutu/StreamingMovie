import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:streaming_app/page/home_data/Home.dart';
import 'package:streaming_app/page/playing_data/now_playing.dart';
import 'package:streaming_app/page/profile_data/ProfileScreen.dart';
import 'package:streaming_app/page/simpan_data/simpan.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    playing_page(),
    SimpanPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        //
        child: Container(
          // color: Color.fromARGB(255, 28, 26, 50),
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            color:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            gap: 8,
            activeColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.black,
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.calendar,
                text: 'Now_Playing',
              ),
              GButton(
                icon: LineIcons.heart,
                text: 'Saved',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
