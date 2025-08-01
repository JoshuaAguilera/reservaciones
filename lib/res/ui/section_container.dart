import 'package:flutter/material.dart';

import 'text_styles.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.children,
    this.spacing = 15.0,
    this.spacingHeader = 12.0,  
    this.headerWidget,
    this.title,
    this.subtitle,
    this.backgroundColor,
    this.isModule = false,
    this.padH = 12,
  });

  final List<Widget> children;
  final Widget? headerWidget;
  final double spacing;
  final double spacingHeader;
  final String? title;
  final bool isModule;
  final String? subtitle;
  final Color? backgroundColor;
  final double padH;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Theme.of(context).cardTheme.color,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padH,
          vertical: 10,
        ),
        child: Column(
          spacing: spacingHeader,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null || headerWidget != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isModule)
                          AppText.sectionTitleText(text: title ?? '')
                        else
                          AppText.cardTitleText(text: title ?? ''),
                        if (subtitle != null)
                          AppText.simpleText(text: subtitle ?? ''),
                      ],
                    ),
                  ),
                  if (headerWidget != null) headerWidget!,
                ],
              ),
            Column(
              spacing: spacing,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          ],
        ),
      ),
    );
  }
}
