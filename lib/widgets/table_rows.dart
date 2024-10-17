import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../models/habitacion_model.dart';
import '../models/registro_tarifa_model.dart';
import '../models/tarifa_x_dia_model.dart';
import '../ui/buttons.dart';
import '../utils/helpers/utility.dart';
import '../utils/helpers/web_colors.dart';
import 'item_rows.dart';
import 'manager_tariff_day_widget.dart';
import 'text_styles.dart';

class TableRows {
  static Widget tableRowTarifaDay(
    BuildContext context, {
    required Habitacion habitacion,
    required double screenWidth,
    required TarifaXDia tarifaXDia,
    void Function()? setState,
  }) {
    RegistroTarifa? tarifa = tarifaXDia.tarifa == null
        ? null
        : RegistroTarifa(
            tarifas: [tarifaXDia.tarifa!],
            temporadas: tarifaXDia.temporadaSelect != null
                ? [tarifaXDia.temporadaSelect!]
                : []);

    double tarifaAdulto = Utility.calculateTariffAdult(
      tarifa,
      habitacion,
      habitacion.tarifaXDia!.length,
      descuentoProvisional: tarifaXDia.descuentoProvisional,
    );

    double tarifaMenores = Utility.calculateTariffChildren(
      tarifa,
      habitacion,
      habitacion.tarifaXDia!.length,
      descuentoProvisional: tarifaXDia.descuentoProvisional,
    );

    void showDialogManagerTariff() {
      showDialog(
        context: context,
        builder: (context) => ManagerTariffDayWidget(tarifaXDia: tarifaXDia),
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
                          onPressed: () => showDialogManagerTariff(),
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
                    onPressed: () => showDialogManagerTariff(),
                    tooltip: "Editar",
                    icon: Icon(
                      CupertinoIcons.pencil,
                      size: 25,
                      color: colorTariff,
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
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (var elementInt in element.periodos ?? [])
                    ItemRows.filterItemRow(
                      withDeleteButton: false,
                      colorCard: element.color!,
                      initDate: elementInt.fechaInicial!,
                      lastDate: elementInt.fechaFinal!,
                    ),
                ],
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
            ],
          ),
        ),
      ],
    );
  }
}
