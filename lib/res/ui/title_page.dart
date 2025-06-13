import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'text_styles.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({
    super.key,
    required this.title,
    this.subtitle = '',
    this.childOptional = const SizedBox(),
    this.isDialog = false,
    this.icons,
    this.sizeTitle,
    this.sizeSubtitle = 13,
    this.textOverflow,
  });
  final String title;
  final String subtitle;
  final Widget childOptional;
  final bool isDialog;
  final IconData? icons;
  final double? sizeTitle;
  final double sizeSubtitle;
  final TextOverflow? textOverflow;

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Padding(
      padding: !widget.isDialog
          ? const EdgeInsets.only()
          : const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        children: [
          if (!widget.isDialog)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.icons != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                    child: Icon(
                      widget.icons ?? CupertinoIcons.person,
                      size: 32,
                      color: brightness == Brightness.light
                          ? Colors.black87
                          : Colors.white,
                    ),
                  ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.titlePagText(
                        text: widget.title,
                        size: widget.sizeTitle,
                        color: Theme.of(context).primaryColor,
                      ),
                      if (widget.subtitle.isNotEmpty)
                        TextStyles.standardText(
                          text: widget.subtitle,
                          color: Theme.of(context).primaryColor,
                          size: widget.sizeSubtitle,
                          textOverflow: widget.textOverflow,
                        ),
                    ],
                  ),
                ),
                widget.childOptional,
              ],
            ),
          if (widget.isDialog)
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: brightness == Brightness.light
                            ? Colors.black87
                            : Colors.white,
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(9))),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      widget.icons ?? CupertinoIcons.person,
                      size: 32,
                      color: brightness == Brightness.light
                          ? Colors.black87
                          : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.titleText(
                      text: widget.title,
                      size: widget.sizeTitle ?? 18,
                      color: Theme.of(context).primaryColor,
                    ),
                    if (widget.subtitle.isNotEmpty)
                      TextStyles.standardText(
                        text: widget.subtitle,
                        color: Theme.of(context).primaryColor,
                        size: widget.sizeSubtitle,
                      )
                  ],
                ),
              ],
            ),
          if (!widget.isDialog) Divider(color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
