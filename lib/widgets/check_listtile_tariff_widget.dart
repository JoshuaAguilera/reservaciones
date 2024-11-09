import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';

import '../models/registro_tarifa_model.dart';
import '../ui/buttons.dart';
import '../utils/helpers/utility.dart';
import '../utils/helpers/web_colors.dart';
import 'manager_tariff_day_widget.dart';
import 'text_styles.dart';

class CheckListtileTariffWidget extends StatefulWidget {
  const CheckListtileTariffWidget(
      {super.key,
      required this.tarifaXDia,
      required this.habitacion,
      this.viewTableRow = false});

  final TarifaXDia tarifaXDia;
  final Habitacion habitacion;
  final bool viewTableRow;

  @override
  State<CheckListtileTariffWidget> createState() =>
      _CheckListtileTariffWidgetState();
}

class _CheckListtileTariffWidgetState extends State<CheckListtileTariffWidget> {
  RegistroTarifa? tarifa;

  void showDialogEditQuote() {
    showDialog(
      context: context,
      builder: (context) => ManagerTariffDayWidget(
        tarifaXDia: widget.tarifaXDia,
        numDays: DateTime.parse(widget.habitacion.fechaCheckOut ?? '')
            .difference(DateTime.parse(widget.habitacion.fechaCheckIn ?? ''))
            .inDays,
      ),
    ).then(
      (value) {
        if (value != null) {
          refreshTarifa();
          setState(() {});
        }
      },
    );
  }

  void refreshTarifa() {
    tarifa = widget.tarifaXDia.tarifa == null
        ? null
        : RegistroTarifa(
            tarifas: [widget.tarifaXDia.tarifa!],
            temporadas: widget.tarifaXDia.temporadaSelect != null
                ? [widget.tarifaXDia.temporadaSelect!]
                : [],
          );
  }

  @override
  void initState() {
    refreshTarifa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Utility.calculateTariffAdult(
                    tarifa,
                    widget.habitacion,
                    widget.habitacion.tarifaXDia!.length,
                    descuentoProvisional:
                        widget.tarifaXDia.descuentoProvisional,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              TextStyles.TextAsociative(
                "${(screenWidth > 1000) ? "Tarifa de Menores de 7 a 12" : "Men. 7 a 12"}:  ",
                Utility.formatterNumber(Utility.calculateTariffChildren(
                  tarifa,
                  widget.habitacion,
                  widget.habitacion.tarifaXDia!.length,
                  descuentoProvisional: widget.tarifaXDia.descuentoProvisional,
                )),
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
              TextStyles.TextAsociative(
                "${(screenWidth > 1000) ? "Tarifa de Menores de 0 a 6" : "Men. 0 a 6"}:  ",
                Utility.formatterNumber(0),
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
                  "${widget.tarifaXDia.descuentoProvisional ?? 0}%",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                )
            ],
          ),
          trailing: (MediaQuery.of(context).size.width > 1400)
              ? SizedBox(
                  width: 115,
                  child: Buttons.commonButton(
                    onPressed: () => showDialogEditQuote(),
                    text: "Editar",
                    color: colorTariff,
                    colorText: useWhiteForeground(colorTariff)
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
                    color: colorTariff,
                  ),
                ),
        ),
      ),
    );
  }
}
