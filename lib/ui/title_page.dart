import 'package:flutter/material.dart';

import '../widgets/text_styles.dart';

class TitlePage extends StatefulWidget {
  const TitlePage(
      {super.key,
      required this.title,
      required this.subtitle,
      this.childOptional = const SizedBox()});
  final String title;
  final String subtitle;
  final Widget childOptional;

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    color: Theme.of(context).primaryColor,
                  ),
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
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
