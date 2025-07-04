import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/categoria_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/tarifa_base_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../../models/temporada_model.dart';
import '../../res/helpers/calculator_helpers.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/ui/buttons.dart';
import '../../res/helpers/utility.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../views/generacion_cotizaciones/dialogs/manager_tariff_single_dialog.dart';
import 'item_rows.dart';
import '../../res/ui/text_styles.dart';

class TableRows {
  static Widget tableRowTarifaDay(
    BuildContext context, {
    required Habitacion habitacion,
    required double screenWidth,
    required TarifaXHabitacion tarHab,
    required Categoria categoria,
    String tipoTemporada = "individual",
    void Function()? setState,
  }) {
    TarifaRack? tarifa = TarifaRack(
      registros: tarHab.tarifaXDia?.tarifaRack?.registros,
      temporadas: tarHab.tarifaXDia?.temporadaSelect != null
          ? [tarHab.tarifaXDia!.temporadaSelect!]
          : [],
    );

    double tarifaAdulto = CalculatorHelpers.getTotalCategoryRoom(
      tarifa,
      habitacion,
      categoria,
      habitacion.tarifasXHabitacion!.length,
      descuentoProvisional: tarHab.tarifaXDia?.descIntegrado,
      tipoTemporada: tipoTemporada,
      applyRoundFormat: !(tarHab.tarifaXDia?.modificado ?? false),
    );

    double tarifaMenores = CalculatorHelpers.getTotalCategoryRoom(
      tarifa,
      habitacion,
      categoria,
      habitacion.tarifasXHabitacion!.length,
      isCalculateChildren: true,
      descuentoProvisional: tarHab.tarifaXDia?.descIntegrado,
      tipoTemporada: tipoTemporada,
      applyRoundFormat: !(tarHab.tarifaXDia?.modificado ?? false),
    );

    void showDialogManagerTariff() {
      showDialog(
        context: context,
        builder: (context) => ManagerTariffSingleDialog(
          tarifaXHabitacion: tarHab,
          numDays: habitacion.checkOut!.difference(habitacion.checkIn!).inDays,
        ),
      ).then(
        (value) {
          if (value != null) {
            tarifa = tarifa;
            setState!.call();
          }
        },
      );
    }

    Color colorTariff = tarHab.subcode == null
        ? tarHab.tarifaXDia?.tarifaRack?.color ?? DesktopColors.cerulean
        : ColorsHelpers.darken(
            tarHab.tarifaXDia?.tarifaRack?.color ?? DesktopColors.cerulean,
            0.2);

    return Card(
      child: SizedBox(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Center(
                  child: TextStyles.standardText(
                      text: tarHab.fecha!.toIso8601String().substring(0, 10),
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
                          tooltipText: tipoTemporada == "individual"
                              ? null
                              : "No aplica en cot. Grupales",
                          onPressed: tipoTemporada == "grupal"
                              ? null
                              : () => showDialogManagerTariff(),
                          text: "Editar",
                          color: colorTariff,
                          colorText:
                              tarHab.tarifaXDia?.tarifaRack?.color == null
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
                    onPressed: tipoTemporada == "grupal"
                        ? null
                        : () => showDialogManagerTariff(),
                    tooltip: tipoTemporada == "grupal"
                        ? "No aplica en cot. Grupales"
                        : "Editar",
                    icon: Icon(
                      Iconsax.edit_outline,
                      size: 25,
                      color: tipoTemporada == "grupal"
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
      {required TarifaRack element,
      required BuildContext context,
      required double screenWidth,
      void Function(TarifaRack)? onEdit,
      void Function(TarifaRack)? onDelete,
      required List<TarifaBase> tarifasBase}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Center(
            child: TextStyles.standardText(
              text: element.id?.toString() ?? "",
              color: Theme.of(context).primaryColor,
              size: 12,
            ),
          ),
        ),
        if (screenWidth > 1050)
          Center(
            child: TextStyles.standardText(
              text: element.createdAt!
                  .toIso8601String()
                  .substring(0, 10)
                  .replaceAll('-', '/'),
              color: Theme.of(context).primaryColor,
              size: 12,
            ),
          ),
        Center(
          child: TextStyles.standardText(
            text: element.nombre ?? '',
            color: Theme.of(context).primaryColor,
            size: 12,
          ),
        ),
        if (screenWidth > 1525)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TextStyles.standardText(
                text: Utility.defineStatusTariff(element.periodos),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
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
                  sizeText: 12,
                ),
              ),
            ),
          ),
        ),
        if (screenWidth > 1150)
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
                  itemCount: element.temporadas?.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Tooltip(
                    textAlign: TextAlign.center,
                    message:
                        "Estancia Min: ${element.temporadas?[index].estanciaMinima ?? 0}\n"
                        "Descuento: ${element.temporadas?[index].descuento ?? 0}%",
                    child: ItemRows.filterItemRow(
                      withDeleteButton: false,
                      colorCard:
                          (element.temporadas?[index].tipo ?? "") == "grupal"
                              ? DesktopColors.cotGrupal
                              : (element.temporadas?[index].tipo ?? "") ==
                                      "efectivo"
                                  ? DesktopColors.cashSeason
                                  : DesktopColors.cotIndiv,
                      title: element.temporadas?[index].nombre ?? '',
                      sizeText: 12,
                      withOutWidth: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (screenWidth > 950)
          Center(
            child: TextStyles.standardText(
              text: tarifasBase
                      .where((elementInt) =>
                          elementInt.idInt ==
                          element.registros!.first.tarifa?.tarifaBase?.idInt)
                      .firstOrNull
                      ?.nombre ??
                  '',
              color: Theme.of(context).primaryColor,
              size: 12,
            ),
          ),
        Center(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => onEdit!.call(element),
                tooltip: "Editar",
                icon: Icon(
                  Iconsax.edit_outline,
                  size: 28,
                  color: DesktopColors.turquezaOscure,
                ),
              ),
              IconButton(
                onPressed: () => onDelete!.call(element),
                tooltip: "Eliminar",
                icon: Icon(
                  CupertinoIcons.delete,
                  size: 28,
                  color: DesktopColors.ceruleanOscure,
                ),
              ),
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
    String? tipo = "individual",
    required String categoria,
  }) {
    Color? colorBox = tipo == "grupal"
        ? DesktopColors.cotGrupal
        : tipo == "efectivo"
            ? DesktopColors.cashSeason
            : DesktopColors.cotIndiv;

    return TableRow(
      children: [
        SizedBox(
          height: 50,
          child: Center(
            child: Card(
              color: colorBox,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: TextStyles.mediumText(
                  text: element.nombre ?? '',
                  color: Colors.white,
                  aling: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Center(
            child: TextStyles.standardText(
          text: !((element.useTariff ?? false)) && tipo == "efectivo"
              ? Utility.formatterNumber(element.tarifas
                      ?.where((element) => element.categoria == categoria)
                      .firstOrNull
                      ?.tarifaAdulto1a2 ??
                  0)
              : (adults1a2.text.isEmpty && element.descuento == null)
                  ? "—"
                  : CalculatorHelpers.getPromotion(
                      double.tryParse(adults1a2.text),
                      promocion: element.descuento,
                    ),
          color: Theme.of(context).primaryColor,
          align: TextAlign.center,
        )),
        Center(
            child: TextStyles.standardText(
          text: !((element.useTariff ?? false)) && tipo == "efectivo"
              ? Utility.formatterNumber(element.tarifas
                      ?.where((element) => element.categoria == categoria)
                      .firstOrNull
                      ?.tarifaAdulto3 ??
                  0)
              : ((adults3.text.isEmpty || adults3.text == '0') &&
                      element.descuento == null)
                  ? "—"
                  : CalculatorHelpers.getPromotion(
                      double.tryParse(adults3.text),
                      promocion: element.descuento,
                    ),
          color: Theme.of(context).primaryColor,
          align: TextAlign.center,
        )),
        Center(
          child: TextStyles.standardText(
            text: !((element.useTariff ?? false)) && tipo == "efectivo"
                ? Utility.formatterNumber(element.tarifas
                        ?.where((element) => element.categoria == categoria)
                        .firstOrNull
                        ?.tarifaAdulto4 ??
                    0)
                : ((adults4.text.isEmpty || adults4.text == '0') &&
                        element.descuento == null)
                    ? "—"
                    : CalculatorHelpers.getPromotion(
                        double.tryParse(adults4.text),
                        promocion: element.descuento,
                      ),
            color: Theme.of(context).primaryColor,
            align: TextAlign.center,
          ),
        ),
        Center(
          child: TextStyles.standardText(
            text: !((element.useTariff ?? false)) && tipo == "efectivo"
                ? Utility.formatterNumber(element.tarifas
                        ?.where((element) => element.categoria == categoria)
                        .firstOrNull
                        ?.tarifaMenores7a12 ??
                    0)
                : (minor7a12.text.isEmpty && element.descuento == null)
                    ? "—"
                    : CalculatorHelpers.getPromotion(
                        double.tryParse(minor7a12.text),
                        promocion: element.descuento,
                      ),
            color: Theme.of(context).primaryColor,
            align: TextAlign.center,
          ),
        ),
        Center(
          child: TextStyles.standardText(
            text: !((element.useTariff ?? false)) && tipo == "efectivo"
                ? Utility.formatterNumber(element.tarifas
                        ?.where((element) => element.categoria == categoria)
                        .firstOrNull
                        ?.tarifaPaxAdicional ??
                    0)
                : (paxAdic.text.isEmpty && element.descuento == null)
                    ? "—"
                    : CalculatorHelpers.getPromotion(
                        double.tryParse(paxAdic.text),
                        promocion: element.descuento,
                      ),
            color: Theme.of(context).primaryColor,
            align: TextAlign.center,
          ),
        ),
        Center(
          child: TextStyles.standardText(
            text: "GRATIS",
            color: Theme.of(context).primaryColor,
            align: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
