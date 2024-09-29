import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/FQACustom.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: Text(
            'Frequently Asked Questions',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: customFAQ(),
        ));
  }
}
