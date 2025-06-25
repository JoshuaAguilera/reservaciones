import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dialogs/manager_tariff_single_dialog.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/registro_tarifa_model.dart';
import '../../res/ui/buttons.dart';
import '../../res/helpers/utility.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/text_styles.dart';

class CheckListtileTariffWidget extends StatefulWidget {
  const CheckListtileTariffWidget({
    super.key,
    required this.tarifaXDia,
    required this.habitacion,
    this.viewTableRow = false,
    this.isGroupTariff = false,
    this.useSeasonCash = false,
  });

  final TarifaXDia tarifaXDia;
  final Habitacion habitacion;
  final bool viewTableRow;
  final bool isGroupTariff;
  final bool useSeasonCash;

  @override
  State<CheckListtileTariffWidget> createState() =>
      _CheckListtileTariffWidgetState();
}

class _CheckListtileTariffWidgetState extends State<CheckListtileTariffWidget> {
  void showDialogEditQuote() {
    showDialog(
      context: context,
      builder: (context) => ManagerTariffSingleDialog(
        tarifaXDia: widget.tarifaXDia,
        numDays: DateTime.parse(widget.habitacion.checkOut ?? '')
            .difference(DateTime.parse(widget.habitacion.checkIn ?? ''))
            .inDays,
      ),
    ).then(
      (value) {
        if (value != null) {
          setState(() {});
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegistroTarifa? tarifa = widget.tarifaXDia.tarifa == null
        ? null
        : RegistroTarifa(
            tarifas: (widget.tarifaXDia.tarifas != null ||
                    widget.tarifaXDia.tarifas!.isNotEmpty)
                ? widget.tarifaXDia.tarifas
                : [widget.tarifaXDia.tarifa!],
            temporadas: widget.tarifaXDia.temporadaSelect != null
                ? [widget.tarifaXDia.temporadaSelect!]
                : [],
          );

    double screenWidth = MediaQuery.of(context).size.width;

    Color colorTariff = widget.tarifaXDia.subCode == null
        ? widget.tarifaXDia.color ?? DesktopColors.cerulean
        : Utility.darken(
            widget.tarifaXDia.color ?? DesktopColors.cerulean, 0.2);

    return Card(
      elevation: 5,
      color: Theme.of(context).primaryColorDark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: TextStyles.TextSpecial(
            day: widget.tarifaXDia.dia! + 1,
            subtitle: "DIA",
            sizeTitle: 22,
            colorsubTitle: Theme.of(context).dividerColor,
            colorTitle: colorTariff,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Wrap(
              spacing: 20,
              runSpacing: 5,
              children: [
                TextStyles.TextAsociative(
                  "Fecha:  ",
                  Utility.getCompleteDate(data: widget.tarifaXDia.fecha!),
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
                if (screenWidth > 925)
                  TextStyles.TextAsociative(
                    "Tarifa aplicada:  ",
                    widget.tarifaXDia.nombreTariff ?? '',
                    color: Theme.of(context).primaryColor,
                    size: 12,
                  ),
              ],
            ),
          ),
          subtitle: Wrap(
            spacing: 20,
            runSpacing: 5,
            children: [
              TextStyles.TextAsociative(
                "${(screenWidth > 925) ? "Tarifa de adulto" : "Adul."}:  ",
                Utility.formatterNumber(
                  Utility.calculateTotalTariffRoom(
                    tarifa,
                    widget.habitacion,
                    widget.habitacion.tarifasXHabitacion!.length,
                    descuentoProvisional:
                        widget.tarifaXDia.descIntegrado,
                    isGroupTariff: widget.isGroupTariff,
                    useCashSeason: widget.useSeasonCash,
                    applyRoundFormat: !(widget.tarifaXDia.modificado ?? false),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              TextStyles.TextAsociative(
                "${(screenWidth > 1000) ? "Tarifa de Menores de 7 a 12" : "Men. 7 a 12"}:  ",
                Utility.formatterNumber(
                  Utility.calculateTotalTariffRoom(
                    tarifa,
                    widget.habitacion,
                    widget.habitacion.tarifasXHabitacion!.length,
                    descuentoProvisional:
                        widget.tarifaXDia.descIntegrado,
                    isCalculateChildren: true,
                    isGroupTariff: widget.isGroupTariff,
                    useCashSeason: widget.useSeasonCash,
                    applyRoundFormat: !(widget.tarifaXDia.modificado ?? false),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              TextStyles.TextAsociative(
                "${(screenWidth > 1000) ? "Tarifa de Menores de 0 a 6" : "Men. 0 a 6"}:  ",
                Utility.formatterNumber(0),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              TextStyles.TextAsociative(
                "${(screenWidth > 925) ? "Total Tarifa" : "Total tar."}:  ",
                Utility.formatterNumber(
                  Utility.calculateTotalTariffRoom(
                    tarifa,
                    widget.habitacion,
                    widget.habitacion.tarifasXHabitacion!.length,
                    descuentoProvisional:
                        widget.tarifaXDia.descIntegrado,
                    isGroupTariff: widget.isGroupTariff,
                    useCashSeason: widget.useSeasonCash,
                    getTotalRoom: true,
                    applyRoundFormat: !(widget.tarifaXDia.modificado ?? false),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              if (MediaQuery.of(context).size.width > 1300)
                TextStyles.TextAsociative(
                  "Periodo:  ",
                  widget.tarifaXDia.periodo == null
                      ? "No definido"
                      : Utility.getStringPeriod(
                          initDate: widget.tarifaXDia.periodo!.fechaInicial!,
                          lastDate: widget.tarifaXDia.periodo!.fechaFinal!,
                          compact: true,
                        ),
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
              if (MediaQuery.of(context).size.width > 1500 &&
                  widget.tarifaXDia.temporadas != null)
                TextStyles.TextAsociative(
                  "Temporada:  ",
                  widget.tarifaXDia.temporadaSelect?.nombre ?? "---",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
              if (widget.tarifaXDia.temporadas == null)
                TextStyles.TextAsociative(
                  "Descuento:  ",
                  "${widget.tarifaXDia.descIntegrado ?? 0}%",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
            ],
          ),
          trailing: (MediaQuery.of(context).size.width > 1400)
              ? SizedBox(
                  width: 115,
                  child: Buttons.commonButton(
                    tooltipText: !widget.isGroupTariff
                        ? null
                        : "No aplica en cot. Grupales",
                    onPressed: widget.isGroupTariff
                        ? null
                        : () => showDialogEditQuote(),
                    text: "Editar",
                    color: colorTariff,
                    colorText: useWhiteForeground(colorTariff)
                        ? Colors.white
                        : const Color.fromARGB(255, 43, 43, 43),
                  ),
                )
              : IconButton(
                  onPressed:
                      widget.isGroupTariff ? null : () => showDialogEditQuote(),
                  tooltip: widget.isGroupTariff
                      ? "No aplica en cot. Grupales"
                      : "Editar",
                  icon: Icon(
                    Iconsax.edit_outline,
                    size: 30,
                    color: widget.isGroupTariff
                        ? DesktopColors.grisPalido
                        : colorTariff,
                  ),
                ),
        ),
      ),
    );
  }
}
