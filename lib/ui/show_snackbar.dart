import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/text_styles.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required String type,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    width: 500,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: Card(
      margin: const EdgeInsets.only(bottom: 25),
      elevation: 4,
      color: Utility.getColorNavbar(type),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.buttonTextStyle(text: title, size: 17),
                TextStyles.standardText(
                    text: message,
                    overClip: true,
                    color: Colors.white,
                    size: 12.5)
              ],
            ),
            Icon(
              Utility.getIconNavbar(type),
              size: 50,
            ),
          ],
        ),
      ),
    ),
  ));
}
