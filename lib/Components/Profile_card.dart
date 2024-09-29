import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile_card extends StatelessWidget {
  final String name;
  final IconData iconname;
  final VoidCallback ontab;

  Profile_card({
    Key? key,
    required this.name,
    required this.iconname,
    required this.ontab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontab,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 20.0, horizontal: 15.0), // Increased vertical padding
            alignment: Alignment.center, // Center the row vertically
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  iconname,
                  color: Colors.blue,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Divider(
            height: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
