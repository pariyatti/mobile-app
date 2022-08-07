import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

getColor(BuildContext? context) {
  return context == null ? Color(0xFF000000) : Theme.of(context).colorScheme.onSurface;
}

sanSerifFont({BuildContext? context, double? fontSize, Color? color, TextStyle? textStyle}) {
  return GoogleFonts.getFont('Inter', textStyle: TextStyle(
      inherit: true,
      fontSize: fontSize ?? 18.0,
      fontWeight: FontWeight.normal,
      color: color ?? getColor(context)));
}

serifFont({BuildContext? context, TextStyle? textStyle}) {
  return GoogleFonts.getFont('Gentium Book Basic', textStyle: TextStyle(
      inherit: true,
      fontSize: textStyle?.fontSize ?? 18.0,
      fontWeight: FontWeight.normal,
      fontStyle: textStyle?.fontStyle ?? FontStyle.normal,
      color: getColor(context))); // Color(0xFF000000)
}
