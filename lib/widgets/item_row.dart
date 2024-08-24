import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/card_animation_widget.dart';
import 'package:generador_formato/widgets/controller_calendar_widget.dart';
import 'package:intl/intl.dart';

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

  static Widget tarifaItemRow(
    BuildContext context, {
    Color? colorIndicator,
    required String nameRack,
    void Function()? onEdit,
    void Function()? onDelete,
  }) {
    return ListTile(
      leading: Checkbox(
        value: true,
        onChanged: (value) {},
        activeColor: colorIndicator ?? Colors.amber,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
      title: TextStyles.standardText(
          text: nameRack, color: Theme.of(context).primaryColor),
      trailing: PopupMenuButton<ListTileTitleAlignment>(
        position: PopupMenuPosition.under,
        tooltip: "Opciones",
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<ListTileTitleAlignment>>[
          PopupMenuItem<ListTileTitleAlignment>(
            value: ListTileTitleAlignment.threeLine,
            onTap: () {
              if (onEdit != null) {
                onEdit.call();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.edit, color: DesktopColors.mentaOscure),
                TextStyles.standardText(
                    text: "Editar", color: Theme.of(context).primaryColor)
              ],
            ),
          ),
          PopupMenuItem<ListTileTitleAlignment>(
            value: ListTileTitleAlignment.titleHeight,
            onTap: () {
              if (onDelete != null) {
                onDelete.call();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.delete, color: DesktopColors.cerulean),
                TextStyles.standardText(
                    text: "Eliminar", color: Theme.of(context).primaryColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget userTarifaItemRow(BuildContext context,
      {required String nameUser, required String rolUser}) {
    return ListTile(
      leading: Checkbox(
        value: true,
        onChanged: (value) {},
        activeColor: Colors.green[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
      trailing: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.person_circle),
      ),
      title: TextStyles.standardText(
        text: nameUser,
        color: Theme.of(context).primaryColor,
      ),
      subtitle: TextStyles.standardText(
        text: rolUser,
        size: 11,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  static Widget getTitleDay({
    required int title,
    required String subTitle,
    required bool select,
    required int index,
    required Brightness brightness,
    bool withOutDay = false,
  }) {
    return Opacity(
      opacity: withOutDay
          ? 1
          : select
              ? 1
              : 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextStyles.TextSpecial(
            withOutDay: withOutDay,
            compact: true,
            day: title,
            subtitle: subTitle,
            sizeTitle: 34,
            sizeSubtitle: 16,
            colorTitle: brightness == Brightness.light
                ? DesktopColors.prussianBlue
                : DesktopColors.azulClaro,
            colorsubTitle: brightness == Brightness.light
                ? DesktopColors.prussianBlue
                : DesktopColors.azulClaro,
          )
              .animate(delay: 200.ms * index)
              .fadeIn(duration: 400.ms)
              .scale(duration: 500.ms),
          const SizedBox(height: 5),
          RotatedBox(
            quarterTurns: withOutDay ? 0 : 1,
            child: SizedBox(
              height: withOutDay ? 7 : null,
              width: withOutDay ? 100 : 12,
              child: const Divider(),
            ),
          ).animate(delay: 220.ms * index).fadeIn(),
          if (select)
            Padding(
              padding: EdgeInsets.only(top: withOutDay ? 0 : 3),
              child: Icon(
                withOutDay ? Icons.keyboard_arrow_down : Icons.circle,
                color: Colors.amber,
                size: withOutDay ? 35 : 7.5,
              ),
            ).animate(delay: 220.ms * index).fadeIn().scale(duration: 500.ms),
        ],
      ),
    );
  }

  static Widget filterItemRow({
    required Color colorCard,
    required DateTime initDate,
    required DateTime lastDate,
    void Function()? onRemove,
  }) {
    String periodo = '';
    Intl.defaultLocale = "es_ES";

    if (initDate.isSameDate(lastDate)) {
      periodo =
          "${lastDate.day} ${DateFormat('MMMM').format(lastDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(lastDate).substring(1, 3)}";
    } else if (initDate.month == lastDate.month &&
        initDate.year == lastDate.year) {
      periodo =
          "${initDate.day} - ${lastDate.day} ${DateFormat('MMMM').format(lastDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(lastDate).substring(1, 3)}";
    } else if (initDate.year == lastDate.year) {
      periodo =
          "${initDate.day} ${DateFormat('MMMM').format(initDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(initDate).substring(1, 3)} - ${lastDate.day} ${DateFormat('MMMM').format(lastDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(lastDate).substring(1, 3)}";
    } else {
      periodo =
          "${initDate.day}/${initDate.month}/${initDate.year.toString().substring(2)} - ${lastDate.day}/${lastDate.month}/${lastDate.year.toString().substring(2)}";
    }

    return SizedBox(
      width: 170,
      child: Card(
        color: colorCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 7),
            TextStyles.standardText(
                text: periodo,
                color: useWhiteForeground(colorCard)
                    ? Colors.white
                    : Colors.black),
            SizedBox(
              width: 35,
              height: 40,
              child: IconButton(
                onPressed: () {
                  onRemove!.call();
                },
                icon: Icon(
                  Icons.close,
                  size: 25,
                  color: useWhiteForeground(colorCard)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
