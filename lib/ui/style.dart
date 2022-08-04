import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

sanSerifFont({fontSize, Color? color, TextStyle? textStyle}) {
  return GoogleFonts.getFont('Noto Sans', textStyle: TextStyle(
      inherit: true,
      fontSize: fontSize ?? 18.0,
      fontWeight: FontWeight.normal,
      color: color ?? Color(0xff000000)));
}

// sanSerifFont(fontSize: 14.0, color: Color(0xff999999))

serifFont({TextStyle? textStyle}) {
  return GoogleFonts.getFont('Gentium Book Basic', textStyle: TextStyle(
      inherit: true,
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Color(0xFF000000)));
}
