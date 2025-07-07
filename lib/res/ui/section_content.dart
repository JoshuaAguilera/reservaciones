import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import 'text_styles.dart';

class SectionContent {
  static Widget sectionPrimary({
    Key? titleKey,
    String title = "",
    Color? color,
    Color? colorBorder,
    double elevation = 0,
    required List<Widget> children,
    Widget? trailingWidget,
    double spacing = 0,
    double padHor = 8,
    double padVer = 16,
    CrossAxisAlignment? horAling,
    double radius = 22,
    double? width,
    double? height,
    double margin = 4,
    Axis scrollDirection = Axis.vertical,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Card(
        margin: EdgeInsets.all(margin),
        color: color,
        elevation: elevation,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: colorBorder ?? Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padHor, vertical: padVer),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: 14,
                  crossAxisAlignment: horAling ?? CrossAxisAlignment.center,
                  children: [
                    if (title.isNotEmpty)
                      Padding(
                        key: titleKey,
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextStyles.standardText(
                          text: title,
                          size: 15.5,
                          isBold: true,
                        ),
                      ),
                    SingleChildScrollView(
                      scrollDirection: scrollDirection,
                      child: Column(
                        spacing: spacing,
                        crossAxisAlignment:
                            horAling ?? CrossAxisAlignment.center,
                        children: children,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailingWidget != null)
                Positioned(
                  top: -10,
                  right: -10,
                  child: trailingWidget,
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget containerBorder(
    BuildContext context, {
    required List<Widget> children,
    String title = "",
    IconData? icon,
    double spacing = 18,
  }) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 14, 8, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              brightness == Brightness.dark ? Colors.white30 : Colors.black38,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        spacing: spacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null || title.isNotEmpty)
            Row(
              spacing: 10,
              children: [
                if (icon != null) Icon(icon),
                if (title.isNotEmpty)
                  TextStyles.standardText(
                    text: title,
                    size: 14.5,
                  ),
              ],
            ),
          Column(
            spacing: spacing,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ],
      ),
    );
  }
}
