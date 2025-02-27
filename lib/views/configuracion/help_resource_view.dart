import 'package:flutter/material.dart';
import 'package:generador_formato/ui/container_section.dart';
import 'package:icons_plus/icons_plus.dart';

class HelpResourseView extends StatefulWidget {
  const HelpResourseView({Key? key}) : super(key: key);

  @override
  State<HelpResourseView> createState() => _HelpResourseViewState();
}

class _HelpResourseViewState extends State<HelpResourseView> {
  @override
  Widget build(BuildContext context) {
    return ContainerSection(
      title: "Ayuda y Manuales",
      icons: Iconsax.message_question_outline,
      children: [],
    );
  }
}
