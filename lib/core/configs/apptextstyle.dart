import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  /// Text style for heading 1 text
  static final TextStyle h1 =
      GoogleFonts.workSans(fontSize: 28, fontWeight: FontWeight.w700);

  /// Text style for heading 2 text
  static final TextStyle h2 =
      GoogleFonts.workSans(fontSize: 17, fontWeight: FontWeight.w600);

  /// Text style for heading 3 text
  static final TextStyle h3 =
      GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600);

  /// Text style for heading 4 text
  static final TextStyle h4 =
      GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600);

  /// Text style for large body text
  static final TextStyle bodylg =
      GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w700);

  //Text style for body text
  static final TextStyle body =
      GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.w600);

  //Text style for small body//subtitle 1
  static final TextStyle bodysm =
      GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400);

//Text style for extrasmall body//subtitle 2
  static final TextStyle bodyesm = GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: -0.41);
}
