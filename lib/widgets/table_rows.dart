import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/temporada_model.dart';

import '../models/habitacion_model.dart';
import '../models/registro_tarifa_model.dart';
import '../models/tarifa_x_dia_model.dart';
import '../ui/buttons.dart';
import '../utils/helpers/utility.dart';
import '../utils/helpers/web_colors.dart';
import 'item_rows.dart';
import '../views/generacion_cotizaciones/manager_tariff_single_dialog.dart';
import 'text_styles.dart';

class TableRows {
  static Widget tableRowTarifaDay(
    BuildContext context, {
    required Habitacion habitacion,
    required double screenWidth,
    required TarifaXDia tarifaXDia,
    void Function()? setState,
    required bool isGroupTariff,
  }) {
    RegistroTarifa? tarifa = tarifaXDia.tarifa == null
        ? null
        : RegistroTarifa(
            tarifas: [tarifaXDia.tarifa!],
            temporadas: tarifaXDia.temporadaSelect != null
                ? [tarifaXDia.temporadaSelect!]
                : []);

    double tarifaAdulto = Utility.calculateTotalTariffRoom(
      tarifa,
      habitacion,
      habitacion.tarifaXDia!.length,
      descuentoProvisional: tarifaXDia.descuentoProvisional,
      isGroupTariff: isGroupTariff,
    );

    double tarifaMenores = Utility.calculateTotalTariffRoom(
      tarifa,
      habitacion,
      habitacion.tarifaXDia!.length,
      isCalculateChildren: true,
      descuentoProvisional: tarifaXDia.descuentoProvisional,
      isGroupTariff: isGroupTariff,
    );

    void showDialogManagerTariff() {
      showDialog(
        context: context,
        builder: (context) => ManagerTariffSingleDialog(
          tarifaXDia: tarifaXDia,
          numDays: DateTime.parse(habitacion.fechaCheckOut ?? '')
              .difference(DateTime.parse(habitacion.fechaCheckIn ?? ''))
              .inDays,
        ),
      ).then(
        (value) {
          if (value != null) {
            tarifa = tarifaXDia.tarifa == null
                ? null
                : RegistroTarifa(
                    tarifas: [tarifaXDia.tarifa!],
                    temporadas: tarifaXDia.temporadaSelect != null
                        ? [tarifaXDia.temporadaSelect!]
                        : []);
            setState!.call();
          }
        },
      );
    }

    Color colorTariff = tarifaXDia.subCode == null
        ? tarifaXDia.color ?? DesktopColors.cerulean
        : Utility.darken(tarifaXDia.color ?? DesktopColors.cerulean, 0.2);

    return Card(
      child: SizedBox(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Center(
                  child: TextStyles.standardText(
                      text:
                          tarifaXDia.fecha!.toIso8601String().substring(0, 10),
                      color: Theme.of(context).primaryColor,
                      size: 12),
                ),
                Center(
                  child: TextStyles.standardText(
                      text: Utility.formatterNumber(tarifaAdulto),
                      color: Theme.of(context).primaryColor,
                      size: 12),
                ),
                Center(
                  child: TextStyles.standardText(
                      text: Utility.formatterNumber(tarifaMenores),
                      color: Theme.of(context).primaryColor,
                      size: 12),
                ),
                if (screenWidth > 1400)
                  Center(
                    child: TextStyles.standardText(
                        text: Utility.formatterNumber(0),
                        color: Theme.of(context).primaryColor,
                        size: 12),
                  ),
                if (screenWidth > 1000)
                  Center(
                    child: TextStyles.standardText(
                        text: Utility.formatterNumber(
                            (tarifaAdulto + tarifaMenores)),
                        color: Theme.of(context).primaryColor,
                        size: 12),
                  ),
                if (screenWidth > 1400)
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Center(
                      child: SizedBox(
                        width: 95,
                        child: Buttons.commonButton(
                          tooltipText: !isGroupTariff
                              ? null
                              : "No aplica en cot. Grupales",
                          onPressed: isGroupTariff
                              ? null
                              : () => showDialogManagerTariff(),
                          text: "Editar",
                          color: colorTariff,
                          colorText: tarifaXDia.color == null
                              ? Colors.white
                              : useWhiteForeground(colorTariff)
                                  ? Colors.white
                                  : const Color.fromARGB(255, 43, 43, 43),
                        ),
                      ),
                    ),
                  )
                else
                  IconButton(
                    onPressed:
                        isGroupTariff ? null : () => showDialogManagerTariff(),
                    tooltip:
                        isGroupTariff ? "No aplica en cot. Grupales" : "Editar",
                    icon: Icon(
                      CupertinoIcons.pencil,
                      size: 25,
                      color: isGroupTariff
                          ? DesktopColors.grisPalido
                          : colorTariff,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static TableRow tableRowTarifario(
      {required RegistroTarifa element,
      required BuildContext context,
      required double screenWidth,
      void Function(RegistroTarifa)? onEdit,
      void Function(RegistroTarifa)? onDelete}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Center(
            child: TextStyles.standardText(
                text: element.id?.toString() ?? "",
                color: Theme.of(context).primaryColor,
                size: 14),
          ),
        ),
        Center(
          child: TextStyles.standardText(
              text: element.fechaRegistro!
                  .toIso8601String()
                  .substring(0, 10)
                  .replaceAll('-', '/'),
              color: Theme.of(context).primaryColor,
              size: 14),
        ),
        Center(
          child: TextStyles.standardText(
              text: element.nombre ?? '',
              color: Theme.of(context).primaryColor,
              size: 14),
        ),
        if (screenWidth > 1525)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TextStyles.standardText(
                  text: Utility.defineStatusTariff(element.periodos),
                  color: Theme.of(context).primaryColor,
                  size: 14),
            ),
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: ListView.builder(
                itemCount: element.periodos?.length,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ItemRows.filterItemRow(
                  withDeleteButton: false,
                  colorCard: element.color!,
                  initDate: element.periodos![index].fechaInicial!,
                  lastDate: element.periodos![index].fechaFinal!,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (screenWidth > 1300)
                Expanded(
                  child: Buttons.commonButton(
                    onPressed: () => onEdit!.call(element),
                    text: "Editar",
                    color: DesktopColors.turquezaOscure,
                  ),
                )
              else
                IconButton(
                  onPressed: () => onEdit!.call(element),
                  tooltip: "Editar",
                  icon: Icon(
                    CupertinoIcons.pencil,
                    size: 30,
                    color: DesktopColors.turquezaOscure,
                  ),
                ),
              const SizedBox(width: 10),
              if (screenWidth > 1300)
                Expanded(
                  child: Buttons.commonButton(
                    onPressed: () => onDelete!.call(element),
                    text: "Eliminar",
                    color: DesktopColors.ceruleanOscure,
                  ),
                )
              else
                IconButton(
                  onPressed: () => onDelete!.call(element),
                  tooltip: "Eliminar",
                  icon: Icon(
                    CupertinoIcons.delete,
                    size: 30,
                    color: DesktopColors.ceruleanOscure,
                  ),
                ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  static TableRow tarifasTemporadaTableRow(
    BuildContext context, {
    required Temporada element,
    required TextEditingController adults1a2,
    required TextEditingController adults3,
    required TextEditingController adults4,
    required TextEditingController paxAdic,
    required TextEditingController minor7a12,
    bool isGroup = false,
  }) {
    Color colorText =
        isGroup ? DesktopColors.cotGrupal : DesktopColors.cotIndiv;

    return TableRow(
      children: [
        SizedBox(
          height: 50,
          child: Center(
              child: TextStyles.mediumText(
            text: element.nombre ?? '',
            color: colorText,
            aling: TextAlign.center,
          )),
        ),
        Center(
            child: TextStyles.mediumText(
          text: (adults1a2.text.isEmpty && element.porcentajePromocion == null)
              ? "—"
              : Utility.calculatePromotion(
                  adults1a2.text,
                  element.porcentajePromocion,
                ),
          color: Theme.of(context).primaryColor,
          aling: TextAlign.center,
        )),
        Center(
            child: TextStyles.mediumText(
          text: ((adults3.text.isEmpty || adults3.text == '0') &&
                  element.porcentajePromocion == null)
              ? "—"
              : Utility.calculatePromotion(
                  adults3.text,
                  element.porcentajePromocion,
                ),
          color: Theme.of(context).primaryColor,
          aling: TextAlign.center,
        )),
        Center(
          child: TextStyles.mediumText(
            text: ((adults4.text.isEmpty || adults4.text == '0') &&
                    element.porcentajePromocion == null)
                ? "—"
                : Utility.calculatePromotion(
                    adults4.text,
                    element.porcentajePromocion,
                  ),
            color: Theme.of(context).primaryColor,
            aling: TextAlign.center,
          ),
        ),
        Center(
            child: TextStyles.mediumText(
          text: (paxAdic.text.isEmpty && element.porcentajePromocion == null)
              ? "—"
              : Utility.calculatePromotion(
                  paxAdic.text,
                  element.porcentajePromocion,
                ),
          color: Theme.of(context).primaryColor,
          aling: TextAlign.center,
        )),
        Center(
          child: TextStyles.mediumText(
            text:
                (minor7a12.text.isEmpty && element.porcentajePromocion == null)
                    ? "—"
                    : Utility.calculatePromotion(
                        minor7a12.text,
                        element.porcentajePromocion,
                      ),
            color: Theme.of(context).primaryColor,
            aling: TextAlign.center,
          ),
        ),
        Center(
          child: TextStyles.mediumText(
            text: "GRATIS",
            color: Theme.of(context).primaryColor,
            aling: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
