import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

sanSerifFont({double? fontSize, Color? color, TextStyle? textStyle}) {
  return GoogleFonts.getFont('Inter', textStyle: TextStyle(
      inherit: true,
      fontSize: fontSize ?? 18.0,
      fontWeight: FontWeight.normal,
      color: color ?? Color(0xff000000)));
}

serifFont({TextStyle? textStyle}) {
  return GoogleFonts.getFont('Gentium Book Basic', textStyle: TextStyle(
      inherit: true,
      fontSize: textStyle?.fontSize ?? 18.0,
      fontWeight: FontWeight.normal,
      fontStyle: textStyle?.fontStyle ?? FontStyle.normal,
      color: Color(0xFF000000)));
}
