import 'package:flutter/material.dart';
import 'package:generador_formato/res/ui/text_styles.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/section_container.dart';

class HelpResourceView extends StatefulWidget {
  const HelpResourceView({Key? key}) : super(key: key);

  @override
  State<HelpResourceView> createState() => _HelpResourceViewState();
}

class _HelpResourceViewState extends State<HelpResourceView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedEntry(
      child: SectionContainer(
        padH: 18,
        title: "Ayuda y Manuales",
        isModule: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        children: [
          InkWell(
            onTap: () async {
              await launchUrl(Uri.parse(
                  "https://b482f644-300c-45f8-9a8f-7e78d5eef32f.usrfiles.com/ugd/b482f6_210b9c7eac4f4f9a98b55d2a7fe60c2a.pdf"));
            },
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: DesktopColors.greyClean),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: ListTile(
                  leading: Icon(FontAwesome.file_pdf_solid, size: 40),
                  title: TextStyles.standardText(
                      text: "Guía de Usuario", isBold: true, size: 14),
                  subtitle: TextStyles.standardText(
                    text:
                        "Manual para el correcto uso del sistema\nVersión: 1.0.12",
                    size: 11.5,
                    overClip: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
