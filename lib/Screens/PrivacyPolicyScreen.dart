import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',
        style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
            ),
        ),
      ),
      body: Center(
        child: Text('Privacy Policy Page Content',
        style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 15,
            ),
        ),
      ),
    );
  }
}