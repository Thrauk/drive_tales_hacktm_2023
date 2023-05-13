import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DTTextStyles {
  static TextStyle h1 = GoogleFonts.montserrat(
    color: DTColors.orange,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static TextStyle regularBody({
    Color color = DTColors.orange,
    double fontSize = 14,
  }) {
    return GoogleFonts.montserrat(
      color: color,
      fontSize: fontSize,
    );
  }
}
