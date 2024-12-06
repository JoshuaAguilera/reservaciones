import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/text_styles.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required String type,
  IconData? iconCustom,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      width: 500,
      padding: const EdgeInsets.only(bottom: 50),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Card(
        elevation: 4,
        color: Utility.getColorNavbar(type),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Column(
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
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  iconCustom ?? Utility.getIconNavbar(type),
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ).animate(
        effects: [
          if (type == "alert" || type == "danger")
            const ShakeEffect(offset: Offset(5, 0), rotation: 0),
          if (type == "info") const FlipEffect(),
          if (type == "success") ShimmerEffect(delay: 150.ms),
        ],
      ),
      duration: duration ?? 3000.ms,
    ),
  );
}
