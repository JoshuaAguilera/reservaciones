import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/helpers/utility.dart';
import '../widgets/text_styles.dart';

Widget insideSnackBar({
  required String message,
  required String type,
  Duration? duration,
  bool showAnimation = false,
}) {
  return Center(
    child: Card(
      color: Utility.getColorNavbar(type),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextStyles.standardText(
          text: message,
          size: 10,
          color: Colors.white,
          aling: TextAlign.center,
        ),
      ),
    ).animate().flip(delay: 100.ms).fadeOut(delay: duration ?? 800.ms),
  );
}
