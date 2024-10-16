import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dias_list.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:generador_formato/widgets/summary_controller_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../models/registro_tarifa_model.dart';
import '../../providers/tarifario_provider.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/dynamic_widget.dart';
import '../../widgets/manager_tariff_day_widget.dart';
import '../../widgets/number_input_with_increment_decrement.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class HabitacionForm extends ConsumerStatefulWidget {
  const HabitacionForm({
    super.key,
    required this.sideController,
  });

  final SidebarXController sideController;

  @override
  _HabitacionFormState createState() => _HabitacionFormState();
}

class _HabitacionFormState extends ConsumerState<HabitacionForm> {
  final _formKeyHabitacion = GlobalKey<FormState>();
  TextEditingController _fechaEntrada = TextEditingController();
  TextEditingController _fechaSalida = TextEditingController();
  bool changedDate = false;
  bool startflow = false;
  bool showSaveButton = false;
  List<Widget> modesVisualRange = <Widget>[
    const Icon(Icons.table_chart),
    const Icon(Icons.dehaze_sharp),
  ];
  double target = 1;
  bool isEditing = false;
  bool applyFreeTariff = false;
  TarifaXDia tarifaLibre = TarifaXDia(
    color: DesktopColors.turquezaOscure,
    descuentoProvisional: 0,
    code: "tariffFree",
    nombreTarif: "Tarifa Libre",
  );

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
    final tarifasProvisionalesProvider =
        ref.watch(TarifasProvisionalesProvider.provider);
    final descuentoProvider = ref.watch(descuentoProvisionalProvider);

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
                      title:
                          isEditing ? "Editar Habitación" : "Nueva Habitación",
                      showSaveButton: false,
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
                          isEditing = habitacionProvider.tarifaXDia!.isNotEmpty;
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

                          getTarifasSelect(list, habitacionProvider,
                              tarifasProvisionalesProvider, descuentoProvider);

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
                                                  getTarifasSelect(
                                                      list,
                                                      habitacionProvider,
                                                      tarifasProvisionalesProvider,
                                                      descuentoProvider,
                                                      onlyCategory: true);
                                                  setState(() {});
                                                },
                                                elements: tipoHabitacion,
                                                screenWidth: screenWidth > 800
                                                    ? (screenWidth +
                                                            (widget.sideController
                                                                    .extended
                                                                ? 0
                                                                : 250)) *
                                                        0.26
                                                    : 295,
                                                calculateWidth: false,
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
                                                      compact: (screenWidth <
                                                                  1000 &&
                                                              widget
                                                                  .sideController
                                                                  .extended) ||
                                                          (screenWidth < 900 &&
                                                              !widget
                                                                  .sideController
                                                                  .extended),
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

                                                        habitacionProvider
                                                                .fechaCheckIn =
                                                            _fechaEntrada.text;
                                                        habitacionProvider
                                                                .fechaCheckOut =
                                                            _fechaSalida.text;

                                                        getTarifasSelect(
                                                          list,
                                                          habitacionProvider,
                                                          tarifasProvisionalesProvider,
                                                          descuentoProvider,
                                                          refreshTariff:
                                                              isEditing,
                                                        );
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
                                                      compact: (screenWidth <
                                                                  1000 &&
                                                              widget
                                                                  .sideController
                                                                  .extended) ||
                                                          (screenWidth < 900 &&
                                                              !widget
                                                                  .sideController
                                                                  .extended),
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
                                                        habitacionProvider
                                                                .fechaCheckOut =
                                                            _fechaSalida.text;
                                                        getTarifasSelect(
                                                          list,
                                                          habitacionProvider,
                                                          tarifasProvisionalesProvider,
                                                          descuentoProvider,
                                                          refreshTariff:
                                                              isEditing,
                                                        );
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
                                                      onChanged: (p0) =>
                                                          setState(() =>
                                                              habitacionProvider
                                                                      .adultos =
                                                                  int.tryParse(
                                                                      p0)),
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
                                                            onChanged: (p0) => setState(() =>
                                                                habitacionProvider
                                                                        .menores0a6 =
                                                                    int.tryParse(
                                                                        p0)),
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
                                                          onChanged: (p0) => setState(() =>
                                                              habitacionProvider
                                                                      .menores7a12 =
                                                                  int.tryParse(
                                                                      p0)),
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
                                Expanded(
                                  child: TextStyles.titleText(
                                    text: "Tarifas por dia",
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: SizedBox(
                                    height: 35,
                                    child: FormWidgets.inputSwitch(
                                      name: "Tarifa Libre",
                                      value: applyFreeTariff,
                                      activeColor: DesktopColors.cerulean,
                                      context: context,
                                      compact: (screenWidth < 950 &&
                                              widget.sideController.extended) ||
                                          (screenWidth < 850 &&
                                              !widget.sideController.extended),
                                      onChanged: (p0) {
                                        setState(() => applyFreeTariff = p0);
                                        if (applyFreeTariff) {
                                          tarifaLibre.categoria =
                                              habitacionProvider.categoria;
                                          tarifaLibre.tarifa = null;
                                          tarifaLibre.descuentoProvisional = 0;

                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ManagerTariffDayWidget(
                                              tarifaXDia: tarifaLibre,
                                              isAppling: true,
                                            ),
                                          ).then(
                                            (value) {
                                              if (value != null) {
                                                getTarifasSelect(
                                                  list,
                                                  habitacionProvider,
                                                  tarifasProvisionalesProvider,
                                                  descuentoProvider,
                                                  refreshTariff: isEditing,
                                                );
                                              } else {
                                                setState(() =>
                                                    applyFreeTariff = false);
                                              }
                                            },
                                          );
                                        } else {
                                          getTarifasSelect(
                                            list,
                                            habitacionProvider,
                                            tarifasProvisionalesProvider,
                                            descuentoProvider,
                                            refreshTariff: isEditing,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: CustomWidgets.sectionButton(
                                    isCompact: (screenWidth < 925 &&
                                        widget.sideController.extended),
                                    listModes: (Utility.revisedLimitDateTime(
                                              DateTime.parse(
                                                  _fechaEntrada.text),
                                              DateTime.parse(_fechaSalida.text),
                                            ) &&
                                            defineUseScreenWidth(screenWidth))
                                        ? selectedMode
                                        : _selectedModeRange,
                                    modesVisual: (Utility.revisedLimitDateTime(
                                              DateTime.parse(
                                                  _fechaEntrada.text),
                                              DateTime.parse(_fechaSalida.text),
                                            ) &&
                                            defineUseScreenWidth(screenWidth))
                                        ? modesVisual
                                        : modesVisualRange,
                                    onChanged: (p0, p1) => setState(
                                        () => selectedMode[p0] = p0 == p1),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            if (!changedDate)
                              SizedBox(
                                child: DiasList(
                                  initDay: _fechaEntrada.text,
                                  lastDay: _fechaSalida.text,
                                  isCalendary: (Utility.revisedLimitDateTime(
                                            DateTime.parse(_fechaEntrada.text),
                                            DateTime.parse(_fechaSalida.text),
                                          ) &&
                                          defineUseScreenWidth(screenWidth))
                                      ? selectedMode.first
                                      : false,
                                  isTable: (Utility.revisedLimitDateTime(
                                            DateTime.parse(_fechaEntrada.text),
                                            DateTime.parse(_fechaSalida.text),
                                          ) &&
                                          defineUseScreenWidth(screenWidth))
                                      ? selectedMode[1]
                                      : _selectedModeRange[0],
                                  isCheckList: (Utility.revisedLimitDateTime(
                                            DateTime.parse(_fechaEntrada.text),
                                            DateTime.parse(_fechaSalida.text),
                                          ) &&
                                          defineUseScreenWidth(screenWidth))
                                      ? selectedMode[2]
                                      : _selectedModeRange[1],
                                  sideController: widget.sideController,
                                ),
                              ),
                            const SizedBox(height: 15),
                          ],
                        ).animate(target: target).fadeIn(duration: 400.ms);
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
                return SummaryControllerWidget(
                  calculateRoom: true,
                  numDays: DateTime.parse(_fechaSalida.text)
                      .difference(DateTime.parse(_fechaEntrada.text))
                      .inDays,
                  onPressed: () {
                    final habitacionesProvider = HabitacionProvider.provider;

                    if (!isEditing) {
                      habitacionProvider.folioHabitacion = UniqueKey()
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '');
                    }

                    if (isEditing) {
                      ref.read(habitacionesProvider.notifier).editItem(
                          habitacionProvider.folioHabitacion,
                          habitacionProvider);
                    } else {
                      ref
                          .read(habitacionesProvider.notifier)
                          .addItem(habitacionProvider);
                    }

                    if (target == 1) {
                      setState(() => target = 0);

                      Future.delayed(
                          500.ms, () => widget.sideController.selectIndex(1));
                    }
                  },
                ).animate(target: target).fadeIn(duration: 800.ms);
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
    if (habitacionProvider.adultos == 4) return true;
    if ((habitacionProvider.adultos! + cantidad) >= 4) return true;

    return false;
  }

  bool defineUseScreenWidth(double screenWidth) {
    bool enable = false;

    if (widget.sideController.extended) {
      enable = screenWidth > 1115;
    } else {
      enable = screenWidth > 950;
    }

    return enable;
  }

  void getTarifasSelect(
    List<RegistroTarifa> list,
    Habitacion habitacion,
    List<TarifaData> tarifasProvisionales,
    double descuentoProvisional, {
    bool onlyCategory = false,
    bool refreshTariff = false,
  }) {
    if (onlyCategory) {
      for (var tariffDay in habitacion.tarifaXDia!) {
        tariffDay.categoria = habitacion.categoria;
        if (tariffDay.tarifas != null) {
          if (tariffDay.tarifa != null) {
            tariffDay.tarifas!.removeWhere(
                (element) => element.categoria == tariffDay.tarifa!.categoria);
            tariffDay.tarifas!.add(tariffDay.tarifa!);
          }

          tariffDay.tarifa = tariffDay.tarifas!
              .where((element) => element.categoria == habitacion.categoria)
              .firstOrNull;
        } else {
          tariffDay.tarifas = [];
          if (tariffDay.tarifa != null) {
            tariffDay.tarifas!.add(tariffDay.tarifa!);
          }
          tariffDay.tarifa = null;
        }
      }
    } else {
      if (isEditing && !refreshTariff) return;

      habitacion.tarifaXDia!.clear();

      int days = DateTime.parse(_fechaSalida.text)
          .difference(DateTime.parse(_fechaEntrada.text))
          .inDays;
      for (var ink = 0; ink < days; ink++) {
        DateTime dateNow =
            DateTime.parse(_fechaEntrada.text).add(Duration(days: ink));

        RegistroTarifa? newTariff = Utility.revisedTariffDay(dateNow, list);

        if (applyFreeTariff) {
          TarifaXDia newTarifaLibre = tarifaLibre.copyWith();
          newTarifaLibre.dia = ink;
          newTarifaLibre.fecha = dateNow;
          habitacion.tarifaXDia!.add(newTarifaLibre);
          continue;
        }

        if (newTariff == null) {
          TarifaXDia tarifaNoDefinida = TarifaXDia();
          tarifaNoDefinida = TarifaXDia(
            dia: ink,
            fecha: dateNow,
            nombreTarif: "No definido",
            code: "Unknow",
            categoria: habitacion.categoria,
            descuentoProvisional:
                (tarifasProvisionales.isEmpty) ? 0 : descuentoProvisional,
            tarifas:
                (tarifasProvisionales.isEmpty) ? null : tarifasProvisionales,
            tarifa: (tarifasProvisionales.isEmpty)
                ? null
                : (tarifasProvisionales
                    .where(
                        (element) => element.categoria == habitacion.categoria)
                    .firstOrNull),
          );

          habitacion.tarifaXDia!.add(tarifaNoDefinida);
          continue;
        }

        habitacion.tarifaXDia!.add(
          TarifaXDia(
            dia: ink,
            fecha: dateNow,
            color: newTariff.color,
            nombreTarif: newTariff.nombre,
            code: newTariff.code,
            id: newTariff.id,
            periodo: Utility.getPeriodNow(dateNow, newTariff.periodos),
            tarifa: newTariff.tarifas!.firstWhere(
                (element) => element.categoria == habitacion.categoria),
            temporadaSelect: Utility.getSeasonNow(newTariff, days),
            temporadas: newTariff.temporadas,
            tarifas: newTariff.tarifas,
          ),
        );
      }
    }
  }
}
