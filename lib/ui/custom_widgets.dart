import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

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

  static Widget sectionButton({
    required List<bool> listModes,
    required List<Widget> modesVisual,
    void Function(int, int)? onChanged,
    List<String>? arrayStrings,
    Color? selectedColor,
    Color? selectedBorderColor,
    double borderRadius = 4,
  }) {
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
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            selectedBorderColor: selectedBorderColor ?? DesktopColors.cerulean,
            selectedColor: DesktopColors.ceruleanOscure,
            fillColor: selectedColor,
            color: Theme.of(context).primaryColor,
            constraints: const BoxConstraints(
              minHeight: 35.0,
              minWidth: 70.0,
            ),
            isSelected: listModes,
            children: modesVisual.isEmpty
                ? Utility.generateTextWidget(
                    arrayStrings!, Theme.of(context).primaryColor)
                : modesVisual,
          ),
        );
      },
    );
  }
}
