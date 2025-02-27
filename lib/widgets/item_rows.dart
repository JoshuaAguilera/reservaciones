import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/card_animation_widget.dart';
import 'package:generador_formato/views/tarifario/calendar_controller_widget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../utils/helpers/desktop_colors.dart';
import '../utils/shared_preferences/settings.dart';
import 'dialogs.dart';
import 'text_styles.dart';

class ItemRows {
  static Widget statusQuoteRow(NumeroCotizacion register,
      {double sizeText = 13}) {
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
      margin: const EdgeInsets.only(bottom: 9),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(Utility.getIconCardDashboard(register.tipoCotizacion),
                size: 55,
                color: Utility.darken(
                  Utility.getColorRegisterQuote(register.tipoCotizacion!),
                  0.12,
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.standardText(
                text: register.tipoCotizacion ?? '',
                color: Colors.white,
                size: sizeText,
                overClip: true,
              ),
              TextStyles.TextTitleList(
                index: register.numCotizaciones,
                color: Colors.white,
                size: 29.5,
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
    int day = 0,
    required bool inPeriod,
    DateTime? dateNow,
    required SidebarXController sideController,
    TarifaXDia? tarifaXDia,
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
                  sideController: sideController,
                  tarifaXDia: tarifaXDia!,
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
                      child: (dateNow!.isSameDate(DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day)))
                          ? TextStyles.TextSpecial(
                                  day: day,
                                  subtitle: "",
                                  colorTitle: Colors.amber)
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .shimmer(
                                delay:
                                    !Settings.applyAnimations ? null : 1800.ms,
                                duration:
                                    Settings.applyAnimations ? 1200.ms : 0.ms,
                              )
                              .shake(
                                hz: 4,
                                curve: Curves.easeInOutCubic,
                                duration:
                                    Settings.applyAnimations ? null : 0.ms,
                              )
                              .then(
                                delay:
                                    !Settings.applyAnimations ? null : 600.ms,
                                duration:
                                    Settings.applyAnimations ? null : 0.ms,
                              )
                          : TextStyles.TextSpecial(day: day, subtitle: ""),
                    ),
                  ],
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
                Icon(Iconsax.edit_outline, color: DesktopColors.mentaOscure),
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
                  contentText:
                      "¿Desea eliminar la siguiente tarifa: ${registroTarifa.nombre}?",
                  nameButtonMain: "Aceptar",
                  funtionMain: () async {
                    onDelete!.call();
                  },
                  nameButtonCancel: "Cancelar",
                  withButtonCancel: true,
                  withLoadingProcess: true,
                  otherButton: true,
                  iconData: Icons.delete,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(CupertinoIcons.delete, color: DesktopColors.cerulean),
                TextStyles.standardText(
                    text: "Eliminar", color: Theme.of(context).primaryColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget tarifaCheckListItemRow({
    required RegistroTarifa registro,
    required double screenWidth,
    required void Function(RegistroTarifa)? onEdit,
    required void Function(RegistroTarifa)? onDelete,
    required String tarifaBase,
  }) {
    Color? colorText = useWhiteForeground(registro.color!)
        ? Utility.darken(registro.color!, -0.4)
        : Utility.darken(registro.color!, 0.4);
    Color? colorIcon = useWhiteForeground(registro.color!)
        ? Utility.darken(registro.color!, -0.45)
        : Utility.darken(registro.color!, 0.45);

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
                  color: colorText,
                ),
                TextStyles.TextAsociative(
                  "Estatus:  ",
                  Utility.defineStatusTariff(registro.periodos),
                  color: colorText,
                  boldInversed: true,
                ),
              ],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: () => onEdit!.call(registro),
                  tooltip: "Editar",
                  icon: Icon(
                    Iconsax.edit_outline,
                    size: 30,
                    color: colorIcon,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => onDelete!.call(registro),
                  tooltip: "Eliminar",
                  icon: Icon(
                    CupertinoIcons.delete,
                    size: 30,
                    color: colorIcon,
                  ),
                ),
              ],
            ),
            subtitle: Wrap(
              spacing: 20,
              children: [
                TextStyles.TextAsociative(
                  "Fecha de registro: ",
                  Utility.getCompleteDate(data: registro.fechaRegistro),
                  color: colorText,
                  size: 13,
                  boldInversed: true,
                ),
                TextStyles.TextAsociative(
                  "Tarifa base: ",
                  tarifaBase,
                  color: colorText,
                  size: 13,
                  boldInversed: true,
                ),

                TextStyles.TextAsociative(
                  "Dias de aplicación: ",
                  "${(registro.periodos?.first.enLunes ?? false) ? "L " : ""}${(registro.periodos?.first.enMartes ?? false) ? "Ma " : ""}${(registro.periodos?.first.enMiercoles ?? false) ? "Mi " : ""}${(registro.periodos?.first.enJueves ?? false) ? "J " : ""}${(registro.periodos?.first.enViernes ?? false) ? "V " : ""}${(registro.periodos?.first.enSabado ?? false) ? "S " : ""}${(registro.periodos?.first.enDomingo ?? false) ? "D " : ""}",
                  color: colorText,
                  size: 13,
                  boldInversed: true,
                ),
                // Wrap(
                //   spacing: 15,
                //   runSpacing: 10,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         TextStyles.standardText(
                //             text: "Tarifas Vista Reserva:",
                //             color: useWhiteForeground(registro.color!)
                //                 ? Colors.white
                //                 : Colors.black),
                //         const SizedBox(height: 4),
                //         Wrap(
                //           spacing: 7,
                //           runSpacing: 5,
                //           children: [
                //             tariffIndItemRow(
                //                 "SGL/DBL",
                //                 registro.tarifas!.first.tarifaAdultoSGLoDBL!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "TPL",
                //                 registro.tarifas!.first.tarifaAdultoTPL,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "CPLE",
                //                 registro.tarifas!.first.tarifaAdultoCPLE,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "MEN 7-12",
                //                 registro.tarifas!.first.tarifaMenores7a12!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "PAX ADIC",
                //                 registro.tarifas!.first.tarifaPaxAdicional!,
                //                 registro.color!),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         TextStyles.standardText(
                //             text: "Tarifas Vista Parcial al Mar:",
                //             color: useWhiteForeground(registro.color!)
                //                 ? Colors.white
                //                 : Colors.black),
                //         const SizedBox(height: 4),
                //         Wrap(
                //           spacing: 7,
                //           runSpacing: 5,
                //           children: [
                //             tariffIndItemRow(
                //                 "SGL/DBL",
                //                 registro.tarifas![1].tarifaAdultoSGLoDBL!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "TPL",
                //                 registro.tarifas![1].tarifaAdultoTPL,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "CPLE",
                //                 registro.tarifas![1].tarifaAdultoCPLE,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "MEN 7-12",
                //                 registro.tarifas![1].tarifaMenores7a12!,
                //                 registro.color!),
                //             tariffIndItemRow(
                //                 "PAX ADIC",
                //                 registro.tarifas![1].tarifaPaxAdicional!,
                //                 registro.color!),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
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
              .animate(
                  delay: !Settings.applyAnimations ? null : (200.ms * index))
              .fadeIn(duration: !Settings.applyAnimations ? 0.ms : 400.ms)
              .scale(duration: !Settings.applyAnimations ? 0.ms : 500.ms),
          const SizedBox(height: 5),
          RotatedBox(
            quarterTurns: withOutDay ? 0 : 1,
            child: SizedBox(
              height: withOutDay ? 7 : null,
              width: withOutDay ? 100 : 12,
              child: const Divider(),
            ),
          )
              .animate(
                  delay: !Settings.applyAnimations ? null : (220.ms * index))
              .fadeIn(
                duration: Settings.applyAnimations ? null : 0.ms,
              ),
          if (select)
            Padding(
              padding: EdgeInsets.only(top: withOutDay ? 0 : 3),
              child: Icon(
                withOutDay ? Icons.keyboard_arrow_down : Icons.circle,
                color: Colors.amber,
                size: withOutDay ? 35 : 7.5,
              ),
            )
                .animate(
                    delay: !Settings.applyAnimations ? null : (220.ms * index))
                .fadeIn(
                  duration: Settings.applyAnimations ? null : 0.ms,
                )
                .scale(
                  duration: Settings.applyAnimations ? 500.ms : 0.ms,
                ),
        ],
      ),
    );
  }

  static Widget filterItemRow({
    required Color colorCard,
    DateTime? initDate,
    DateTime? lastDate,
    void Function()? onRemove,
    bool withDeleteButton = true,
    String title = "",
    bool withOutWidth = false,
    bool isSelect = true,
    Color? backgroundColor,
    double? sizeText,
    double width = 170,
  }) {
    return SizedBox(
      width: withOutWidth ? null : width,
      height: withDeleteButton ? null : 38,
      child: Card(
        color: isSelect ? colorCard : Colors.transparent,
        child: Container(
          decoration: isSelect
              ? null
              : BoxDecoration(
                  border: Border.all(
                      color: isSelect ? colorCard : Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: !withDeleteButton ? 6 : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: withDeleteButton
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (withDeleteButton) const SizedBox(width: 7),
                TextStyles.standardText(
                  text: (initDate == null && lastDate == null)
                      ? title
                      : Utility.getStringPeriod(
                          initDate: initDate!, lastDate: lastDate!),
                  color: useWhiteForeground(
                          isSelect ? colorCard : backgroundColor ?? colorCard)
                      ? isSelect
                          ? Utility.darken(colorCard, -0.4)
                          : colorCard
                      : Utility.darken(colorCard, 0.225),
                  size: sizeText ?? 13,
                ),
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
                        color: useWhiteForeground(isSelect
                                ? colorCard
                                : backgroundColor ?? colorCard)
                            ? isSelect
                                ? Utility.darken(colorCard, -0.42)
                                : colorCard
                            : Utility.darken(colorCard, 0.3),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
