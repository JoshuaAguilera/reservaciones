import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      double size = 13,
      bool isBold = false}) {
    return Text(
      text,
      textAlign: aling,
      style: TextStyle(
          fontFamily: "poppins_regular",
          color: WebColors.prussianBlue,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          overflow: overClip ? TextOverflow.clip : TextOverflow.ellipsis),
    );
  }

  static Text buttonText({String text = "", TextAlign aling = TextAlign.left}) {
    return Text(
      text,
      textAlign: aling,
      style: TextStyle(
        color: WebColors.turqueza,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: "poppins_regular",
      ),
    );
  }

  static Text errorText(
      {String text = "", TextAlign aling = TextAlign.left, double size = 10}) {
    return Text(
      text,
      textAlign: aling,
      style: TextStyle(
        fontFamily: "poppins_regular",
        color: Colors.red[800],
        fontSize: size,
      ),
    );
  }

  static Text titleText(
      {String text = "",
      Color? color,
      double size = 18,
      TextAlign textAlign = TextAlign.start}) {
    return Text(text,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: "poppins_bold",
          color: color ?? WebColors.cerulean,
          fontWeight: FontWeight.bold,
          fontSize: size,
        ));
  }

  static Column TextSpecial({
    required int day,
    String? title,
    String subtitle = "Num",
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
      style: TextStyle(
        fontFamily: "poppins_bold",
        color: WebColors.prussianBlue,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }

  static Future<pw.TextStyle> pwStylePDF({
    double size = 6.3,
    bool isWhite = false,
    bool isBold = false,
    bool withUnderline = false,
    bool isItalic = false,
    double? letterSpacing,
    double lineSpacing = 2,
    bool isRegular = false,
  }) async {
    return pw.TextStyle(
      fontSize: size,
      letterSpacing: letterSpacing,
      lineSpacing: lineSpacing,
      fontWeight: isRegular
          ? null
          : isBold
              ? pw.FontWeight.bold
              : pw.FontWeight.normal,
      font: pw.Font.ttf(
          await rootBundle.load("assets/fonts/calibri-regular.ttf")),
      fontBold:
          pw.Font.ttf(await rootBundle.load("assets/fonts/calibri-bold.ttf")),
      fontBoldItalic: pw.Font.ttf(
          await rootBundle.load("assets/fonts/calibri-bold-italic.ttf")),
      fontItalic:
          pw.Font.ttf(await rootBundle.load("assets/fonts/calibri-italic.ttf")),
      fontNormal:
          pw.Font.ttf(await rootBundle.load("assets/fonts/calibri-light.ttf")),
      fontStyle: isRegular
          ? null
          : isItalic
              ? pw.FontStyle.italic
              : pw.FontStyle.normal,
      color:
          isWhite ? PdfColor.fromHex("#FFFFFF") : PdfColor.fromHex("#000000"),
      decoration:
          withUnderline ? pw.TextDecoration.underline : pw.TextDecoration.none,
    );
  }
}
