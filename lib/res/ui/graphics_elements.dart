import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/statistic_model.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/ui/section_content.dart';
import '../../res/ui/text_styles.dart';
import '../helpers/desktop_colors.dart';

class GraphicsElements {
  static Widget containerElement(
    BuildContext context, {
    required Statistic statistic,
    double? width,
    double sizeTitle = 16,
    bool isCompact = false,
    Widget? metricsWidget,
    Widget? trailingWidget,
    double amountColorMetrics = -0.08,
    bool smallTitle = true,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth =
            width ?? ((MediaQuery.of(context).size.width - (32 + 5)) / 2);

        var brightness =
            ThemeModelInheritedNotifier.of(context).theme.brightness;

        return SingleChildScrollView(
          child: SectionContent.sectionPrimary(
            spacing: 5,
            padHor: 16,
            padVer: 12,
            radius: 18,
            width: screenWidth,
            scrollDirection: isCompact ? Axis.horizontal : Axis.vertical,
            // height: isCompact ? 80 : 120,
            horAling: CrossAxisAlignment.start,
            color: (statistic.color ?? DesktopColors.primary2).withValues(
              alpha: brightness == Brightness.dark ? 0.5 : 1,
            ),
            trailingWidget: trailingWidget,
            children: [
              if (!isCompact)
                Icon(
                  statistic.icon ?? Iconsax.info_circle_outline,
                  size: 28,
                ),
              Padding(
                padding: EdgeInsets.only(right: smallTitle ? 0 : 28.0),
                child: TextStyles.standardText(
                  text: statistic.title,
                  size: sizeTitle,
                  overflow:
                      smallTitle ? TextOverflow.ellipsis : TextOverflow.clip,
                  maxLines: smallTitle ? 1 : 2,
                ),
              ),
              Row(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: isCompact ? 0 : 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: (ColorsHelpers.darken(
                          (statistic.color ?? DesktopColors.primary2),
                          amountColorMetrics,
                        )).withValues(
                          alpha: brightness == Brightness.dark ? 0.4 : 1,
                        ),
                      ),
                      child: metricsWidget ??
                          TextStyles.titleText(
                            text: statistic.metrics,
                            size: 25,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                  if (isCompact)
                    Icon(
                      statistic.icon ?? Iconsax.info_circle_outline,
                      size: 28,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
