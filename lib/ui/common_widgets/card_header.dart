
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CardHeader extends Padding {
  CardHeader(text) : super(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Text(text.toUpperCase(), style: GoogleFonts.getFont('Inter', textStyle: TextStyle(
                  inherit: true,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff999999)))
          ));

}