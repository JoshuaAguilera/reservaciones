import 'package:flutter/material.dart';

import '../helpers/web_colors.dart';
import '../widgets/text_styles.dart';

Widget ProgressIndicatorCustom(double screenHight) {
  return Center(
    child: Padding(
      padding: EdgeInsets.only(top: screenHight * 0.37),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: WebColors.prussianBlue,
          ),
          TextStyles.standardText(
            text: "Espere",
            size: 15,
          ),
        ],
      ),
    ),
  );
}
