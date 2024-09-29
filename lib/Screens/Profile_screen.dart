import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/Profile_card.dart';
import 'package:freshwavelaundry/Components/UserDetailCard.dart';
import 'package:freshwavelaundry/Models/user_model.dart';
import 'package:freshwavelaundry/Screens/CouponScreen.dart';
import 'package:freshwavelaundry/Screens/FAQScreen.dart';
import 'package:freshwavelaundry/Screens/LoginPageScreen.dart';
import 'package:freshwavelaundry/Screens/MembershipScreen.dart';
import 'package:freshwavelaundry/Screens/SettingsScreen.dart';
import 'package:freshwavelaundry/Screens/address_screen.dart';
import 'package:freshwavelaundry/Screens/feedback.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({Key? key}) : super(key: key);

  @override
  State<Profile_screen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Profile_screen> {
  List<user_model> user = [];
  File? _image;
  bool userNotFound = false;

  @override
  void initState() {
    super.initState();
    loadImage();
    fetchusers();
  }

  void navigateToFeedback() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => feedback()),
    );
  }

  void navigateToMembership() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MembershipScreen()));
  }

  void navigateToCoupons() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CouponScreen()));
  }

  void navigateToAddresses() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => address_screen(
                  canselect: false,
                )));
  }

  void navigateToFrequentlyQuestions() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FaqsScreen()));
  }

  void navigateToSettings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  void navigateToLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPageScreen()));
  }

  void logout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout",
          style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          content: Text("Are you sure you want to log out?",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text("Cancel",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Logout",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                  ),
                  onPressed: () async {
                    final sharedPref = await SharedPreferences.getInstance();
                    await sharedPref.clear();
                    navigateToLoginScreen();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> profile = [];

  @override
  Widget build(BuildContext context) {
    profile = [
      {
        'name': 'Membership',
        'icon': Icons.card_membership,
        'ontab': navigateToMembership,
      },
      {
        'name': 'My Coupons',
        'icon': Icons.card_giftcard,
        'ontab': navigateToCoupons,
      },
      {
        'name': 'My Addresses',
        'icon': Icons.location_on,
        'ontab': navigateToAddresses,
      },
      {
        'name': 'Feedback',
        'icon': Icons.feedback,
        'ontab': navigateToFeedback,
      },
      {
        'name': 'FAQs',
        'icon': Icons.question_answer,
        'ontab': navigateToFrequentlyQuestions,
      },
      {
        'name': 'Settings',
        'icon': Icons.settings,
        'ontab': navigateToSettings,
      },
      {
        'name': 'Logout',
        'icon': Icons.logout,
        'ontab': logout,
      },
    ];

    return Scaffold(
      body: user.isEmpty
          ? userNotFound
              ? Center(
                  child: ElevatedButton(
                    onPressed: navigateToLoginScreen,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Background color
                      backgroundColor: Colors.blue, // Text color
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                    ),
                    child: Text(
                      'Go to Login Page',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UserDetailCard(
                  name: user.isNotEmpty ? user[0].name : '',
                  phoneNumber: user.isNotEmpty ? user[0].phone_number : '',
                  email: user.isNotEmpty ? user[0].email : '',
                  image: _image,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: profile.length,
                    itemBuilder: (context, index) {
                      return Profile_card(
                        name: profile[index]['name'],
                        iconname: profile[index]['icon'],
                        ontab: profile[index]['ontab'],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> fetchusers() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? username = sharedPref.getString('username');
    String? phoneNumber = sharedPref.getString('phonenumber');
    String? email = sharedPref.getString('email');
    if (username != null && phoneNumber != null && email != null) {
      setState(() {
        user = [
          user_model(
            name: username,
            email: email,
            password: '',
            phone_number: phoneNumber,
            address: '',
          )
        ];
      });
    } else {
      try {
        final response = await user_api.fetchuser();
        if (mounted) {
          sharedPref.setString('username', response[0].name);
          sharedPref.setString('phonenumber', response[0].phone_number);
          sharedPref.setString('email', response[0].email);
          setState(() {
            user = response;
          });
        }
      } catch (error) {
        print('An error occurred while fetching users: $error');
        if (mounted) {
          setState(() {
            userNotFound = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User not found. Please log in.',
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }
}
