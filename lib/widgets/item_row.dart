import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/card_animation_widget.dart';

import '../utils/helpers/constants.dart';
import '../utils/helpers/web_colors.dart';
import 'dialogs.dart';
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
    required int dayCheckIn,
    required int dayCheckOut,
    int? dayWeekLater,
    int? dayMonthLater,
    required int numMonthInit,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {},
        child: (dayCheckOut < dayCheckIn)
            ? ((day - 2) >= dayCheckIn && (day - 2 - lastDay!) <= dayCheckOut)
                ? SizedBox(
                    width: double.infinity,
                    height: 170,
                    child: CardAnimationWidget(
                      key: UniqueKey(),
                      day: day,
                      isMostMonth: (dayCheckOut < dayCheckIn),
                      initDay: initDay!,
                      daysMonth: lastDay,
                      weekDayLast: dayWeekLater,
                      initMonth: numMonthInit,
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
                : (((day - initDay! + 2) >= dayCheckIn) &&
                        ((day - initDay + 2) <= dayCheckOut))
                    ? SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: CardAnimationWidget(
                          day: day,
                          isMostMonth: (dayCheckOut < dayCheckIn),
                          initDay: initDay,
                          initMonth: numMonthInit,
                          key: UniqueKey(),
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
                                  day: (day + 2) - initDay, subtitle: ""),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }

  static Widget itemTarifaDia(BuildContext context,
      {required int day, required DateTime initDate, required bool isDetail}) {
    void showDialogEditQuote() {
      showDialog(
        context: context,
        builder: (context) => Dialogs.taridaAlertDialog(
          context: context,
          title:
              "Modificar de tarifas ${initDate.add(Duration(days: day)).day} / ${monthNames[initDate.add(Duration(days: day)).month - 1]}",
          iconData: CupertinoIcons.pencil_circle,
          iconColor: DesktopColors.cerulean,
          nameButtonMain: "ACEPTAR",
          funtionMain: () {},
          nameButtonCancel: "CANCELAR",
          withButtonCancel: true,
        ),
      );
    }

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
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TextStyles.TextAsociative(
              "Fecha:  ",
              DateTime(initDate.year, initDate.month, initDate.day)
                  .add(Duration(days: day))
                  .toString()
                  .substring(0, 10),
              color: Theme.of(context).primaryColor,
              size: 13.5,
            ),
          ),
          subtitle: Wrap(
            spacing: 20,
            runSpacing: 5,
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
              if (MediaQuery.of(context).size.width > 1300)
                TextStyles.TextAsociative(
                  "Periodo:  ",
                  "Marzo - Abril",
                  color: Theme.of(context).primaryColor,
                  size: 13.5,
                ),
              if (MediaQuery.of(context).size.width > 1500)
                TextStyles.TextAsociative(
                  "Temporada:  ",
                  "Alta",
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
                          onPressed: () => showDialogEditQuote(),
                          text: "Editar"),
                    )
                  : IconButton(
                      onPressed: () => showDialogEditQuote(),
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
