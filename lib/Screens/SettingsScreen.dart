import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Screens/AboutScreen.dart';
import 'package:freshwavelaundry/Screens/LoginPageScreen.dart';
import 'package:freshwavelaundry/Screens/PrivacyPolicyScreen.dart';
import 'package:freshwavelaundry/Screens/ProfileUpdateScreen.dart';
import 'package:freshwavelaundry/Screens/ResetPasswordScreen.dart';
import 'package:freshwavelaundry/Screens/TermsOfServiceScreen.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:freshwavelaundry/providers/ThemeProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsScreen> {
  Future<void> _deleteUser(BuildContext context) async {
  try {
    final id = await user_api.fetchUserID();
    final userData = await user_api.fetchuser();

    final username = userData[0].name;
    final email = userData[0].email;
    final password = userData[0].password;
    final phoneNumber = userData[0].phone_number;
    final address = userData[0].address;
    final createdBy = 'user';
    final isActive = true; 

    final insertData = {
      'username': username,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'address': address,
      'created_by': createdBy,
      'is_active': isActive
    };

    // Define URLs
    final insertUrl = '${APIservice.address}/DeleteUser/adddeleteuser';
    final deleteUrl = '${APIservice.address}/User/deleteUser/$id';

    // Insert user data into DeletedUsers table
    final insertResponse = await http.post(
      Uri.parse(insertUrl),
      body: jsonEncode(insertData),
      headers: {'Content-Type': 'application/json'},
    );

    if (insertResponse.statusCode == 200) {
      // If data insertion is successful, proceed to delete the user
      final deleteResponse = await http.delete(Uri.parse(deleteUrl));

      if (deleteResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted successfully', 
          style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                ),)),
        );
        Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPageScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user', style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                ),)),
        );
      }
    } else {
      // Handle failure in inserting data into DeletedUsers table
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to archive user data', 
        style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 15,
          ),
        )),
      );
    }
  } catch (e) {
    // Handle any exceptions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e',
      style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 15,
          ),
      )),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: Text(
              'Profile',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Colors.blueAccent, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
              );
            },
          ),
          Divider(),
          // SwitchListTile(
          //   title: Text(
          //     'Notifications',
          //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          //   ),
          //   value: _notificationsEnabled,
          //   activeColor: Colors.blueAccent,
          //   onChanged: (bool value) {
          //     setState(() {
          //       _notificationsEnabled = value;
          //     });
          //   },
          // ),
          // Divider(),
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            value: context.watch<ThemeProvider>().isDarkMode,
            activeColor: Colors.blueAccent,
            onChanged: (bool value) {
              context.read<ThemeProvider>().toggleTheme(value);
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'About',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            leading: Icon(Icons.info, color: Colors.blueAccent, size: 20),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Colors.blueAccent, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            leading: Icon(Icons.lock, color: Colors.blueAccent, size: 20),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Colors.blueAccent, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Terms of Service',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            leading:
                Icon(Icons.description, color: Colors.blueAccent, size: 20),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Colors.blueAccent, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsOfServiceScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Delete Account',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            leading: Icon(Icons.delete, color: Colors.red, size: 20),
            trailing:
                Icon(Icons.arrow_forward_ios, color: Colors.red, size: 16),
            onTap: () async {
              bool? confirmDelete = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Delete",
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    ),
                    content:
                        Text("Are you sure you want to delete this account?", style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                    ),),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancel", style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                    ),),
                        onPressed: () {
                          Navigator.of(context).pop(false); // Cancel deletion
                        },
                      ),
                      TextButton(
                        child: Text("Delete", style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                    ),),
                        onPressed: () {
                          Navigator.of(context).pop(true); // Confirm deletion
                        },
                      ),
                    ],
                  );
                },
              );

              if (confirmDelete == true) {
                _deleteUser(context);
              }
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
