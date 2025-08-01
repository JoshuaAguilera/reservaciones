import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    TextOverflow? overflow,
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
        overflow: overflow,
        height: height,
      ),
    );
  }

  static TextStyle styleStandar({
    double? size,
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
      style: titleTextStyle(
        size: size,
        color: color,
        isBold: isBold,
        overflow: overflow,
      ),
    );
  }

  static TextStyle titleTextStyle({
    double size = 18,
    Color? color,
    bool isBold = true,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      fontFamily: isBold ? "poppins_bold" : "poppins_medium",
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: size,
      overflow: overflow,
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

class AppText {
  static const String fontRegular = "poppins_regular";
  static const String fontBold = "poppins_bold";
  static const String fontMedium = "poppins_medium";

  static Text styledText({
    required String text,
    int? maxLines,
    TextAlign? align,
    Color? color,
    TextOverflow? overflow,
    double? height,
    double size = 13,
    double? maxSize,
    FontWeight fontWeight = FontWeight.normal,
    String? fontFamily,
  }) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      style: _style(
        color: color,
        overflow: overflow,
        height: height,
        size: size,
        maxSize: maxSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }

  static TextStyle _style({
    Color? color,
    TextOverflow? overflow,
    double? height,
    double size = 13,
    double? maxSize,
    FontWeight fontWeight = FontWeight.normal,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? fontRegular,
      color: color,
      fontSize: math.max(size, math.min(24.sp, maxSize ?? (size + 2))),
      fontWeight: fontWeight,
      overflow: overflow ?? TextOverflow.ellipsis,
      height: height,
    );
  }

  //Text
  static Text simpleText({
    required String text,
    Color? color,
    TextAlign align = TextAlign.left,
    TextOverflow? overflow,
    String fontFamily = fontRegular,
  }) {
    return styledText(
      text: text,
      size: 12.5,
      maxSize: 13.5,
      color: color,
      align: align,
      overflow: overflow,
      fontFamily: fontFamily,
    );
  }

  static Text sectionTitleText({
    required String text,
    Color? color,
    TextOverflow? overflow,
    TextAlign? textAlign,
  }) {
    return styledText(
      text: text,
      size: 14,
      maxSize: 16,
      overflow: overflow,
      fontWeight: FontWeight.bold,
      fontFamily: fontMedium,
      color: color,
      align: textAlign ?? TextAlign.left,
    );
  }

  static Text cardTitleText({
    required String text,
    Color? color,
    TextOverflow? overflow,
    String fontFamily = fontBold,
  }) {
    return styledText(
      text: text,
      size: 18,
      maxSize: 22,
      overflow: overflow,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
      color: color,
    );
  }

  static Text pageTitleText({
    required String text,
    Color? color,
    TextOverflow? overflow,
    String fontFamily = fontMedium,
  }) {
    return styledText(
      text: text,
      size: 20,
      maxSize: 24,
      overflow: overflow,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static Text listTitleText({
    required String text,
    Color? color,
  }) {
    return styledText(
      text: text,
      size: 12,
      maxSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: fontMedium,
      color: color,
    );
  }

  static Text textButtonStyle({
    required String text,
    Color? color,
  }) {
    return styledText(
      text: text,
      size: 12,
      fontFamily: fontMedium,
      color: color,
    );
  }

  static Text listBodyText({
    required String text,
    Color? color,
    double size = 11,
    int? maxLines,
    FontWeight fontWeight = FontWeight.normal,
    double? height,
    TextOverflow? overflow,
    TextAlign? textAlign,
  }) {
    return styledText(
      text: text,
      size: size,
      maxSize: size + 1.5,
      color: color,
      maxLines: maxLines,
      overflow: overflow,
      align: textAlign,
    );
  }

  // Styles
  static TextStyle simpleStyle({
    double size = 11.5,
    double maxSize = 13.5,
    bool isBold = false,
    Color? color,
  }) {
    return _style(
      size: size,
      maxSize: maxSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );
  }

  static TextStyle inputStyle({
    double size = 13,
    Color? color,
    double? height,
  }) {
    return _style(
      size: size,
      maxSize: size + 1,
      color: color,
      height: height,
    );
  }

  static TextStyle selectButtonStyle({
    double size = 12.5,
    Color? color,
  }) {
    return _style(
      size: size,
      maxSize: size + 1.5,
      color: color,
      fontFamily: fontMedium,
      fontWeight: FontWeight.bold,
    );
  }
}
