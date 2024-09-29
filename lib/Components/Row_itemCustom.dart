import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Row_itemCustom extends StatelessWidget {
  final name;
  final value;
  final Color;
  final TextStyle? nameStyle;
  final TextStyle? valueStyle;
  const Row_itemCustom({
    required this.name,
    required this.value,
    this.nameStyle, 
    this.valueStyle, 
    this.Color,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        name,
        style: nameStyle ?? GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
      ),
      Spacer(),
      Text(
        value, 
        style: valueStyle ?? GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ), 
      ),
    ]);
  }
}
