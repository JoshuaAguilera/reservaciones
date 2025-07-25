import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../helpers/animation_helpers.dart';
import 'text_styles.dart';

class MessageErrorScroll extends StatelessWidget {
  const MessageErrorScroll({
    this.icon,
    this.title = 'Algo ha salido mal',
    this.message =
        'Verifica tu conexión a internet y asegúrate de tener información sincronizada.\n'
            'Por favor vuelve a intentar más tarde.',
    this.delay,
    super.key,
  });

  final String? title;
  final String? message;
  final IconData? icon;
  final Duration? delay;

  static Widget messageNotFound({String? messageNotFound, IconData? icon}) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: icon != null ? 10 : 5),
        child: Column(
          spacing: 8,
          children: [
            if (icon != null) Icon(icon, size: 20, color: Colors.grey),
            AppText.simpleText(
              text: messageNotFound ?? "No se encontraron mas resultados.",
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    return AnimatedEntry(
      delay: delay,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            spacing: 16,
            children: [
              Icon(icon ?? Iconsax.danger_outline, size: 48),
              AppText.sectionTitleText(
                text: title ?? '',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
              AppText.simpleText(
                text: message ?? '',
                align: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
