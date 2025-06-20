import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../res/ui/title_page.dart';
import '../../utils/shared_preferences/settings.dart';

class ClientesView extends StatelessWidget {
  const ClientesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 67),
        child: Column(
          children: [
            const TitlePage(
              title: "Registro de Clientes",
              subtitle:
                  "Asegure la información personal de sus clientes para llevar un historico de sus cotizaciones.",
              textOverflow: TextOverflow.clip,
            ).animate().fadeIn(
                  duration: Settings.applyAnimations ? 250.ms : 0.ms,
                ),
          ],
        ),
      ),
    );
  }
}
