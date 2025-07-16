import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'text_styles.dart';
import '../helpers/colors_helpers.dart';
import '../helpers/desktop_colors.dart';

class ToolsUi {
  static Widget blockedWidget({
    required bool isBloqued,
    bool unlook = false,
    required Widget child,
  }) {
    return AbsorbPointer(
      absorbing: unlook ? false : isBloqued,
      child: Opacity(
        opacity: !unlook
            ? isBloqued
                ? 0.6
                : 1
            : 1,
        child: child,
      ),
    );
  }

  static Widget contentModalStandar(
    BuildContext context, {
    double spacing = 15,
    required String title,
    required List<Widget> children,
    ScrollController? controller,
    bool isExcluced = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, isExcluced ? 15 : 67),
      child: Container(
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            spacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStyles.titleText(
                    text: title,
                    size: 16,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment,
                spacing: spacing,
                children: children,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget contentScreenStandar({
    double spacing = 15,
    bool isExcluced = false,
    required List<Widget> children,
    ScrollController? controller,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isExcluced ? 0 : 67),
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, isExcluced ? 8 : 0),
            child: Column(
              spacing: spacing,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  static Widget itemMedal(
    String name, {
    Color? colorApply,
    bool enable = true,
    IconData? icon,
    int alpha = 100,
    double padVer = 9,
    double padHor = 9,
    double iconSize = 20,
    double textSize = 15,
    bool newVersion = true,
    double borderRadius = 10,
    void Function()? onTap,
  }) {
    return StatefulBuilder(
      builder: (context, snapshot) {
        var brightness =
            ThemeModelInheritedNotifier.of(context).theme.brightness;

        Color colorDiseable = brightness == Brightness.light
            ? DesktopColors.greyClean
            : DesktopColors.grisPalido;

        Color colorStrong = !enable
            ? colorDiseable
            : colorApply ??
                ColorsHelpers.getColorTypeConcept(name) ??
                colorDiseable;

        Color colorItem = (colorStrong).withValues(
          alpha: brightness == Brightness.dark ? 0.5 : 1,
        );

        double bias = brightness == Brightness.dark ? 110 : 0;

        Color colorApplyStrong = useWhiteForeground(colorItem, bias: bias)
            ? ColorsHelpers.darken(colorStrong, -0.45)
            : useWhiteForeground(colorStrong, bias: 80)
                ? ColorsHelpers.darken(colorStrong, 0.25)
                : ColorsHelpers.darken(colorStrong, 0.7);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: padVer, horizontal: padHor),
            decoration: BoxDecoration(
              color: colorItem,
              border: newVersion
                  ? brightness == Brightness.light
                      ? null
                      : Border.all(
                          width: 1.5,
                          color: ColorsHelpers.darken(
                            colorItem,
                          ),
                        )
                  : Border.all(
                      color: colorApplyStrong,
                      width: 2,
                    ),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            child: Row(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: iconSize,
                    color: colorApplyStrong,
                  ),
                Flexible(
                  fit: FlexFit.loose,
                  child: TextStyles.standardText(
                    text: name,
                    align: TextAlign.center,
                    color: colorApplyStrong,
                    isBold: !newVersion,
                    size: textSize,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ).animate(
            onPlay: (controller) {
              if (!context.mounted) return;
              controller.repeat(period: 5.seconds);
            },
            effects: [
              if (name.trim().contains("admin"))
                ShimmerEffect(
                  delay: 2.5.seconds,
                  duration: 750.ms,
                  color: Colors.white,
                ),
            ],
          ),
        );
      },
    );
  }

  static AppBar appBarPrimary(
    BuildContext context, {
    required String title,
    String subtitle = "",
    List<Widget>? actions,
    Widget? aditionalWidget,
    bool centerTitle = true,
  }) {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          TextStyles.standardText(
            text: title,
            isBold: true,
            size: 15.5,
          ),
          if (subtitle.isNotEmpty)
            TextStyles.standardText(
              text: subtitle,
              size: 13,
            ),
          aditionalWidget ?? SizedBox()
        ],
      ),
      centerTitle: centerTitle,
      elevation: 1,
      forceMaterialTransparency: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: actions,
    );
  }

  static Widget customExpansionTile({
    required String name,
    required List<Widget> childrens,
    void Function(bool)? onExpansionChanged,
    bool isRequired = false,
    Key? key,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: ExpansionTile(
        key: key,
        iconColor: isRequired ? Colors.white : null,
        collapsedTextColor: isRequired ? Colors.red[700] : Colors.black,
        textColor: isRequired ? Colors.white : Colors.black,
        backgroundColor: isRequired ? Colors.red[800] : null,
        collapsedBackgroundColor: Colors.white,
        title: TextStyles.standardText(text: name, isBold: true),
        onExpansionChanged: onExpansionChanged,
        children: childrens,
      ),
    );
  }
}
