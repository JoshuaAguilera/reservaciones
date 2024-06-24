import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/helpers/web_colors.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.failure,
      messageFontSize: 15,
      titleFontSize: 20,
    ),
  ));
}
