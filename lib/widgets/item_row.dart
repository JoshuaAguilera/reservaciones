import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
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
    required bool inPeriod,
    required DateTime dateNow,
    List<RegistroTarifa>? tarifas,
    int totalDays = 0,
    bool isLastDay = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {},
        child: inPeriod
            ? SizedBox(
                width: double.infinity,
                height: 170,
                child: CardAnimationWidget(
                  key: UniqueKey(),
                  day: day,
                  dateNow: dateNow,
                  registros: tarifas!,
                  totalDays: totalDays,
                  isLastDay: isLastDay,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                height: 170,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 15,
                      child: TextStyles.TextSpecial(day: day, subtitle: ""),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  static TableRow tableRowTarifaDay(
    BuildContext context, {
    required DateTime checkIn,
    required int ink,
    required DateTime checkOut,
    required List<RegistroTarifa> tarifas,
    required Habitacion habitacion,
    required double screenWidth,
  }) {
    RegistroTarifa? tarifa =
        Utility.revisedTariffDay(checkIn.add(Duration(days: ink)), tarifas);

    double tarifaAdulto = Utility.calculateTariffAdult(
      tarifa,
      habitacion,
      checkOut.difference(checkIn).inDays,
    );

    double tarifaMenores = Utility.calculateTariffChildren(
      tarifa,
      habitacion,
      checkOut.difference(checkIn).inDays,
    );

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0),
          child: Center(
            child: TextStyles.standardText(
                text: checkIn
                    .add(Duration(days: ink))
                    .toIso8601String()
                    .substring(0, 10),
                color: Theme.of(context).primaryColor,
                size: 14),
          ),
        ),
        Center(
          child: TextStyles.standardText(
              text: Utility.formatterNumber(
                (checkOut.difference(checkIn).inDays == ink) ? 0 : tarifaAdulto,
              ),
              color: Theme.of(context).primaryColor,
              size: 14),
        ),
        Center(
          child: TextStyles.standardText(
              text: Utility.formatterNumber(
                  (checkOut.difference(checkIn).inDays == ink)
                      ? 0
                      : tarifaMenores),
              color: Theme.of(context).primaryColor,
              size: 14),
        ),
        Center(
          child: TextStyles.standardText(
              text: Utility.formatterNumber(0),
              color: Theme.of(context).primaryColor,
              size: 14),
        ),
        Center(
          child: TextStyles.standardText(
              text: Utility.formatterNumber(
                (checkOut.difference(checkIn).inDays == ink)
                    ? 0
                    : (tarifaAdulto + tarifaMenores),
              ),
              color: Theme.of(context).primaryColor,
              size: 14),
        ),
        (checkOut.difference(checkIn).inDays == ink)
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (screenWidth > 1400)
                    Buttons.commonButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialogs.taridaAlertDialog(
                            context: context,
                            title:
                                "Modificar de tarifas ${checkIn.add(Duration(days: ink)).day} / ${monthNames[checkIn.add(Duration(days: ink)).month - 1]}",
                            iconData: CupertinoIcons.pencil_circle,
                            iconColor: DesktopColors.cerulean,
                            nameButtonMain: "ACEPTAR",
                            funtionMain: () {},
                            nameButtonCancel: "CANCELAR",
                            withButtonCancel: true,
                          ),
                        );
                      },
                      text: "Editar",
                      color: tarifa?.color,
                      colorText: tarifa == null
                          ? Colors.white
                          : useWhiteForeground(tarifa.color!)
                              ? Colors.white
                              : const Color.fromARGB(255, 43, 43, 43),
                    )
                  else
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialogs.taridaAlertDialog(
                            context: context,
                            title:
                                "Modificar de tarifas ${checkIn.add(Duration(days: ink)).day} / ${monthNames[checkIn.add(Duration(days: ink)).month - 1]}",
                            iconData: CupertinoIcons.pencil_circle,
                            iconColor: DesktopColors.cerulean,
                            nameButtonMain: "ACEPTAR",
                            funtionMain: () {},
                            nameButtonCancel: "CANCELAR",
                            withButtonCancel: true,
                          ),
                        );
                      },
                      tooltip: "Editar",
                      icon: Icon(
                        CupertinoIcons.pencil,
                        size: 30,
                        color: tarifa?.color,
                      ),
                    ),
                ],
              )
      ],
    );
  }

  static Widget itemTarifaDia(
    BuildContext context, {
    required int day,
    required DateTime initDate,
    required bool isDetail,
    required double tarifaAdulto,
    required double tarifaMenores7a12,
    required double tarifaMenores0a6,
    required String temporada,
    required String periodo,
    Color? color,
  }) {
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
              colorsubTitle: Theme.of(context).dividerColor,
              colorTitle: color),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TextStyles.TextAsociative(
              "Fecha:  ",
              Utility.getCompleteDate(
                  data: DateTime(initDate.year, initDate.month, initDate.day)
                      .add(Duration(days: day))),
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
                Utility.formatterNumber(tarifaAdulto),
                color: Theme.of(context).primaryColor,
                size: 13.5,
              ),
              TextStyles.TextAsociative(
                "Tarifa de Menores de 7 a 12:  ",
                Utility.formatterNumber(tarifaMenores7a12),
                color: Theme.of(context).primaryColor,
                size: 13.5,
              ),
              TextStyles.TextAsociative(
                "Tarifa de Menores de 0 a 6:  ",
                Utility.formatterNumber(tarifaMenores0a6),
                color: Theme.of(context).primaryColor,
                size: 13.5,
              ),
              if (MediaQuery.of(context).size.width > 1300)
                TextStyles.TextAsociative(
                  "Periodo:  ",
                  periodo,
                  color: Theme.of(context).primaryColor,
                  size: 13.5,
                ),
              if (MediaQuery.of(context).size.width > 1500)
                TextStyles.TextAsociative(
                  "Temporada:  ",
                  temporada,
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
                        text: "Editar",
                        color: color,
                        colorText: useWhiteForeground(color!)
                            ? Colors.white
                            : const Color.fromARGB(255, 43, 43, 43),
                      ),
                    )
                  : IconButton(
                      onPressed: () => showDialogEditQuote(),
                      tooltip: "Editar",
                      icon: Icon(
                        CupertinoIcons.pencil,
                        size: 30,
                        color: color,
                      ),
                    ),
        ),
      ),
    );
  }

  static Widget tarifaItemRow(
    BuildContext context, {
    RegistroTarifa? registroTarifa,
    void Function(bool?)? onChangedSelect,
    void Function()? onEdit,
    void Function()? onDelete,
  }) {
    return ListTile(
      leading: Checkbox(
        value: registroTarifa!.isSelected,
        onChanged: onChangedSelect,
        activeColor: registroTarifa.color ?? Colors.amber,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
      title: TextStyles.standardText(
          text: registroTarifa.nombre ?? 'Unknow',
          color: Theme.of(context).primaryColor),
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
              showDialog(
                context: context,
                builder: (context) => Dialogs.customAlertDialog(
                  context: context,
                  title: "Eliminar tarifa",
                  content:
                      "¿Desea eliminar la siguiente tarifa: ${registroTarifa.nombre}?",
                  nameButtonMain: "Aceptar",
                  funtionMain: () async {
                    onDelete!.call();
                  },
                  nameButtonCancel: "Cancelar",
                  withButtonCancel: true,
                  iconData: Icons.delete,
                ),
              );
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

  static Widget tarifaCheckListItemRow(
      {required RegistroTarifa registro,
      required double screenWidth,
      required void Function(RegistroTarifa)? onEdit,
      required void Function(RegistroTarifa)? onDelete}) {
    return SizedBox(
      width: 170,
      child: Card(
        elevation: 5,
        color: registro.color,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextStyles.standardText(
                  text: registro.nombre ?? '',
                  isBold: true,
                  color: useWhiteForeground(registro.color!)
                      ? Colors.white
                      : Colors.black,
                ),
                TextStyles.standardText(
                  text: Utility.defineStatusTariff(registro.periodos),
                  color: useWhiteForeground(registro.color!)
                      ? Colors.white
                      : Colors.black,
                ),
              ],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: () => onEdit!.call(registro),
                  tooltip: "Editar",
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                    color: useWhiteForeground(registro.color!)
                        ? const Color.fromARGB(255, 211, 211, 211)
                        : const Color.fromARGB(255, 52, 52, 52),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => onDelete!.call(registro),
                  tooltip: "Eliminar",
                  icon: Icon(
                    CupertinoIcons.delete,
                    size: 30,
                    color: useWhiteForeground(registro.color!)
                        ? const Color.fromARGB(255, 211, 211, 211)
                        : const Color.fromARGB(255, 52, 52, 52),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.TextAsociative(
                  "Fecha de registro: ",
                  Utility.getCompleteDate(data: registro.fechaRegistro),
                  color: useWhiteForeground(registro.color!)
                      ? Colors.white
                      : Colors.black,
                  size: 13,
                  boldInversed: true,
                ),
                Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyles.standardText(
                            text: "Tarifas Vista Reserva:",
                            color: useWhiteForeground(registro.color!)
                                ? Colors.white
                                : Colors.black),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 7,
                          runSpacing: 5,
                          children: [
                            tariffIndItemRow(
                                "SGL/DBL",
                                registro.tarifas!.first.tarifaAdultoSGLoDBL!,
                                registro.color!),
                            tariffIndItemRow(
                                "TPL",
                                registro.tarifas!.first.tarifaAdultoTPL,
                                registro.color!),
                            tariffIndItemRow(
                                "CPLE",
                                registro.tarifas!.first.tarifaAdultoCPLE,
                                registro.color!),
                            tariffIndItemRow(
                                "MEN 7-12",
                                registro.tarifas!.first.tarifaMenores7a12!,
                                registro.color!),
                            tariffIndItemRow(
                                "PAX ADIC",
                                registro.tarifas!.first.tarifaPaxAdicional!,
                                registro.color!),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyles.standardText(
                            text: "Tarifas Vista Parcial al Mar:",
                            color: useWhiteForeground(registro.color!)
                                ? Colors.white
                                : Colors.black),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 7,
                          runSpacing: 5,
                          children: [
                            tariffIndItemRow(
                                "SGL/DBL",
                                registro.tarifas![1].tarifaAdultoSGLoDBL!,
                                registro.color!),
                            tariffIndItemRow(
                                "TPL",
                                registro.tarifas![1].tarifaAdultoTPL,
                                registro.color!),
                            tariffIndItemRow(
                                "CPLE",
                                registro.tarifas![1].tarifaAdultoCPLE,
                                registro.color!),
                            tariffIndItemRow(
                                "MEN 7-12",
                                registro.tarifas![1].tarifaMenores7a12!,
                                registro.color!),
                            tariffIndItemRow(
                                "PAX ADIC",
                                registro.tarifas![1].tarifaPaxAdicional!,
                                registro.color!),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget tariffIndItemRow(String tipo, double? tarifa, Color color) {
    return Container(
      width: 135,
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: useWhiteForeground(color) ? Colors.white : Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Center(
        child: TextStyles.standardText(
            text: "$tipo: ${Utility.formatterNumber(tarifa ?? 0)}",
            color: useWhiteForeground(color) ? Colors.white : Colors.black),
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
    bool withDeleteButton = true,
  }) {
    return SizedBox(
      width: 170,
      height: withDeleteButton ? null : 38,
      child: Card(
        color: colorCard,
        child: Row(
          mainAxisAlignment: withDeleteButton
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            const SizedBox(width: 7),
            TextStyles.standardText(
                text: Utility.getStringPeriod(
                    initDate: initDate, lastDate: lastDate),
                color: useWhiteForeground(colorCard)
                    ? Colors.white
                    : Colors.black),
            if (withDeleteButton)
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
