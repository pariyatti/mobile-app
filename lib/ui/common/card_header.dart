
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardHeader extends Container {
  CardHeader(context, text, color) : super(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      color: color,
      width: double.infinity,
      child: Text(text.toUpperCase(), style: GoogleFonts.getFont('Inter', textStyle: TextStyle(
        inherit: true,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onBackground,
      )))
  );
}
