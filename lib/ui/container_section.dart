import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/helpers/desktop_colors.dart';
import '../utils/shared_preferences/settings.dart';
import 'title_page.dart';

class ContainerSection extends StatelessWidget {
  const ContainerSection({
    Key? key,
    required this.title,
    required this.icons,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String title;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: DesktopColors.greyClean),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.only(left: 7, top: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: TitlePage(
                title: title,
                icons: icons,
                sizeTitle: 20,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                spacing: 13.5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(
          duration: Settings.applyAnimations ? null : 0.ms,
        );
  }
}
