import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dias_list.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../providers/tarifario_provider.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/dynamic_widget.dart';
import '../../widgets/number_input_with_increment_decrement.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class HabitacionForm extends ConsumerStatefulWidget {
  const HabitacionForm(
      {super.key,
      required this.cancelarFunction,
      this.habitacionSelect,
      required this.sideController});

  final void Function()? cancelarFunction;
  final Habitacion? habitacionSelect;
  final SidebarXController sideController;

  @override
  _HabitacionFormState createState() => _HabitacionFormState();
}

class _HabitacionFormState extends ConsumerState<HabitacionForm> {
  Habitacion nuevaHabitacion = Habitacion();
  final _formKeyHabitacion = GlobalKey<FormState>();
  TextEditingController _fechaEntrada = TextEditingController();
  TextEditingController _fechaSalida = TextEditingController();
  bool isError = false;
  bool changedDate = false;
  bool startflow = false;
  bool showSaveButton = false;
  List<Widget> modesVisualRange = <Widget>[
    const Icon(Icons.table_chart),
    const Icon(Icons.dehaze_sharp),
  ];
  double target = 1;

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
    double screenHeight = MediaQuery.of(context).size.height;
    final tarifaProvider = ref.watch(allTarifaProvider(""));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomWidgets.titleFormPage(
                onPressedBack: () {
                  if (target == 1) {
                    setState(() => target = 0);

                    Future.delayed(
                        500.ms, () => widget.sideController.selectIndex(1));
                  }
                },
                context: context,
                title: "Nueva Habitación",
                onPressedSaveButton: () {},
              ),
              tarifaProvider.when(
                data: (list) {
                  if (!startflow && list.isEmpty) {
                    Future.delayed(
                      600.ms,
                      () {
                        showSnackBar(
                            context: context,
                            title: "Tarifario no configurado",
                            message:
                                "Aun no se cuenta con tarifas predefinidas en el sistema. Consulte con el administrador.",
                            type: "danger");
                      },
                    );
                    startflow = true;
                  }
                  

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Center(
                        child: Card(
                          elevation: 7,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 45, 25, 35),
                            child: Form(
                              key: _formKeyHabitacion,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 20,
                                    runSpacing: 15,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      TextStyles.standardText(
                                        text: "Categoría:",
                                        overClip: true,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        child:
                                            CustomDropdown.dropdownMenuCustom(
                                          initialSelection:
                                              widget.habitacionSelect != null
                                                  ? widget.habitacionSelect!
                                                      .categoria!
                                                  : tipoHabitacion.first,
                                          onSelected: (String? value) {
                                            nuevaHabitacion.categoria = value!;
                                          },
                                          elements: tipoHabitacion,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Wrap(
                                    spacing: 20,
                                    runSpacing: 15,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: TextStyles.standardText(
                                          text: "Fechas de ocupación:",
                                          overClip: true,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth > 1120 ? 500 : null,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormFieldCustom
                                                  .textFormFieldwithBorderCalendar(
                                                name: "Fecha de entrada",
                                                msgError: "Campo requerido*",
                                                fechaLimite: DateTime.now()
                                                    .subtract(
                                                        const Duration(days: 1))
                                                    .toIso8601String()
                                                    .substring(0, 10),
                                                dateController: _fechaEntrada,
                                                onChanged: () {
                                                  setState(() {
                                                    _fechaSalida.text =
                                                        Utility.getNextDay(
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
                                            const SizedBox(
                                              child:
                                                  Icon(CupertinoIcons.ellipsis),
                                            ),
                                            Expanded(
                                              child: TextFormFieldCustom
                                                  .textFormFieldwithBorderCalendar(
                                                name: "Fecha de salida",
                                                msgError: "Campo requerido*",
                                                dateController: _fechaSalida,
                                                fechaLimite: _fechaEntrada.text,
                                                onChanged: () {
                                                  setState(
                                                      () => changedDate = true);
                                                  Future.delayed(
                                                      Durations.medium1,
                                                      () => setState(() =>
                                                          changedDate = false));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      TextStyles.standardText(
                                        text: "Número de huespedes:",
                                        overClip: true,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: screenWidth > 500 ? 500 : null,
                                        child: Table(
                                          children: [
                                            TableRow(children: [
                                              TextStyles.standardText(
                                                  text: "Adultos",
                                                  aling: TextAlign.center,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              TextStyles.standardText(
                                                  text: "Menores 0-6",
                                                  aling: TextAlign.center,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              TextStyles.standardText(
                                                  text: "Menores 7-12",
                                                  aling: TextAlign.center,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ]),
                                            TableRow(children: [
                                              NumberInputWithIncrementDecrement(
                                                onChanged: (p0) {
                                                  nuevaHabitacion.adultos =
                                                      int.tryParse(p0);
                                                },
                                                initialValue: widget
                                                    .habitacionSelect?.adultos!
                                                    .toString(),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child:
                                                    NumberInputWithIncrementDecrement(
                                                  onChanged: (p0) {
                                                    nuevaHabitacion.menores0a6 =
                                                        int.tryParse(p0);
                                                  },
                                                  initialValue: widget
                                                      .habitacionSelect
                                                      ?.menores0a6!
                                                      .toString(),
                                                ),
                                              ),
                                              NumberInputWithIncrementDecrement(
                                                onChanged: (p0) {
                                                  nuevaHabitacion.menores7a12 =
                                                      int.tryParse(p0);
                                                },
                                                initialValue: widget
                                                    .habitacionSelect
                                                    ?.menores7a12!
                                                    .toString(),
                                              )
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextStyles.titleText(
                            text: "Tarifas por dia",
                            color: Theme.of(context).primaryColor,
                          ),
                          CustomWidgets.sectionButton(
                            listModes: Utility.revisedLimitDateTime(
                                    DateTime.parse(_fechaEntrada.text),
                                    DateTime.parse(_fechaSalida.text))
                                ? selectedMode
                                : _selectedModeRange,
                            modesVisual: Utility.revisedLimitDateTime(
                                    DateTime.parse(_fechaEntrada.text),
                                    DateTime.parse(_fechaSalida.text))
                                ? modesVisual
                                : modesVisualRange,
                            onChanged: (p0, p1) {
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
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: SizedBox(
                      //     width: 200,
                      //     height: 40,
                      //     child: Buttons.commonButton(
                      //         onPressed: () {
                      //           widget.cancelarFunction!.call();
                      //         },
                      //         text: "Cancelar"),
                      //   ),
                      // ),
                    ],
                  ).animate(target: target).fadeIn(duration: 500.ms);
                },
                error: (error, stackTrace) => SizedBox(
                    height: 150,
                    child: CustomWidgets.messageNotResult(
                        context: context,
                        sizeImage: 100,
                        screenWidth: screenWidth,
                        extended: widget.sideController.extended)),
                loading: () => dynamicWidget.loadingWidget(screenWidth,
                    screenHeight * 0.2, widget.sideController.extended),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
