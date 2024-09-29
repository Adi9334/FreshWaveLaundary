import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordScreen> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password',
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(labelText: 'Current Password', labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 15,
              ),),
              obscureText: true,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password', labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 15,
              ),),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm New Password', labelStyle: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 15,
              ),),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle password reset logic
              },
              child: Text('Reset Password', style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 15,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}