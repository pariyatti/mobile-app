import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

serifFont({required TextStyle textStyle}) {
  return GoogleFonts.getFont('Noto Sans', textStyle: textStyle);
}

sanSerifFont({required TextStyle textStyle}) {
  return GoogleFonts.getFont('Noto Serif', textStyle: textStyle);
}
