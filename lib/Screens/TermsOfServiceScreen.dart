import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsOfServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service',
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
        ),
      ),
      body: Center(
        child: Text('Terms of Service Page Content', style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),),
      ),
    );
  }
}
