import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/widgets/day_info_item_row.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../database/database.dart';
import '../ui/progress_indicator.dart';
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
    bool compact = false,
    double target = 1,
    bool isUpDireccion = false,
    bool showMonth = false,
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
          ((element.compareTo(nowPeriod.fechaInicial!) >= 0 &&
                  element.compareTo(nowPeriod.fechaFinal!) <= 0) ||
              element.compareTo(nowPeriod.fechaFinal!) == 0 ||
              element.compareTo(nowPeriod.fechaInicial!) == 0)) {
        isRepeat = true;
        cards.add(SizedBox(
          width: Utility.getExpandedDayWeek(sectionDay, nowPeriod, element),
          height: !compact ? 100 : 30,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Utility.getRevisedActually(nowPeriod)
                  ? Colors.grey
                  : Colors.white,
              BlendMode.modulate,
            ),
            child: DayInfoItemRow(
              tarifa: tarifa,
              weekNow: weekNow,
              child: Card(
                elevation: 8,
                color: tarifa.color ?? Colors.cyan,
                child: Padding(
                  padding: compact
                      ? const EdgeInsets.fromLTRB(8, 2, 8, 0)
                      : const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextStyles.standardText(
                                  text: Utility.definePeriodNow(
                                      weekNow, tarifa.periodos),
                                  size: 11,
                                  color: useWhiteForeground(tarifa.color!)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              /*
                            Icon(
                              Icons.assignment_late_outlined,
                              color: useWhiteForeground(tarifa.color!)
                                  ? Colors.white
                                  : Colors.black,
                            )
                            */
                              if (compact)
                                Expanded(
                                  child: TextStyles.standardText(
                                    text: tarifa.nombre ?? '',
                                    isBold: true,
                                    color: useWhiteForeground(tarifa.color!)
                                        ? Colors.white
                                        : Colors.black,
                                    aling: TextAlign.right,
                                  ),
                                ),
                            ],
                          ),
                          if (!compact)
                            TextStyles.standardText(
                                text: tarifa.nombre ?? '',
                                color: useWhiteForeground(tarifa.color!)
                                    ? Colors.white
                                    : Colors.black),
                        ],
                      ),
                      if (!compact)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextStyles.standardText(
                                          text: Utility.defineStatusPeriod(
                                              nowPeriod),
                                          isBold: true,
                                          color:
                                              useWhiteForeground(tarifa.color!)
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                    const SizedBox(width: 5),
                                    Utility.getIconStatusPeriod(
                                        nowPeriod, tarifa.color!),
                                  ],
                                ),
                              ),
                              TextStyles.standardText(
                                text:
                                    "${Utility.calculatePercentagePeriod(nowPeriod).toStringAsFixed(2)}%",
                                color: useWhiteForeground(tarifa.color!)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
            .animate(
                target: target,
                delay: !compact
                    ? 450.ms
                    : showMonth
                        ? 350.ms
                        : 2000.ms)
            .scaleX(alignment: Alignment.centerLeft));
      } else {
        isRepeat = false;
        cards.add(SizedBox(width: sectionDay));
      }
    }

    return cards;
  }

  static Widget loadingWidget(
      double screenWidth, double screenHeight, bool extended,
      {bool isEstandar = false, double sizeIndicator = 50, Widget? message}) {
    return isEstandar
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressIndicatorEstandar(sizeProgressIndicator: sizeIndicator),
              const SizedBox(height: 10),
              if (message != null) message
            ],
          )
        : SizedBox(
            width: (screenWidth > 1280)
                ? (screenWidth - 385 - (extended ? 230 : 118))
                : (screenWidth > 800)
                    ? screenWidth - (extended ? 230 : 118)
                    : screenWidth - 28,
            child: Center(
              child: ProgressIndicatorCustom(
                screenHight: screenHeight - 250,
                sizeProgressIndicator: 50,
              ),
            ),
          );
  }
}
