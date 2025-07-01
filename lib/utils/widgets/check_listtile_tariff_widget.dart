import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/categoria_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../../models/temporada_model.dart';
import '../../res/helpers/calculator_helpers.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/ui/buttons.dart';
import '../../res/helpers/utility.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/text_styles.dart';
import '../../views/generacion_cotizaciones/dialogs/manager_tariff_single_dialog.dart';

class CheckListtileTariffWidget extends StatefulWidget {
  const CheckListtileTariffWidget({
    super.key,
    required this.tarifaXHab,
    required this.habitacion,
    this.viewTableRow = false,
    this.categoria,
    this.tipoCotizacion = "",
  });

  final TarifaXHabitacion tarifaXHab;
  final Habitacion habitacion;
  final Categoria? categoria;
  final bool viewTableRow;
  final String tipoCotizacion;

  @override
  State<CheckListtileTariffWidget> createState() =>
      _CheckListtileTariffWidgetState();
}

class _CheckListtileTariffWidgetState extends State<CheckListtileTariffWidget> {
  late Color colorRack;

  void showDialogEditQuote() {
    int days = widget.habitacion.checkOut!
        .difference(widget.habitacion.checkIn!)
        .inDays;

    showDialog(
      context: context,
      builder: (context) => ManagerTariffSingleDialog(
        tarifaXHabitacion: widget.tarifaXHab,
        numDays: days,
      ),
    ).then(
      (value) {
        if (value != null) setState(() {});
      },
    );
  }

  @override
  void initState() {
    Color colorTariff = widget.tarifaXHab.tarifaXDia?.tarifaRack?.color ??
        DesktopColors.cerulean;
    colorRack = widget.tarifaXHab.subcode == null
        ? colorTariff
        : ColorsHelpers.darken(colorRack, 0.2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TarifaRack? rack = widget.tarifaXHab.tarifaXDia?.tarifaRack;
    Temporada? temporada = widget.tarifaXHab.tarifaXDia?.temporadaSelect;
    TarifaRack? tarifa = TarifaRack(
      tarifas: rack?.tarifas,
      temporadas: temporada != null ? [temporada] : [],
    );

    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 5,
      color: Theme.of(context).primaryColorDark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: TextStyles.TextSpecial(
            day: widget.tarifaXHab.dia! + 1,
            subtitle: "DIA",
            sizeTitle: 22,
            colorsubTitle: Theme.of(context).dividerColor,
            colorTitle: colorRack,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Wrap(
              spacing: 20,
              runSpacing: 5,
              children: [
                TextStyles.TextAsociative(
                  "Fecha:  ",
                  DateHelpers.getStringDate(data: widget.tarifaXHab.fecha),
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
                if (screenWidth > 925)
                  TextStyles.TextAsociative(
                    "Tarifa aplicada:  ",
                    widget.tarifaXHab.tarifaXDia?.tarifaRack?.nombre ?? '',
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
                  CalculatorHelpers.getTotalCategoryRoom(
                    tarifa,
                    widget.habitacion,
                    widget.categoria,
                    tipoTemporada: widget.tipoCotizacion,
                    widget.habitacion.tarifasXHabitacion!.length,
                    descuentoProvisional:
                        widget.tarifaXHab.tarifaXDia?.descIntegrado,
                    applyRoundFormat:
                        !(widget.tarifaXHab.tarifaXDia?.modificado ?? false),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              TextStyles.TextAsociative(
                "${(screenWidth > 1000) ? "Tarifa de Menores de 7 a 12" : "Men. 7 a 12"}:  ",
                Utility.formatterNumber(
                  CalculatorHelpers.getTotalCategoryRoom(
                    tarifa,
                    widget.habitacion,
                    widget.categoria,
                    tipoTemporada: widget.tipoCotizacion,
                    widget.habitacion.tarifasXHabitacion!.length,
                    descuentoProvisional:
                        widget.tarifaXHab.tarifaXDia?.descIntegrado,
                    isCalculateChildren: true,
                    applyRoundFormat:
                        !(widget.tarifaXHab.tarifaXDia?.modificado ?? false),
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
                  CalculatorHelpers.getTotalCategoryRoom(
                    tarifa,
                    widget.habitacion,
                    widget.categoria,
                    tipoTemporada: widget.tipoCotizacion,
                    widget.habitacion.tarifasXHabitacion!.length,
                    descuentoProvisional:
                        widget.tarifaXHab.tarifaXDia?.descIntegrado,
                    getTotalRoom: true,
                    applyRoundFormat:
                        !(widget.tarifaXHab.tarifaXDia?.modificado ?? false),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              if (MediaQuery.of(context).size.width > 1300)
                TextStyles.TextAsociative(
                  "Periodo:  ",
                  widget.tarifaXHab.tarifaXDia?.periodoSelect == null
                      ? "No definido"
                      : DateHelpers.getStringPeriod(
                          initDate: widget.tarifaXHab.tarifaXDia!.periodoSelect!
                              .fechaInicial!,
                          lastDate: widget.tarifaXHab.tarifaXDia!.periodoSelect!
                              .fechaFinal!,
                          compact: true,
                        ),
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
              if (MediaQuery.of(context).size.width > 1500 &&
                  widget.tarifaXHab.tarifaXDia?.tarifaRack?.temporadas != null)
                TextStyles.TextAsociative(
                  "Temporada:  ",
                  widget.tarifaXHab.tarifaXDia?.tarifaRack?.nombre ?? "---",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
              if (widget.tarifaXHab.tarifaXDia?.tarifaRack?.temporadas == null)
                TextStyles.TextAsociative(
                  "Descuento:  ",
                  "${widget.tarifaXHab.tarifaXDia?.descIntegrado ?? 0}%",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                ),
            ],
          ),
          trailing: (MediaQuery.of(context).size.width > 1400)
              ? SizedBox(
                  width: 115,
                  child: Buttons.commonButton(
                    tooltipText: !(widget.tipoCotizacion == "grupal")
                        ? null
                        : "No aplica en cot. Grupales",
                    onPressed: (widget.tipoCotizacion == "grupal")
                        ? null
                        : () => showDialogEditQuote(),
                    text: "Editar",
                    color: colorRack,
                    colorText: useWhiteForeground(colorRack)
                        ? Colors.white
                        : const Color.fromARGB(255, 43, 43, 43),
                  ),
                )
              : IconButton(
                  onPressed: (widget.tipoCotizacion == "grupal")
                      ? null
                      : () => showDialogEditQuote(),
                  tooltip: (widget.tipoCotizacion == "grupal")
                      ? "No aplica en cot. Grupales"
                      : "Editar",
                  icon: Icon(
                    Iconsax.edit_outline,
                    size: 30,
                    color: (widget.tipoCotizacion == "grupal")
                        ? DesktopColors.grisPalido
                        : colorRack,
                  ),
                ),
        ),
      ),
    );
  }
}
