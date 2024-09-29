import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String email;
  final File? image;

  const UserDetailCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(
              'assets/images/background.jpg'), // Background image path
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.7),
            BlendMode.darken,
          ), // Adjust opacity here
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey.withOpacity(1),
                  Colors.blueGrey.withOpacity(0.3),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(image!),
                      radius: 40,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                      radius: 40,
                    ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display name with ellipses if it overflows
                    _buildEllipsizedText(name,
                        fontSize: 22, fontWeight: FontWeight.bold),
                    SizedBox(height: 4),
                    // Display phone number with ellipses if it overflows
                    _buildEllipsizedText(phoneNumber, fontSize: 18),
                    SizedBox(height: 8),
                    // Display email with ellipses if it overflows
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _buildEllipsizedText(email, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsizedText(String text,
      {required double fontSize, FontWeight? fontWeight}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: double.infinity), // Constrain to available width
      child: Text(
        text,
        style: GoogleFonts.nunito(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: Colors.white,
                ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1, // Ensure text does not wrap to a new line
      ),
    );
  }
}
