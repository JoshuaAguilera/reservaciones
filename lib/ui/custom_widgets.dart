import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/helpers/web_colors.dart';
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

  static Widget sectionButton(List<bool> listModes, List<Widget> modesVisual,
      void Function(int, int)? onChanged) {
    return StatefulBuilder(
      builder: (context, snapshot) {
        return Align(
          alignment: Alignment.centerRight,
          child: ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              snapshot(
                () {
                  for (int i = 0; i < listModes.length; i++) {
                    listModes[i] = i == index;
                    onChanged!.call(i, index);
                  }
                },
              );
            },
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            selectedBorderColor: DesktopColors.cerulean,
            selectedColor: DesktopColors.ceruleanOscure,
            color: Theme.of(context).primaryColor,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: listModes,
            children: modesVisual,
          ),
        );
      },
    );
  }
}
