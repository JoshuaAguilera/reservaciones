import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  List<Widget> modesVisualRange = <Widget>[
    const Icon(Icons.table_chart),
    const Icon(Icons.dehaze_sharp),
  ];
  bool _showFrontSide = false;
  bool _flipXAxis = false;

  final List<bool> _selectedModeRange = <bool>[
    true,
    false,
  ];

  final List<bool> selectedMode = <bool>[
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
    _showFrontSide = true;
    _flipXAxis = true;
    super.initState();
  }

  @override
  void dispose() {
    _fechaEntrada.dispose();
    _fechaSalida.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
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
                                    initialSelection: widget.habitacionSelect !=
                                            null
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
                                  onChanged: () {
                                    setState(() {
                                      _fechaSalida.text = Utility.getNextDay(
                                          _fechaEntrada.text);
                                      changedDate = true;
                                    });
                                    Future.delayed(
                                      Durations.medium1,
                                      () => setState(
                                        () {
                                          changedDate = false;
                                        },
                                      ),
                                    );
                                  },
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
                                        () => setState(
                                            () => changedDate = false));
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
                                initialValue: widget
                                    .habitacionSelect?.menores0a6!
                                    .toString(),
                              ),
                            ),
                            NumberInputWithIncrementDecrement(
                              onChanged: (p0) {
                                nuevaHabitacion.menores7a12 = int.tryParse(p0);
                              },
                              initialValue: widget
                                  .habitacionSelect?.menores7a12!
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
                          : null,
                    ),
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
                  CustomWidgets.sectionButton(
                    Utility.revisedLimitDateTime(
                            DateTime.parse(_fechaEntrada.text),
                            DateTime.parse(_fechaSalida.text))
                        ? selectedMode
                        : _selectedModeRange,
                    Utility.revisedLimitDateTime(
                            DateTime.parse(_fechaEntrada.text),
                            DateTime.parse(_fechaSalida.text))
                        ? modesVisual
                        : modesVisualRange,
                    (p0, p1) {
                      selectedMode[p0] = p0 == p1;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const Divider(),
              if (!changedDate)
                SizedBox(
                  child: DiasList(
                    initDay: _fechaEntrada.text,
                    lastDay: _fechaSalida.text,
                    isCalendary: selectedMode.first,
                    isTable: selectedMode[1],
                    isCheckList: selectedMode[2],
                  ),
                ),
              const SizedBox(height: 15),
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
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints.tight(Size.square(200.0)),
                  child: _buildFlipAnimation(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFrontSide ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Colors.blue,
      faceName: "Front",
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
          child: FlutterLogo(),
        ),
      ),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: Colors.blue.shade700,
      faceName: "Rear",
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
          child:
              Center(child: Text("Flutter", style: TextStyle(fontSize: 50.0))),
        ),
      ),
    );
  }

  Widget __buildLayout(
      {required Key key, required Widget child, required String faceName, required Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(faceName.substring(0, 1), style: TextStyle(fontSize: 80.0)),
      ),
    );
    // return Container(
    //   key: key,
    //   decoration: BoxDecoration(
    //     color: backgroundColor,
    //     borderRadius: BorderRadius.circular(12.0),
    //   ),
    //   child: Stack(
    //     fit: StackFit.expand,
    //     children: [
    //       child,
    //       Positioned(
    //         bottom: 8.0,
    //         right: 8.0,
    //         child: Text(faceName),
    //       ),
    //     ],
    //   ),
    // );
  }
}
