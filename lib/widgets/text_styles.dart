import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../helpers/doc_templates.dart';

class TextStyles {
  static Text standardText(
      {String text = "",
      TextAlign aling = TextAlign.left,
      bool overClip = false,
      bool isBold = false}) {
    return Text(
      text,
      textAlign: aling,
      style: GoogleFonts.poppins(
          color: WebColors.prussianBlue,
          fontSize: 13,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          textStyle: TextStyle(
              overflow: overClip ? TextOverflow.clip : TextOverflow.ellipsis)),
    );
  }

  static Text buttonText({String text = "", TextAlign aling = TextAlign.left}) {
    return Text(
      text,
      textAlign: aling,
      style: GoogleFonts.poppins(
          color: WebColors.turqueza, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  static Text errorText({String text = "", TextAlign aling = TextAlign.left}) {
    return Text(
      text,
      textAlign: aling,
      style: GoogleFonts.poppins(color: Colors.red[800], fontSize: 10),
    );
  }

  static Text titleText(
      {String text = "",
      Color? color,
      double size = 18,
      TextAlign textAlign = TextAlign.start}) {
    return Text(text,
        textAlign: textAlign,
        style: GoogleFonts.poppins(
          color: color ?? WebColors.cerulean,
          fontWeight: FontWeight.bold,
          fontSize: size,
        ));
  }

  static Column TextSpecial({
    required int day,
    String? title,
    String subtitle = "Día",
  }) {
    NumberFormat formatter = NumberFormat('00');
    String numeroFormateado = formatter.format(day);

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      titleText(
          text: title ?? numeroFormateado,
          size: 22,
          textAlign: TextAlign.center),
      standardText(text: subtitle),
    ]);
  }

  static Text titlePagText({required String text}) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
          color: WebColors.prussianBlue,
          fontWeight: FontWeight.bold,
          fontSize: 22),
    );
  }

  static Future<pw.TextStyle> pwStylePDF(
      {double size = 6.3,
      bool isWhite = false,
      bool isBold = false,
      bool withUnderline = false}) async {
    return pw.TextStyle(
      font: isBold
          ? await DocTemplates.fontBoldGoogle()
          : await DocTemplates.fontLightGoogle(),
      fontSize: size,
      color:
          isWhite ? PdfColor.fromHex("#FFFFFF") : PdfColor.fromHex("#000000"),
      decoration:
          withUnderline ? pw.TextDecoration.underline : pw.TextDecoration.none,
    );
  }
}
