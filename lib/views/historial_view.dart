import 'package:flutter/material.dart';
import 'package:generador_formato/widgets/text_styles.dart';

class HistorialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.titlePagText(text: "Historial"),
              const Divider(color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
