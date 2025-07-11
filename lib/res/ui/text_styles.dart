import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TextStyles {
  static Text standardText({
    required String text,
    int? maxLines,
    TextAlign align = TextAlign.left,
    bool overClip = false,
    double size = 12,
    bool isBold = false,
    Color? color,
    TextOverflow? textOverflow,
    double? height,
  }) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      style: styleStandar(
        size: size,
        isBold: isBold,
        overClip: overClip,
        color: color,
        overflow: textOverflow,
        height: height,
      ),
    );
  }

  static TextStyle styleStandar({
    double size = 12,
    bool isBold = false,
    bool overClip = false,
    Color? color,
    TextOverflow? overflow,
    double? height,
  }) {
    return TextStyle(
      fontFamily: "poppins_regular",
      color: color,
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      overflow:
          overClip ? TextOverflow.clip : overflow ?? TextOverflow.ellipsis,
      height: height,
    );
  }

  static Text buttonText(
      {String text = "",
      TextAlign aling = TextAlign.left,
      double size = 14,
      Color? color}) {
    return Text(
      text,
      textAlign: aling,
      style: TextStyle(
        color: color ?? DesktopColors.turqueza,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: "poppins_regular",
      ),
    );
  }

  static Text buttonTextStyle({
    String text = "",
    TextAlign aling = TextAlign.left,
    double size = 14,
    Color color = Colors.white,
  }) {
    return Text(
      text,
      textAlign: aling,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: "poppins_bold",
      ),
    );
  }

  static Text errorText({
    String text = "",
    TextAlign aling = TextAlign.left,
    double size = 10,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      textAlign: aling,
      style: TextStyle(
        fontFamily: "poppins_regular",
        color: Colors.red[800],
        fontSize: size,
        overflow: overflow,
      ),
    );
  }

  static Text titleText({
    String text = "",
    Color? color,
    double size = 18,
    TextAlign textAlign = TextAlign.start,
    bool isBold = true,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: isBold ? "poppins_bold" : "poppins_medium",
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: size,
        overflow: overflow,
      ),
    );
  }

  static Column TextSpecial({
    required int day,
    String? title,
    String subtitle = "Num",
    Color? colorTitle,
    Color? colorsubTitle,
    double sizeTitle = 22,
    double sizeSubtitle = 13,
    bool compact = false,
    bool withOutDay = false,
  }) {
    NumberFormat formatter = NumberFormat('00');
    String numeroFormateado = formatter.format(day);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!withOutDay)
            SizedBox(
              height: compact ? 40 : null,
              child: titleText(
                  text: title ?? numeroFormateado,
                  size: sizeTitle,
                  color: colorTitle,
                  textAlign: TextAlign.center),
            ),
          if (subtitle != "NUM" && subtitle.isNotEmpty)
            standardText(
                text: subtitle, color: colorsubTitle, size: sizeSubtitle),
        ]);
  }

  static Text TextTitleList({
    required int index,
    Color? color,
    double size = 22,
    bool isBold = true,
  }) {
    NumberFormat formatter = NumberFormat('00');
    String numeroFormateado = formatter.format(index);

    return titleText(
      text: numeroFormateado,
      size: size,
      textAlign: TextAlign.center,
      color: color,
      isBold: isBold,
    );
  }

  static Text titlePagText(
      {required String text,
      double? size,
      TextOverflow overflow = TextOverflow.ellipsis,
      Color? color}) {
    return Text(
      text,
      textAlign: TextAlign.start,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "poppins_medium",
        fontWeight: FontWeight.bold,
        fontSize: size ?? 22,
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
    PdfColor? color,
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
      color: color ??
          (isWhite ? PdfColor.fromHex("#FFFFFF") : PdfColor.fromHex("#000000")),
      decoration:
          withUnderline ? pw.TextDecoration.underline : pw.TextDecoration.none,
    );
  }

  static RichText TextAsociative(
    String title,
    String content, {
    bool isInverted = false,
    double size = 12,
    Color? color,
    bool boldInversed = false,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign? textAling,
  }) {
    return RichText(
      overflow: overflow,
      textAlign: textAling ?? TextAlign.start,
      text: TextSpan(children: [
        if (!isInverted)
          TextSpan(
              text: title,
              style: styleStandar(
                  isBold: !boldInversed,
                  size: size,
                  color: color,
                  overflow: overflow)),
        TextSpan(
            text: content,
            style: styleStandar(
                size: size,
                color: color,
                isBold: boldInversed,
                overflow: overflow)),
        if (isInverted)
          TextSpan(
              text: title,
              style: styleStandar(
                  isBold: !boldInversed,
                  size: size,
                  color: color,
                  overflow: overflow)),
      ]),
    );
  }

  static Future<pw.RichText> pwTextAsotiation({
    String title = "",
    String content = "",
    bool isInverted = false,
    double size = 12,
  }) async {
    return pw.RichText(
        text: pw.TextSpan(children: [
      if (!isInverted)
        pw.TextSpan(
            text: title, style: await pwStylePDF(isBold: true, size: size)),
      pw.TextSpan(text: content, style: await pwStylePDF(size: size)),
      if (isInverted)
        pw.TextSpan(
            text: title, style: await pwStylePDF(isBold: true, size: size)),
    ]));
  }

  static Text mediumText({
    String text = "",
    TextAlign aling = TextAlign.left,
    double size = 14,
    Color? color,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      textAlign: aling,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: "poppins_medium",
      ),
    );
  }
}
