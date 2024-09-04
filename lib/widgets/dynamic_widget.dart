import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';

import '../database/database.dart';
import '../utils/helpers/utility.dart';
import 'text_styles.dart';

class dynamicWidget {
  static Padding containerResizable(
      {Widget? child, double height = 0, double width = 0}) {
    double maxHeight = 0;
    double maxWidth = 0;
    switch (height) {
      case >= 1080:
        maxHeight = 200;
        break;
      case >= 720:
        maxHeight = 200;
        break;
      case >= 576:
        maxHeight = 100;
        break;
      case < 576:
        maxHeight = 75;
        break;
      default:
    }

    switch (width) {
      case >= 1920:
        maxWidth = 550;
        break;
      case >= 1280:
        maxWidth = 300;
        break;
      case >= 768:
        maxWidth = 100;
        break;
      case < 768:
        maxWidth = 50;
        break;
      default:
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: maxWidth, vertical: maxHeight),
      child: child,
    );
  }

  static List<Widget> buildExpansionItemWeek({
    required List<DateTime> weekNowSegment,
    required DateTime weekNow,
    required RegistroTarifa tarifa,
    required double sectionDay,
  }) {
    List<Widget> cards = [];
    bool isRepeat = false;
    PeriodoData nowPeriod = Utility.getPeriodNow(weekNow, tarifa.periodos);

    for (var element in weekNowSegment) {
      if (Utility.defineApplyDays(nowPeriod, element)) {
        isRepeat = false;
        cards.add(SizedBox(width: sectionDay));
      } else if (isRepeat &&
          Utility.revisedValidDays(
              weekNowSegment.indexOf(element),
              weekNowSegment,
              element,
              nowPeriod.fechaInicial!,
              nowPeriod.fechaFinal!)) {
      } else if (!isRepeat &&
          (element.compareTo(nowPeriod.fechaInicial!) >= 0 &&
              element.compareTo(nowPeriod.fechaFinal!) <= 0)) {
        isRepeat = true;
        cards.add(Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
              color: tarifa.color ?? Colors.cyan,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextStyles.standardText(
                                text: Utility.definePeriodNow(
                                    weekNow, tarifa.periodos),
                                size: 11,
                                color: useWhiteForeground(tarifa.color!)
                                    ? Colors.white
                                    : Colors.black),
                            Icon(Icons.warning_amber_rounded,
                                color: useWhiteForeground(tarifa.color!)
                                    ? Colors.white
                                    : Colors.black)
                          ],
                        ),
                        TextStyles.standardText(
                            text: tarifa.nombre ?? '',
                            color: useWhiteForeground(tarifa.color!)
                                ? Colors.white
                                : Colors.black),
                      ],
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                TextStyles.standardText(
                                    text: "En progreso",
                                    isBold: true,
                                    color: useWhiteForeground(tarifa.color!)
                                        ? Colors.white
                                        : Colors.black),
                                const SizedBox(width: 5),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    CupertinoIcons.chevron_right_2,
                                    size: 15,
                                    color: useWhiteForeground(tarifa.color!)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            TextStyles.standardText(
                              text: "${(2 / 10) * 100}%",
                              color: useWhiteForeground(tarifa.color!)
                                  ? Colors.white
                                  : Colors.black,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ).animate(delay: 450.ms).scaleX(alignment: Alignment.centerLeft),
        ));
      } else {
        isRepeat = false;
        cards.add(SizedBox(width: sectionDay));
      }
    }

    return cards;
  }
}
