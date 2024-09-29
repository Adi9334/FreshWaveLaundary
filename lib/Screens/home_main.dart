import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:freshwavelaundry/Components/CurvedAppBarClipper.dart';
import 'package:freshwavelaundry/Components/CurvedBorderPainter.dart';
import 'package:freshwavelaundry/Screens/Home_screen.dart';
import 'package:freshwavelaundry/Screens/Myorders_screen.dart';
import 'package:freshwavelaundry/Screens/NotificationScreen.dart';
import 'package:freshwavelaundry/Screens/Profile_screen.dart';
import 'package:freshwavelaundry/Screens/Referpagescreen.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class home_main extends StatefulWidget {
  home_main({super.key});

  @override
  State<home_main> createState() => _home_mainState();
}

class _home_mainState extends State<home_main> {
  int _currentIndex = 0;

  List<Widget> _screens = [
    Home_screen(),
    Myorder_screen(),
    Referpagescreen(),
    Profile_screen()
  ];
  List<String> _appbarTitles = [
    'Fresh Wave Laundry',
    'My Orders',
    'Invite Friend',
    'Profile'
  ];

  @override
  void initState() {
    super.initState();
    // Add callback to handle system back button press
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ModalRoute.of(context)?.addScopedWillPopCallback(_onBackPressed);
    });
  }

  Future<bool> _onBackPressed() async {
    if (_currentIndex == 0) {
      // If on the home screen (index 0), show exit confirmation dialog
      bool exitConfirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure you want to exit?',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                exit(0); // Exit the app
              },
              child: Text('Yes',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      );
      return exitConfirmed ?? false; // Return the dialog result or false
    } else {
      // If not on the home screen, navigate back to the home screen
      setState(() {
        _currentIndex = 0;
      });
      return false; // Do not exit the app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blue
            ], // Replace with your gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: _currentIndex == 0
                            ? Alignment.centerLeft
                            : Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: _currentIndex == 0
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                )
                              : BoxDecoration(),
                          child: _currentIndex == 0
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                      height: 50,
                                      width: 120,
                                      fit: BoxFit.fill,
                                      "assets/images/freshwavelogo.png"),
                                )
                              : Text(
                                  _appbarTitles[_currentIndex],
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    if (_currentIndex == 0)
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.notifications_active_sharp,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _screens[_currentIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey,
            ),
            BottomNavyBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/myorders2.png'),
              ),
              title: Text('My Orders',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey,
            ),
            BottomNavyBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/refer.png'),
              ),
              title: Text('Refer',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey,
            ),
            BottomNavyBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/profile1.png'),
              ),
              title: Text('Profile',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.blueGrey,
            ),
          ]),
    );
  }
}
