import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/text_styles.dart';

class CustomWidgets {
  static Widget containerCard(
      {required List<Widget> children, MainAxisAlignment? maxAlignment}) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: maxAlignment ?? MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }

  static Widget messageNotResult(
      {double sizeMessage = 11, required BuildContext context}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/image/not_results.png"),
            width: 120,
            height: 120,
          ),
          TextStyles.standardText(
            text: "No se encontraron resultados",
            size: sizeMessage,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
