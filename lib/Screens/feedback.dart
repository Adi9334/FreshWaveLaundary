import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/feedbackcustom.dart';
import 'package:google_fonts/google_fonts.dart';

class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Feedback',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: feedbackcustom(),
        ),
      ),
    );
  }
}
