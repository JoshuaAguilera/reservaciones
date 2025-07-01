import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../models/periodo_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/icon_helpers.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/helpers/utility.dart';
import '../../res/ui/text_styles.dart';
import '../shared_preferences/settings.dart';
import 'day_info_item_row.dart';

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
    required TarifaRack tarifa,
    required double sectionDay,
    bool compact = false,
    double target = 1,
    bool alreadyLoading = false,
    bool isntWeek = true,
    // bool showMonth = false,
  }) {
    List<Widget> cards = [];
    bool isRepeat = false;
    Periodo nowPeriod = DateHelpers.getPeriodNow(weekNow, tarifa.periodos);

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
              rack: tarifa,
              weekNow: weekNow,
              isntWeek: isntWeek,
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
                                  text: DateHelpers.definePeriodNow(
                                    weekNow,
                                    periodos: tarifa.periodos,
                                  ),
                                  size: 11,
                                  color: useWhiteForeground(tarifa.color!)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              if (compact)
                                Expanded(
                                  child: TextStyles.standardText(
                                    text: tarifa.nombre ?? '',
                                    isBold: true,
                                    color: useWhiteForeground(tarifa.color!)
                                        ? Colors.white
                                        : Colors.black,
                                    align: TextAlign.right,
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
                                    IconHelpers.getIconStatusPeriod(
                                      nowPeriod,
                                      tarifa.color!,
                                    ),
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
              delay: !Settings.applyAnimations
                  ? null
                  : (!compact
                      ? !alreadyLoading
                          ? 1750.ms
                          : 350.ms
                      : 2000.ms),
            )
            .scaleX(
              alignment: Alignment.centerLeft,
              duration: Settings.applyAnimations ? null : 0.ms,
            ));
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
