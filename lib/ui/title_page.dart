import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/text_styles.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({
    super.key,
    required this.title,
    required this.subtitle,
    this.childOptional = const SizedBox(),
    this.isDialog = false,
    this.icons,
    this.sizeTitle,
  });
  final String title;
  final String subtitle;
  final Widget childOptional;
  final bool isDialog;
  final IconData? icons;
  final double? sizeTitle;

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Column(
      children: [
        if (!widget.isDialog)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    color: Theme.of(context).primaryColor,
                  ),
                  TextStyles.standardText(text: widget.subtitle)
                ],
              ),
            ],
          ),
        if (!widget.isDialog) Divider(color: Theme.of(context).primaryColor),
      ],
    );
  }
}
