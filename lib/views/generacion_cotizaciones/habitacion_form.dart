import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dias_list.dart';
import 'package:generador_formato/widgets/controller_cotizacion_widget.dart';
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
      required this.sideController});

  final void Function()? cancelarFunction;
  final SidebarXController sideController;

  @override
  _HabitacionFormState createState() => _HabitacionFormState();
}

class _HabitacionFormState extends ConsumerState<HabitacionForm> {
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
  int totalHuespedes = 1;

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
    final habitacionProvider = ref.watch(habitacionSelectProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomWidgets.titleFormPage(
                      context: context,
                      title: "Nueva Habitación",
                      onPressedSaveButton: () {},
                      showSaveButton: showSaveButton,
                      onPressedBack: () {
                        if (target == 1) {
                          setState(() => target = 0);

                          Future.delayed(500.ms,
                              () => widget.sideController.selectIndex(1));
                        }
                      },
                    ),
                    tarifaProvider.when(
                      data: (list) {
                        if (!startflow) {
                          if (list.isEmpty) {
                            Future.delayed(
                              600.ms,
                              () => showSnackBar(
                                  context: context,
                                  title: "Tarifario no configurado",
                                  message:
                                      "Aun no se cuenta con tarifas predefinidas en el sistema. Consulte con el administrador.",
                                  type: "danger"),
                            );
                          }
                          Future.delayed(250.ms,
                              () => setState(() => showSaveButton = true));

                          _fechaEntrada = TextEditingController(
                              text: habitacionProvider.fechaCheckIn ??
                                  DateTime.now().toString().substring(0, 10));
                          _fechaSalida = TextEditingController(
                              text: habitacionProvider.fechaCheckOut ??
                                  DateTime.now()
                                      .add(const Duration(days: 1))
                                      .toString()
                                      .substring(0, 10));

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
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 45, 25, 35),
                                  child: Form(
                                    key: _formKeyHabitacion,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              child: CustomDropdown
                                                  .dropdownMenuCustom(
                                                initialSelection:
                                                    habitacionProvider
                                                            .categoria ??
                                                        tipoHabitacion.first,
                                                onSelected: (String? value) {
                                                  habitacionProvider.categoria =
                                                      value!;
                                                  setState(() {});
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: TextStyles.standardText(
                                                text: "Fechas de ocupación:",
                                                overClip: true,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth > 1120
                                                  ? 500
                                                  : null,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormFieldCustom
                                                        .textFormFieldwithBorderCalendar(
                                                      name: "Fecha de entrada",
                                                      msgError:
                                                          "Campo requerido*",
                                                      fechaLimite: DateTime
                                                              .now()
                                                          .subtract(
                                                              const Duration(
                                                                  days: 1))
                                                          .toIso8601String()
                                                          .substring(0, 10),
                                                      dateController:
                                                          _fechaEntrada,
                                                      onChanged: () {
                                                        setState(() {
                                                          _fechaSalida.text =
                                                              Utility.getNextDay(
                                                                  _fechaEntrada
                                                                      .text);
                                                          changedDate = true;
                                                        });
                                                        Future.delayed(
                                                          Durations.medium1,
                                                          () => setState(
                                                            () {
                                                              changedDate =
                                                                  false;
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    child: Icon(CupertinoIcons
                                                        .ellipsis),
                                                  ),
                                                  Expanded(
                                                    child: TextFormFieldCustom
                                                        .textFormFieldwithBorderCalendar(
                                                      name: "Fecha de salida",
                                                      msgError:
                                                          "Campo requerido*",
                                                      dateController:
                                                          _fechaSalida,
                                                      fechaLimite:
                                                          _fechaEntrada.text,
                                                      onChanged: () {
                                                        setState(() =>
                                                            changedDate = true);
                                                        Future.delayed(
                                                            Durations.medium1,
                                                            () => setState(() =>
                                                                changedDate =
                                                                    false));
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              width: screenWidth > 500
                                                  ? 500
                                                  : null,
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
                                                        habitacionProvider
                                                                .adultos =
                                                            int.tryParse(p0);
                                                        setState(() {});
                                                      },
                                                      initialValue:
                                                          habitacionProvider
                                                              .adultos!
                                                              .toString(),
                                                      minimalValue: 1,
                                                      maxValue: 4 -
                                                          habitacionProvider
                                                              .menores0a6! -
                                                          habitacionProvider
                                                              .menores7a12!,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: AbsorbPointer(
                                                        absorbing: revisedLimitPax(
                                                            habitacionProvider,
                                                            habitacionProvider
                                                                .menores7a12!),
                                                        child: Opacity(
                                                          opacity: revisedLimitPax(
                                                                  habitacionProvider,
                                                                  habitacionProvider
                                                                      .menores7a12!)
                                                              ? 0.5
                                                              : 1,
                                                          child:
                                                              NumberInputWithIncrementDecrement(
                                                            onChanged: (p0) {
                                                              habitacionProvider
                                                                      .menores0a6 =
                                                                  int.tryParse(
                                                                      p0);
                                                              setState(() {});
                                                            },
                                                            initialValue:
                                                                habitacionProvider
                                                                    .menores0a6!
                                                                    .toString(),
                                                            maxValue: 4 -
                                                                habitacionProvider
                                                                    .adultos! -
                                                                habitacionProvider
                                                                    .menores7a12!,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    AbsorbPointer(
                                                      absorbing: revisedLimitPax(
                                                          habitacionProvider,
                                                          habitacionProvider
                                                              .menores0a6!),
                                                      child: Opacity(
                                                        opacity: revisedLimitPax(
                                                                habitacionProvider,
                                                                habitacionProvider
                                                                    .menores0a6!)
                                                            ? 0.5
                                                            : 1,
                                                        child:
                                                            NumberInputWithIncrementDecrement(
                                                          onChanged: (p0) {
                                                            habitacionProvider
                                                                    .menores7a12 =
                                                                int.tryParse(
                                                                    p0);
                                                            setState(() {});
                                                          },
                                                          initialValue:
                                                              habitacionProvider
                                                                  .menores7a12!
                                                                  .toString(),
                                                          maxValue: 4 -
                                                              habitacionProvider
                                                                  .menores0a6! -
                                                              habitacionProvider
                                                                  .adultos!,
                                                        ),
                                                      ),
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
                                  tarifas: list,
                                ),
                              ),
                            const SizedBox(height: 15),
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
                      loading: () => SizedBox(
                        height: screenHeight * 0.75,
                        child: dynamicWidget.loadingWidget(
                          screenWidth,
                          screenHeight * 0.2,
                          widget.sideController.extended,
                          isEstandar: true,
                          message: TextStyles.standardText(
                              text: "Cargando tarifas",
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            tarifaProvider.when(
              data: (list) {
                return CalculateSummaryControllerWidget(
                  calculateRoom: true,
                  totalAdulto: Utility.calculateTariffRoom(
                    habitacion: habitacionProvider,
                    initDay: _fechaEntrada.text,
                    lastDay: _fechaSalida.text,
                    regitros: list,
                    onlyAdults: true,
                    withFormat: false,
                    withDiscount: false,
                  ),
                  totalMenores: Utility.calculateTariffRoom(
                    habitacion: habitacionProvider,
                    initDay: _fechaEntrada.text,
                    lastDay: _fechaSalida.text,
                    regitros: list,
                    onlyChildren: true,
                    withFormat: false,
                    withDiscount: false,
                  ),
                  total: Utility.calculateTariffRoom(
                    habitacion: habitacionProvider,
                    initDay: _fechaEntrada.text,
                    lastDay: _fechaSalida.text,
                    regitros: list,
                    withFormat: false,
                  ),
                  totalReal: Utility.calculateTariffRoom(
                    habitacion: habitacionProvider,
                    initDay: _fechaEntrada.text,
                    lastDay: _fechaSalida.text,
                    regitros: list,
                    withFormat: false,
                    withDiscount: false,
                  ),
                  descuento: Utility.calculateTariffRoom(
                    habitacion: habitacionProvider,
                    initDay: _fechaEntrada.text,
                    lastDay: _fechaSalida.text,
                    regitros: list,
                    onlyDiscount: true,
                    withFormat: false,
                    withDiscount: false,
                  ),
                ).animate(target: target).fadeIn(duration: 500.ms);
              },
              error: (error, stackTrace) => const SizedBox(),
              loading: () => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  bool revisedLimitPax(Habitacion habitacionProvider, int cantidad) {
    if (habitacionProvider.adultos == 4) {
      return true;
    }

    if ((habitacionProvider.adultos! + cantidad) >= 4) {
      return true;
    }

    return false;
  }
}
