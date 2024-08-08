import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dias_list.dart';

import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/number_input_with_increment_decrement.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class HabitacionForm extends StatefulWidget {
  const HabitacionForm(
      {super.key, required this.cancelarFunction, this.habitacionSelect});

  final void Function()? cancelarFunction;
  final Habitacion? habitacionSelect;

  @override
  State<HabitacionForm> createState() => _HabitacionFormState();
}

class _HabitacionFormState extends State<HabitacionForm> {
  Habitacion nuevaHabitacion = Habitacion();
  final _formKeyHabitacion = GlobalKey<FormState>();
  TextEditingController _fechaEntrada = TextEditingController();
  TextEditingController _fechaSalida = TextEditingController();
  bool isError = false;
  bool changedDate = false;
  List<Widget> modesVisual = <Widget>[
    const Icon(Icons.calendar_month_rounded),
    const Icon(Icons.table_chart),
    const Icon(Icons.dehaze_sharp),
  ];

  final List<bool> _selectedMode = <bool>[
    true,
    false,
    false,
  ];

  @override
  void initState() {
    nuevaHabitacion = widget.habitacionSelect ??
        Habitacion(
          categoria: categorias.first,
          plan: planes.first,
          fechaCheckIn: DateTime.now().toString().substring(0, 10),
          adultos: 0,
          menores0a6: 0,
          menores7a12: 0,
          paxAdic: 0,
        );
    _fechaEntrada = TextEditingController(
        text: widget.habitacionSelect != null
            ? widget.habitacionSelect?.fechaCheckIn ??
                DateTime.now().toString().substring(0, 10)
            : DateTime.now().toString().substring(0, 10));
    _fechaSalida = TextEditingController(
        text: widget.habitacionSelect != null
            ? widget.habitacionSelect?.fechaCheckOut ??
                DateTime.now()
                    .add(const Duration(days: 1))
                    .toString()
                    .substring(0, 10)
            : DateTime.now()
                .add(const Duration(days: 1))
                .toString()
                .substring(0, 10));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: TextStyles.titleText(
                  text: "Nueva Habitación",
                  color: Theme.of(context).dividerColor,
                )),
            const SizedBox(height: 15),
            Form(
              key: _formKeyHabitacion,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    runSpacing: 20,
                    spacing: 10,
                    children: [
                      Wrap(
                        runSpacing: 10,
                        spacing: 20,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          SizedBox(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextStyles.standardText(
                                  text: "Categoría: ",
                                  overClip: true,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 10),
                                CustomDropdown.dropdownMenuCustom(
                                  initialSelection:
                                      widget.habitacionSelect != null
                                          ? widget.habitacionSelect!.categoria!
                                          : categorias.first,
                                  onSelected: (String? value) {
                                    nuevaHabitacion.categoria = value!;
                                  },
                                  elements: categorias,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 320,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextStyles.standardText(
                                  text: "Plan: ",
                                  overClip: true,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 10),
                                CustomDropdown.dropdownMenuCustom(
                                    initialSelection:
                                        widget.habitacionSelect != null
                                            ? widget.habitacionSelect!.plan!
                                            : planes.first,
                                    onSelected: (String? value) {
                                      nuevaHabitacion.plan = value!;
                                    },
                                    elements: planes,
                                    removeItem: "PLAN SIN ALIMENTOS",
                                    screenWidth: 550),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth > 1520 ? 560 : null,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormFieldCustom
                                  .textFormFieldwithBorderCalendar(
                                name: "Fecha de entrada",
                                msgError: "Campo requerido*",
                                fechaLimite: DateTime.now()
                                    .subtract(const Duration(days: 1))
                                    .toIso8601String()
                                    .substring(0, 10),
                                dateController: _fechaEntrada,
                                onChanged: () => setState(
                                  () {
                                    _fechaSalida.text =
                                        Utility.getNextDay(_fechaEntrada.text);
                                    setState(() => changedDate = true);
                                    Future.delayed(
                                        Durations.medium1,
                                        () => setState(
                                            () => changedDate = false));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormFieldCustom
                                  .textFormFieldwithBorderCalendar(
                                name: "Fecha de salida",
                                msgError: "Campo requerido*",
                                dateController: _fechaSalida,
                                fechaLimite: _fechaEntrada.text,
                                onChanged: () {
                                  setState(() => changedDate = true);
                                  Future.delayed(
                                      Durations.medium1,
                                      () =>
                                          setState(() => changedDate = false));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: screenWidth > 500 ? 500 : null,
                    child: Table(
                      children: [
                        TableRow(children: [
                          TextStyles.standardText(
                              text: "Adultos",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor),
                          TextStyles.standardText(
                              text: "Menores 0-6",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor),
                          TextStyles.standardText(
                              text: "Menores 7-12",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor),
                        ]),
                        TableRow(children: [
                          NumberInputWithIncrementDecrement(
                            onChanged: (p0) {
                              nuevaHabitacion.adultos = int.tryParse(p0);
                            },
                            initialValue:
                                widget.habitacionSelect?.adultos!.toString(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: NumberInputWithIncrementDecrement(
                              onChanged: (p0) {
                                nuevaHabitacion.menores0a6 = int.tryParse(p0);
                              },
                              initialValue: widget.habitacionSelect?.menores0a6!
                                  .toString(),
                            ),
                          ),
                          NumberInputWithIncrementDecrement(
                            onChanged: (p0) {
                              nuevaHabitacion.menores7a12 = int.tryParse(p0);
                            },
                            initialValue: widget.habitacionSelect?.menores7a12!
                                .toString(),
                          )
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 16,
                      child: isError
                          ? TextStyles.errorText(
                              text:
                                  "Se requiere de al menos un adulto para generar la reservación",
                              size: 12)
                          : null),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextStyles.titleText(
                  text: "Tarifas por dia",
                  color: Theme.of(context).primaryColor,
                ),
                CustomWidgets.sectionButton(_selectedMode, modesVisual),
              ],
            ),
            const Divider(),
            if (!changedDate)
              SizedBox(
                child: DiasList(
                  initDay: _fechaEntrada.text,
                  lastDay: _fechaSalida.text,
                ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 200,
                height: 40,
                child: Buttons.commonButton(
                    onPressed: () {
                      widget.cancelarFunction!.call();
                    },
                    text: "Cancelar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
