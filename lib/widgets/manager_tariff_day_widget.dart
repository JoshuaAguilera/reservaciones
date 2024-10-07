import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';

import '../utils/helpers/constants.dart';
import '../utils/helpers/utility.dart';
import '../utils/helpers/web_colors.dart';
import 'custom_dropdown.dart';
import 'text_styles.dart';
import 'textformfield_custom.dart';

class ManagerTariffDayWidget extends ConsumerStatefulWidget {
  const ManagerTariffDayWidget({super.key, required this.tarifaXDia});

  final TarifaXDia tarifaXDia;

  @override
  _ManagerTariffDayWidgetState createState() => _ManagerTariffDayWidgetState();
}

class _ManagerTariffDayWidgetState
    extends ConsumerState<ManagerTariffDayWidget> {
  String tarifaSelect = "Mayo - Abril";
  TextEditingController _tarifaAdulto = TextEditingController(text: "0");
  TextEditingController _tarifaMenores = TextEditingController(text: "0");
  TextEditingController _tarifaPaxAdicional = TextEditingController(text: "0");

  @override
  void initState() {
    ///tarifaSelect = widget.tarifaXDia.temporadaSelect == null ? "---" : widget.tarifaXDia.temporadaSelect!.nombre;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: widget.tarifaXDia.color ?? DesktopColors.ceruleanOscure,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                CupertinoIcons.pencil_outline,
                size: 33,
                color: useWhiteForeground(
                        widget.tarifaXDia.color ?? DesktopColors.ceruleanOscure)
                    ? Colors.white
                    : const Color.fromARGB(255, 43, 43, 43),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: TextStyles.titleText(
                  text:
                      "Modificar tarifa del ${widget.tarifaXDia.fecha!.day} / ${monthNames[widget.tarifaXDia.fecha!.month - 1]} / ${widget.tarifaXDia.fecha!.year} \nTarifa aplicada: ${widget.tarifaXDia.nombreTarif}",
                  size: 16,
                  color: Theme.of(context).primaryColor))
        ],
      ),
      content: StatefulBuilder(builder: (context, snapshot) {
        return SizedBox(
          height: 465,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyles.standardText(
                      text: "Temporada: ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    CustomDropdown.dropdownMenuCustom(
                      initialSelection: tarifaSelect,
                      onSelected: (String? value) {
                        tarifaSelect = value!;
                      },
                      elements: [
                        'Mayo - Abril',
                        'Junio - Julio',
                        'Agosto - Septiembre',
                        'Octubre - Noviembre'
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa adulto SGL/DBL",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: _tarifaAdulto,
                  onChanged: (p0) => snapshot(() {}),
                ),
                const SizedBox(height: 12),
                Opacity(
                  opacity: 0.6,
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Tarifa adulto TPL",
                    isMoneda: true,
                    isNumeric: true,
                    isDecimal: true,
                    blocked: true,
                    controller: TextEditingController(
                      text: Utility.calculateRate(
                          _tarifaAdulto, _tarifaPaxAdicional, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Opacity(
                  opacity: 0.6,
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Tarifa adulto CPLE",
                    isMoneda: true,
                    isNumeric: true,
                    isDecimal: true,
                    blocked: true,
                    controller: TextEditingController(
                      text: Utility.calculateRate(
                          _tarifaAdulto, _tarifaPaxAdicional, 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Menores 7 a 12 años",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: _tarifaMenores,
                ),
                const SizedBox(height: 12),
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Tarifa Pax Adicional",
                  isMoneda: true,
                  isNumeric: true,
                  isDecimal: true,
                  controller: _tarifaPaxAdicional,
                  onChanged: (p0) => snapshot(() {}),
                ),
              ],
            ),
          ),
        );
      }),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextStyles.buttonText(text: "CANCELAR")),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: TextStyles.buttonText(
            text: "ACEPTAR",
          ),
        ),
      ],
    );
  }
}
