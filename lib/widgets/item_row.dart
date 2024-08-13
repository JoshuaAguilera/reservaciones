import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/card_animation_widget.dart';

import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';

class ItemRow {
  static Widget statusQuoteRow(NumeroCotizacion register) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: Utility.getGradientQuote(register.tipoCotizacion),
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
        ),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Utility.getIconCardDashboard(register.tipoCotizacion),
              size: 55,
              color: Utility.getColorRegisterQuote(register.tipoCotizacion!),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.standardText(
                text: register.tipoCotizacion ?? '',
                color: Colors.white,
                size: 13,
                overClip: true,
              ),
              const SizedBox(height: 15),
              TextStyles.TextTitleList(
                index: register.numCotizaciones,
                color: Colors.white,
                size: 30,
                isBold: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget dayRateRow({
    required BuildContext context,
    required int day,
    int? daysMonthAfter,
    int? initDay,
    int? lastDay,
    required int checkIn,
    required int checkOut,
    int? dayWeekLater,
    int? dayMonthLater,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {},
        child: (checkOut < checkIn)
            ? ((day - 2) >= checkIn && (day - 2 - lastDay!) <= checkOut)
                ? SizedBox(
                    width: double.infinity,
                    height: 170,
                    child: CardAnimationWidget(
                      day: day,
                      isMostMonth: (checkOut < checkIn),
                      initDay: initDay!,
                      daysMonth: lastDay,
                      weekDayLast: dayWeekLater,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor)),
                    height: 170,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 15,
                          child: TextStyles.TextSpecial(
                              day: (lastDay != null &&
                                      (day + 1) > (lastDay + (initDay! - 1)))
                                  ? (day - lastDay - 2 > dayMonthLater!)
                                      ? day - dayMonthLater - lastDay - 2
                                      : day - lastDay - 2
                                  : (day < initDay!)
                                      ? (daysMonthAfter! - initDay + 2) + day
                                      : day - 2,
                              subtitle: ""),
                        ),
                      ],
                    ),
                  )
            : (initDay != null && (day + 1) < initDay) ||
                    (lastDay != null && (day + 1) > lastDay + (initDay! - 1))
                ? Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor)),
                    width: double.infinity,
                    height: 170,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 15,
                          child: TextStyles.TextSpecial(
                            day: (lastDay != null &&
                                    (day + 1) > (lastDay + (initDay - 1)))
                                ? day - lastDay - (initDay - 2)
                                : daysMonthAfter != null
                                    ? (daysMonthAfter) - (initDay - day - 2)
                                    : day + 1,
                            subtitle: "",
                          ),
                        ),
                      ],
                    ),
                  )
                : (((day - initDay! + 2) >= checkIn) &&
                        ((day - initDay + 2) <= checkOut))
                    ? SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: CardAnimationWidget(
                          day: day,
                          isMostMonth: (checkOut < checkIn),
                          initDay: initDay,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).dividerColor)),
                        height: 170,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              left: 15,
                              child: TextStyles.TextSpecial(
                                  day: (day + 2) - initDay!, subtitle: ""),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }

  static Widget itemTarifaDia(BuildContext context,
      {required int day, required DateTime initDate, required bool isDetail}) {
    return Card(
      elevation: 5,
      color: Theme.of(context).primaryColorDark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: TextStyles.TextSpecial(
              day: day + 1,
              subtitle: "DIA",
              sizeTitle: 22,
              colorsubTitle: Theme.of(context).dividerColor),
          title: TextStyles.TextAsociative(
            "Fecha:  ",
            DateTime(initDate.year, initDate.month, initDate.day)
                .add(Duration(days: day))
                .toString()
                .substring(0, 10),
            color: Theme.of(context).primaryColor,
            size: 13.5,
          ),
          subtitle: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              TextStyles.TextAsociative(
                "Tarifa de adultos:  ",
                DateTime(initDate.year, initDate.month, initDate.day)
                    .add(Duration(days: day))
                    .toString()
                    .substring(0, 10),
                color: Theme.of(context).primaryColor,
                size: 13.5,
              ),
              TextStyles.TextAsociative(
                "Tarifa de Menores de 7 a 12:  ",
                Utility.formatterNumber(0),
                color: Theme.of(context).primaryColor,
                size: 13.5,
              ),
              TextStyles.TextAsociative(
                "Tarifa de Persona Adicional:  ",
                Utility.formatterNumber(0),
                color: Theme.of(context).primaryColor,
                size: 13.5,
              ),
            ],
          ),
          trailing: isDetail
              ? null
              : (MediaQuery.of(context).size.width > 1400)
                  ? SizedBox(
                      width: 115,
                      child: Buttons.commonButton(
                          onPressed: () {}, text: "Editar"),
                    )
                  : IconButton(
                      onPressed: () {},
                      tooltip: "Editar",
                      icon: Icon(
                        CupertinoIcons.pencil,
                        size: 30,
                        color: DesktopColors.cerulean,
                      ),
                    ),
        ),
      ),
    );
  }
}
