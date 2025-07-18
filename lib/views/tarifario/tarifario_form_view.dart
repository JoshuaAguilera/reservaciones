import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/res/helpers/date_helpers.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import 'package:generador_formato/models/periodo_model.dart';
import 'package:generador_formato/models/tarifa_base_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/view-models/providers/tarifario_provider.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:generador_formato/res/ui/show_snackbar.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

import 'package:generador_formato/views/tarifario/dialogs/period_calendar_dialog.dart';
import 'package:generador_formato/utils/widgets/form_tariff_widget.dart';
import 'package:generador_formato/utils/widgets/item_rows.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/tarifa_rack_model.dart';
import '../../res/helpers/calculator_helpers.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/helpers/constants.dart';
import '../../res/helpers/utility.dart';
import '../../utils/shared_preferences/settings.dart';
import '../../utils/widgets/custom_dropdown.dart';
import '../../utils/widgets/form_widgets.dart';
import '../../res/ui/text_styles.dart';
import '../../utils/widgets/textformfield_custom.dart';

class TarifarioFormView extends ConsumerStatefulWidget {
  const TarifarioFormView({Key? key, required this.sideController})
      : super(key: key);

  final SidebarXController sideController;

  @override
  _FormTarifarioViewState createState() => _FormTarifarioViewState();
}

class _FormTarifarioViewState extends ConsumerState<TarifarioFormView> {
  final _formKeyTarifa = GlobalKey<FormState>();
  String type = tipoHabitacion.first;
  String plan = planes.first;
  bool inAllPeriod = false;
  bool autoCalculationVR = true;
  bool autoCalculationVPM = true;
  bool starflow = false;
  double target = 1;
  Color colorTarifa = Colors.amber;
  TarifaRack? oldRegister;
  TextEditingController nombreTarifaController = TextEditingController();
  TextEditingController _fechaEntrada = TextEditingController(text: "");
  TextEditingController _fechaSalida = TextEditingController(text: "");
  String codeTarifa =
      "${UniqueKey()} - ${Preferences.username} - ${Preferences.userIdInt} - ${DateTime.now().toString()}";

  TextEditingController adults1_2VRController = TextEditingController();
  TextEditingController adults3VRController = TextEditingController(text: "0");
  TextEditingController adults4VRController = TextEditingController(text: "0");
  TextEditingController paxAdicVRController = TextEditingController();
  TextEditingController minors7_12VRController = TextEditingController();
  TextEditingController adults1_2VPMController = TextEditingController();
  TextEditingController adults3VPMController = TextEditingController(text: "0");
  TextEditingController adults4VPMController = TextEditingController(text: "0");
  TextEditingController paxAdicVPMController = TextEditingController();
  TextEditingController minors7_12VPMController = TextEditingController();
  bool initiallyExpanded = false;

  //New Version Form v2
  List<Periodo> periodos = [];
  final List<bool> selectedDayWeek = <bool>[
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  TarifaBase? selectBaseTariff;
  bool usedBaseTariff = false;
  bool isLoading = false;

  void resetDates() {
    _fechaEntrada =
        TextEditingController(text: DateTime.now().toString().substring(0, 10));
    _fechaSalida = TextEditingController(
        text: DateTime.now()
            .add(const Duration(days: 1))
            .toString()
            .substring(0, 10));
    setState(() {});
  }

  @override
  void initState() {
    resetDates();
    super.initState();
  }

  @override
  void dispose() {
    nombreTarifaController.dispose();
    _fechaEntrada.dispose();
    _fechaSalida.dispose();
    adults1_2VRController.dispose();
    adults3VRController.dispose();
    adults4VRController.dispose();
    paxAdicVRController.dispose();
    minors7_12VRController.dispose();
    adults1_2VPMController.dispose();
    adults3VPMController.dispose();
    adults4VPMController.dispose();
    paxAdicVPMController.dispose();
    minors7_12VPMController.dispose();

    super.dispose();
  }

  bool foundDay(List<String>? list, String day) {
    if (list == null) return false;
    return list.any((element) => element.toLowerCase() == day.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final actualTarifa = ref.watch(editTarifaProvider);
    final temporadaIndListProvider = ref.read(temporadasIndividualesProvider);
    final temporadaGrupListProvider = ref.read(temporadasGrupalesProvider);
    final temporadaEfectivoListProvider = ref.read(temporadasEfectivoProvider);
    final tarifasBase = ref.watch(tarifaBaseProvider(""));

    if (!starflow && actualTarifa.idInt != null) {
      nombreTarifaController.text = actualTarifa.nombre!;
      colorTarifa = actualTarifa.color!;
      initiallyExpanded = true;
      oldRegister = actualTarifa;
      autoCalculationVPM = false;
      autoCalculationVR = false;

      final weekdays = actualTarifa.periodos!.first.diasActivo;

      if (actualTarifa.periodos!.isNotEmpty) {
        selectedDayWeek[0] = foundDay(weekdays, "lunes");
        selectedDayWeek[1] = foundDay(weekdays, "martes");
        selectedDayWeek[2] = foundDay(weekdays, "miercoles");
        selectedDayWeek[3] = foundDay(weekdays, "jueves");
        selectedDayWeek[4] = foundDay(weekdays, "viernes");
        selectedDayWeek[5] = foundDay(weekdays, "sabado");
        selectedDayWeek[6] = foundDay(weekdays, "domingo");
      }

      periodos = Utility.getPeriodsRegister(actualTarifa.periodos);

      Tarifa? tariffRV = actualTarifa.registros?.firstOrNull?.tarifa;

      adults1_2VRController.text = (tariffRV?.tarifaAdulto1a2 ?? 0).toString();
      paxAdicVRController.text = (tariffRV?.tarifaPaxAdicional ?? 0).toString();
      adults3VRController.text = tariffRV?.tarifaAdulto3 != null
          ? tariffRV!.tarifaAdulto3!.toString()
          : CalculatorHelpers.getRate(
              tarifaAdulto: adults1_2VRController.text,
              tarifaPaxAdicional: paxAdicVRController.text,
              numPaxAdic: 1,
            );
      adults4VRController.text = tariffRV?.tarifaAdulto4 != null
          ? tariffRV!.tarifaAdulto4!.toString()
          : CalculatorHelpers.getRate(
              tarifaAdulto: adults1_2VRController.text,
              tarifaPaxAdicional: paxAdicVRController.text,
              numPaxAdic: 2,
            );
      minors7_12VRController.text =
          (tariffRV?.tarifaMenores7a12 ?? 0).toString();

      // TarifaTableData? tariffVPM = actualTarifa.tarifas
      //     ?.where((element) => element.categoria == tipoHabitacion.last)
      //     .firstOrNull;

      // adults1_2VPMController.text =
      //     (tariffVPM?.tarifaAdultoSGLoDBL ?? 0).toString();
      // paxAdicVPMController.text =
      //     (tariffVPM?.tarifaPaxAdicional ?? 0).toString();
      // adults3VPMController.text = tariffVPM?.tarifaAdultoTPL != null
      //     ? tariffVPM!.tarifaAdultoTPL!.toString()
      //     : Utility.calculateRate(
      //         adults1_2VPMController, paxAdicVPMController, 1);
      // adults4VPMController.text = tariffVPM?.tarifaAdultoCPLE != null
      //     ? tariffVPM!.tarifaAdultoCPLE!.toString()
      //     : Utility.calculateRate(
      //         adults1_2VPMController, paxAdicVPMController, 2);
      // minors7_12VPMController.text =
      //     (tariffVPM?.tarifaMenores7a12 ?? 0).toString();

      if (actualTarifa.registros?.firstOrNull?.tarifa?.tarifaBase?.idInt !=
          null) {
        tarifasBase.when(
          data: (data) {
            selectBaseTariff = data
                .where((element) =>
                    element.idInt ==
                    actualTarifa
                        .registros?.firstOrNull?.tarifa?.tarifaBase?.idInt)
                .firstOrNull;

            usedBaseTariff = selectBaseTariff != null;
            setState(() {});
          },
          error: (error, stackTrace) => debugPrint("Not Found Base Tariff"),
          loading: () {},
        );
      }

      starflow = true;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomWidgets.titleFormPage(
                context: context,
                isLoadingButton: isLoading,
                title: actualTarifa.idInt != null
                    ? "Editar tarifa: ${nombreTarifaController.text}"
                    : "Registrar nueva tarifa",
                onPressedBack: () {
                  setState(() => target = 0);

                  Future.delayed(
                      500.ms, () => widget.sideController.selectIndex(4));
                },
                onPressedSaveButton: () async => await savedTariff(
                  temporadaIndListProvider +
                      temporadaGrupListProvider +
                      temporadaEfectivoListProvider,
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKeyTarifa,
                child: SizedBox(
                  width: screenWidth > 1080 ? 1080 : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets.titleSeccion(
                                  context,
                                  title: "Datos generales",
                                  topPadding: 5,
                                ),
                                Wrap(
                                  runSpacing: 15,
                                  spacing: 25,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 500,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: TextFormFieldCustom
                                                .textFormFieldwithBorder(
                                              name: "Nombre de la tarifa Rack",
                                              controller:
                                                  nombreTarifaController,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: FormWidgets.inputColor(
                                              nameInput: "Color:",
                                              primaryColor: colorTarifa,
                                              colorText: Theme.of(context)
                                                  .primaryColor,
                                              onChangedColor: (p0) => setState(
                                                  () => colorTarifa = p0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 485,
                                      child: AbsorbPointer(
                                        absorbing: inAllPeriod,
                                        child: Opacity(
                                          opacity: inAllPeriod ? 0.5 : 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextStyles.standardText(
                                                  text: "Dias de aplicación:",
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              CustomWidgets.sectionButton(
                                                listModes: selectedDayWeek,
                                                modesVisual: [],
                                                onChanged: (p0, p1) {},
                                                isReactive: false,
                                                isCompact: true,
                                                arrayStrings: daysNameShort,
                                                borderRadius: 12,
                                                selectedBorderColor:
                                                    colorTarifa,
                                                selectedColor: Color.fromARGB(
                                                    20,
                                                    colorTarifa.blue,
                                                    colorTarifa.green,
                                                    colorTarifa.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    FormWidgets.inputSwitch(
                                      value: inAllPeriod,
                                      context: context,
                                      activeColor: colorTarifa,
                                      onChanged: (p0) => setState(() {
                                        inAllPeriod = !inAllPeriod;
                                        selectedDayWeek.clear();
                                        selectedDayWeek.addAll([
                                          true,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod
                                        ]);
                                      }),
                                      name: "Aplicar en toda la semana",
                                    ),
                                  ],
                                ),
                                CustomWidgets.titleSeccion(
                                  context,
                                  title: "Periodos",
                                  topPadding: 20,
                                ),
                                Buttons.commonButton(
                                  icons: HeroIcons.calendar_days,
                                  color: DesktopColors.cerulean,
                                  text: "Agregar Periodo",
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          PeriodCalendarDialog(
                                              colorTariff: colorTarifa),
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          Periodo newPeriod = value as Periodo;
                                          _addPeriod(
                                            newPeriod.fechaInicial!.toString(),
                                            newPeriod.fechaFinal!.toString(),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 13),
                                  child: periodos.isEmpty
                                      ? TextStyles.standardText(
                                          text:
                                              "No se han registrado periodos.")
                                      : Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          child: Wrap(
                                            children: [
                                              for (var element in periodos)
                                                ItemRow.filterItemRow(
                                                  colorCard: colorTarifa,
                                                  initDate:
                                                      element.fechaInicial!,
                                                  withOutWidth: true,
                                                  lastDate: element.fechaFinal!,
                                                  onRemove: () {
                                                    periodos.remove(element);
                                                    setState(() {});
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomWidgets.titleSeccion(
                                context,
                                title: "Tarífas",
                                topPadding: 10,
                                child: tarifasBase.when(
                                  data: (data) {
                                    String selectTariff = selectBaseTariff !=
                                            null
                                        ? selectBaseTariff?.nombre ?? 'Ninguna'
                                        : 'Ninguna';
                                    List<String> baseTariffs = ['Ninguna'];

                                    for (var element in data) {
                                      baseTariffs.add(element.nombre ?? '');
                                    }

                                    return Row(
                                      children: [
                                        TextStyles.standardText(
                                            text: "Tarifa Base:  "),
                                        CustomDropdown.dropdownMenuCustom(
                                          compactWidth: 260,
                                          initialSelection: selectTariff,
                                          onSelected: (String? value) {
                                            if (value == selectTariff) return;

                                            selectBaseTariff = data
                                                .where((element) =>
                                                    element.nombre == value)
                                                .toList()
                                                .firstOrNull;
                                            setState(() => {});
                                            if (selectBaseTariff == null) {
                                              usedBaseTariff = false;
                                              adults1_2VRController.text = '';
                                              adults3VRController.text = '';
                                              adults4VRController.text = '';
                                              paxAdicVRController.text = '';
                                              minors7_12VRController.text = '';
                                              adults1_2VPMController.text = '';
                                              adults3VPMController.text = '';
                                              adults4VPMController.text = '';
                                              paxAdicVPMController.text = '';
                                              minors7_12VPMController.text = '';
                                              setState(() {});
                                              return;
                                            }

                                            autoCalculationVPM = false;
                                            autoCalculationVR = false;
                                            usedBaseTariff = true;

                                            Tarifa? firstTariff =
                                                selectBaseTariff?.tarifas
                                                    ?.where((element) =>
                                                        element.categoria ==
                                                        tipoHabitacion.first)
                                                    .toList()
                                                    .firstOrNull;
                                            Tarifa? secondTariff =
                                                selectBaseTariff?.tarifas
                                                    ?.where((element) =>
                                                        element.categoria ==
                                                        tipoHabitacion.last)
                                                    .toList()
                                                    .firstOrNull;

                                            adults1_2VRController.text =
                                                (firstTariff?.tarifaAdulto1a2 ??
                                                        0)
                                                    .toString();

                                            adults3VRController.text =
                                                (firstTariff?.tarifaAdulto3 ??
                                                        0)
                                                    .toString();

                                            adults4VRController.text =
                                                (firstTariff?.tarifaAdulto4 ??
                                                        0)
                                                    .toString();

                                            minors7_12VRController
                                                .text = (firstTariff
                                                        ?.tarifaMenores7a12 ??
                                                    0)
                                                .toString();

                                            paxAdicVRController
                                                .text = (firstTariff
                                                        ?.tarifaPaxAdicional ??
                                                    0)
                                                .toString();

                                            adults1_2VPMController.text =
                                                (secondTariff
                                                            ?.tarifaAdulto1a2 ??
                                                        0)
                                                    .toString();

                                            adults3VPMController.text =
                                                (secondTariff?.tarifaAdulto3 ??
                                                        0)
                                                    .toString();

                                            adults4VPMController.text =
                                                (secondTariff?.tarifaAdulto4 ??
                                                        0)
                                                    .toString();

                                            minors7_12VPMController
                                                .text = (secondTariff
                                                        ?.tarifaMenores7a12 ??
                                                    0)
                                                .toString();

                                            paxAdicVPMController
                                                .text = (secondTariff
                                                        ?.tarifaPaxAdicional ??
                                                    0)
                                                .toString();

                                            setState(() {});
                                          },
                                          elements: baseTariffs,
                                          screenWidth: null,
                                          compact: true,
                                        ),
                                      ],
                                    );
                                  },
                                  error: (error, stackTrace) => const Tooltip(
                                      message: "Error de consulta",
                                      child: Icon(Icons.warning_amber_rounded,
                                          color: Colors.amber)),
                                  loading: () => Center(
                                    child: SizedBox(
                                      width: 40,
                                      child: ProgressIndicatorEstandar(
                                        sizeProgressIndicator: 30,
                                        inHorizontal: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Center(
                                child: Wrap(
                                  runSpacing: 15,
                                  spacing: 15,
                                  children: [
                                    AbsorbPointer(
                                      absorbing: usedBaseTariff,
                                      child: _sectionTariffForm(
                                        screenWidth: screenWidth,
                                        title: tipoHabitacion[0],
                                        autoCalculation: autoCalculationVR,
                                        onAutoCalculation: (p0) {
                                          autoCalculationVR = p0;
                                          if (!autoCalculationVR) {
                                            adults3VRController.text = '';
                                            adults4VRController.text = '';
                                          } else {
                                            _autoCalculationVR();
                                          }

                                          setState(() {});
                                        },
                                        color: DesktopColors.vistaReserva,
                                        child: FormTariffWidget(
                                          tarifaAdultoController:
                                              adults1_2VRController,
                                          tarifaAdultoTPLController:
                                              adults3VRController,
                                          tarifaAdultoCPLController:
                                              adults4VRController,
                                          tarifaPaxAdicionalController:
                                              paxAdicVRController,
                                          tarifaMenoresController:
                                              minors7_12VRController,
                                          onUpdate: () => setState(() {}),
                                          applyAutoCalculation:
                                              autoCalculationVR,
                                          isEditing: !usedBaseTariff,
                                          applyRound: usedBaseTariff,
                                          autoCalculation: () {
                                            _autoCalculationVR();
                                          },
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: usedBaseTariff,
                                      child: _sectionTariffForm(
                                        screenWidth: screenWidth,
                                        title: tipoHabitacion[1],
                                        color: DesktopColors.vistaParcialMar,
                                        autoCalculation: autoCalculationVPM,
                                        onAutoCalculation: (p0) {
                                          autoCalculationVPM = p0;
                                          if (!autoCalculationVPM) {
                                            adults3VPMController.text = '';
                                            adults4VPMController.text = '';
                                          } else {
                                            _autoCalculationVPM();
                                          }

                                          setState(() {});
                                        },
                                        child: FormTariffWidget(
                                          tarifaAdultoController:
                                              adults1_2VPMController,
                                          tarifaAdultoTPLController:
                                              adults3VPMController,
                                          tarifaAdultoCPLController:
                                              adults4VPMController,
                                          tarifaPaxAdicionalController:
                                              paxAdicVPMController,
                                          tarifaMenoresController:
                                              minors7_12VPMController,
                                          onUpdate: () => setState(() {}),
                                          applyAutoCalculation:
                                              autoCalculationVPM,
                                          applyRound: usedBaseTariff,
                                          isEditing: !usedBaseTariff,
                                          autoCalculation: () {
                                            _autoCalculationVPM();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                CustomWidgets.titleSeccion(
                                  context,
                                  title: "Temporadas",
                                  topPadding: 10,
                                ),
                                Wrap(
                                  runSpacing: 30,
                                  spacing: 15,
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    _gestureSeason(
                                      screenWidth: screenWidth,
                                      temporadas: temporadaIndListProvider,
                                      title: "Temporadas Individuales",
                                      newName: "BAR",
                                      useRomanNumber: true,
                                      colorSeason: DesktopColors.cotIndiv,
                                    ),
                                    _gestureSeason(
                                      screenWidth: screenWidth,
                                      temporadas: temporadaEfectivoListProvider,
                                      title: "Temporadas en Efectivo",
                                      newName: "EFECTIVO",
                                      tipoTemp: "efectivo",
                                      colorSeason: DesktopColors.cashSeason,
                                      withChangeTariffs: true,
                                      withChangeUseTariff: true,
                                    ),
                                    _gestureSeason(
                                      screenWidth: screenWidth,
                                      temporadas: temporadaGrupListProvider,
                                      title: "Temporadas Grupales",
                                      newName: "GRUPOS",
                                      tipoTemp: "grupal",
                                      colorSeason: DesktopColors.cotGrupal,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets.titleSeccion(
                                  context,
                                  title: "Tarífas de temporada",
                                  topPadding: 10,
                                ),
                                CustomWidgets.tableTarifasTemporadas(
                                  context: context,
                                  tipoHabitacion: tipoHabitacion[0],
                                  colorTipo: DesktopColors.vistaReserva,
                                  temporadas: temporadaIndListProvider +
                                      temporadaEfectivoListProvider +
                                      temporadaGrupListProvider,
                                  adults1a2: adults1_2VRController,
                                  adults3: adults3VRController,
                                  adults4: adults4VRController,
                                  paxAdic: paxAdicVRController,
                                  minor7a12: minors7_12VRController,
                                ),
                                const SizedBox(height: 20),
                                CustomWidgets.tableTarifasTemporadas(
                                  context: context,
                                  tipoHabitacion: tipoHabitacion[1],
                                  colorTipo: DesktopColors.vistaParcialMar,
                                  temporadas: temporadaIndListProvider +
                                      temporadaEfectivoListProvider +
                                      temporadaGrupListProvider,
                                  adults1a2: adults1_2VPMController,
                                  adults3: adults3VPMController,
                                  adults4: adults4VPMController,
                                  paxAdic: paxAdicVPMController,
                                  minor7a12: minors7_12VPMController,
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    width: 130,
                                    child: Buttons.commonButton(
                                      isLoading: isLoading,
                                      sizeText: 15,
                                      text: "Guardar",
                                      onPressed: () async => await savedTariff(
                                        temporadaIndListProvider +
                                            temporadaGrupListProvider +
                                            temporadaEfectivoListProvider,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(target: target).fadeIn(
          duration: Settings.applyAnimations ? null : 0.ms,
        );
  }

  bool evaluatedDates(
      List<Periodo> periodos, String fechaIni, String fechaSal) {
    bool isRepeat = false;

    isRepeat = periodos.any(
      (element) =>
          (element.fechaFinal!.isSameDate(DateTime.parse(fechaIni))) ||
          (element.fechaFinal!.isSameDate(DateTime.parse(fechaSal))) ||
          (element.fechaInicial!.isSameDate(DateTime.parse(fechaIni))) ||
          (element.fechaInicial!.isSameDate(DateTime.parse(fechaSal))) ||
          (element.fechaInicial!.compareTo(DateTime.parse(fechaIni)) > 0 &&
              element.fechaFinal!.compareTo(DateTime.parse(fechaSal)) < 0) ||
          (element.fechaInicial!.compareTo(DateTime.parse(fechaIni)) <= 0 &&
              element.fechaFinal!.compareTo(DateTime.parse(fechaSal)) >= 0),
    );

    return isRepeat;
  }

  double getWidthResizableTemporada(double screenWidth) {
    return screenWidth > 1200
        ? ((screenWidth - 32) - (widget.sideController.extended ? 230 : 122)) *
            0.327
        : screenWidth > 800
            ? ((screenWidth - 32) -
                    (widget.sideController.extended ? 230 : 122)) *
                0.5
            : (screenWidth - 32) * 0.5;
  }

  double getWidthResizableTarifa(double screenWidth) {
    return screenWidth > 1250
        ? 470
        : screenWidth > 800
            ? ((screenWidth - 77) -
                    (widget.sideController.extended ? 230 : 122)) *
                0.499
            : screenWidth > 650
                ? ((screenWidth - 72)) * 0.47
                : screenWidth;
  }

  WrapAlignment getWrapAligmentContainer(double screenWidth) {
    return (getWidthResizableTarifa(screenWidth) > 320)
        ? WrapAlignment.spaceBetween
        : WrapAlignment.center;
  }

  Future<void> savedTariff(List<Temporada> temporadas) async {
    if (!_formKeyTarifa.currentState!.validate()) return;

    if (periodos.isEmpty) {
      showSnackBar(
        context: context,
        title: "Periodo(s) requeridos",
        message:
            "Se requiere al menos un periodo para aplicar esta tarifa en el calendario",
        type: "danger",
      );
      return;
    }

    isLoading = true;
    setState(() {});

    late Tarifa tarifaVR;
    late Tarifa tarifaVPM;

    if (usedBaseTariff) {
      tarifaVR = selectBaseTariff!.tarifas!
          .firstWhere((element) => element.categoria == tipoHabitacion.first);
      tarifaVPM = selectBaseTariff!.tarifas!
          .firstWhere((element) => element.categoria == tipoHabitacion.last);
    } else {
      tarifaVR = Tarifa(
        // categoria: tipoHabitacion[0],
        tarifaAdulto1a2: double.parse(adults1_2VRController.text),
        tarifaAdulto3: double.parse(adults3VRController.text),
        tarifaAdulto4: double.parse(adults4VRController.text),
        tarifaMenores7a12: double.parse(minors7_12VRController.text),
        tarifaPaxAdicional: double.parse(paxAdicVRController.text),
      );

      tarifaVPM = Tarifa(
        // categoria: tipoHabitacion[1],
        tarifaAdulto1a2: double.parse(adults1_2VPMController.text),
        tarifaAdulto3: double.parse(adults3VPMController.text),
        tarifaAdulto4: double.parse(adults4VPMController.text),
        tarifaMenores7a12: double.parse(minors7_12VPMController.text),
        tarifaPaxAdicional: double.parse(paxAdicVPMController.text),
      );
    }

    bool isSaves = false;
    // oldRegister != null
    //     ? await TarifaBaseService().updateTarifaBD(
    //         oldRegister: oldRegister!,
    //         name: nombreTarifaController.text,
    //         colorIdentificativo: colorTarifa,
    //         diasAplicacion: selectedDayWeek,
    //         periodos: periodos,
    //         temporadas: temporadas,
    //         tarifaVPM: tarifaVPM,
    //         tarifaVR: tarifaVR,
    //         withBaseTariff: usedBaseTariff,
    //       )
    //     : await TarifaBaseService().saveTarifaBD(
    //         name: nombreTarifaController.text,
    //         colorIdentificativo: colorTarifa,
    //         diasAplicacion: selectedDayWeek,
    //         temporadas: temporadas,
    //         periodos: periodos,
    //         tarifaVPM: tarifaVPM,
    //         tarifaVR: tarifaVR,
    //         withBaseTariff: usedBaseTariff,
    //       );

    if (isSaves) {
      showSnackBar(
        context: context,
        title: "Tarifa ${oldRegister != null ? "Actualizada" : "Implementada"}",
        message:
            "La tarifa fue ${oldRegister != null ? "actualizada" : "guardada e implementada"} con exito",
        type: "success",
        iconCustom: oldRegister != null ? Icons.edit : Icons.save,
      );
      setState(() => target = 0);

      Future.delayed(
        500.ms,
        () {
          ref
              .read(changeTarifasProvider.notifier)
              .update((state) => UniqueKey().hashCode);
          ref
              .read(changeTarifasListProvider.notifier)
              .update((state) => UniqueKey().hashCode);
        },
      );

      Future.delayed(650.ms, () => widget.sideController.selectIndex(4));
    } else {
      if (mounted) return;
      showSnackBar(
          context: context,
          title: "Error de guardado",
          message:
              "Se detecto un error al intentar guardar la tarifa. Intentelo más tarde.",
          type: "danger");
      isLoading = false;
      setState(() {});
      return;
    }
  }

  void _autoCalculationVR() {
    if (autoCalculationVR) {
      adults3VRController.text = CalculatorHelpers.getRate(
        tarifaAdulto: adults1_2VRController.text,
        tarifaPaxAdicional: paxAdicVRController.text,
        numPaxAdic: 1,
      );
      adults4VRController.text = CalculatorHelpers.getRate(
        tarifaAdulto: adults1_2VRController.text,
        tarifaPaxAdicional: paxAdicVRController.text,
        numPaxAdic: 2,
      );
    }
  }

  void _autoCalculationVPM() {
    if (autoCalculationVPM) {
      adults3VPMController.text = CalculatorHelpers.getRate(
        tarifaAdulto: adults1_2VPMController.text,
        tarifaPaxAdicional: paxAdicVPMController.text,
        numPaxAdic: 1,
      );
      adults4VPMController.text = CalculatorHelpers.getRate(
        tarifaAdulto: adults1_2VPMController.text,
        tarifaPaxAdicional: paxAdicVPMController.text,
        numPaxAdic: 2,
      );
    }
  }

  void _addPeriod(String initDate, String lastDate) {
    if (!evaluatedDates(periodos, initDate, lastDate)) {
      periodos.add(Periodo(
        fechaInicial: DateTime.parse(initDate),
        fechaFinal: DateTime.parse(lastDate),
      ));
      setState(() {});
      resetDates();
    } else {
      showSnackBar(
        context: context,
        title: "Concurrencia de periodo",
        message:
            "Ya existe un periodo que contempla o abarca estas fechas de implementación",
        type: "alert",
      );
    }
  }

  Widget _buttonAdd({required void Function()? onPressed, Color? color}) {
    return SizedBox(
      width: 110,
      height: 35,
      child: Buttons.commonButton(
        text: "Agregar",
        sizeText: 11.5,
        icons: HeroIcons.plus,
        withRoundedBorder: true,
        spaceBetween: 0,
        borderRadius: 8,
        colorBorder: Theme.of(context).primaryColor,
        color: color ?? Theme.of(context).cardColor,
        elevation: 0,
        onPressed: onPressed,
      ),
    );
  }

  Widget _gestureSeason({
    required double screenWidth,
    required List<Temporada> temporadas,
    required String title,
    required String newName,
    bool withChangeUseTariff = false,
    bool withChangeTariffs = false,
    bool useRomanNumber = false,
    required Color colorSeason,
    String tipoTemp = "individual",
  }) {
    return _sectionTariffForm(
      screenWidth: screenWidth,
      title: title,
      color: colorSeason,
      onAddSeason: () => setState(
        () {
          temporadas.add(
            Temporada(
              nombre: (temporadas.isEmpty)
                  ? newName
                  : "$newName ${useRomanNumber ? Utility.intToRoman(temporadas.length) : "(${temporadas.length + 1})"}",
              tipo: tipoTemp,
            ),
          );
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var element in temporadas)
            SizedBox(
              width: getWidthResizableTarifa(screenWidth),
              child: CustomWidgets.sectionConfigSeason(
                context: context,
                temporadas: temporadas,
                temporada: element,
                onRemove: () => setState(() => temporadas.remove(element)),
                onChangedDescuento: (p0) =>
                    setState(() => element.descuento = double.tryParse(p0)),
                onChangedName: (p0) => setState(() => element.nombre = p0),
                onChangedEstancia: (p0) =>
                    element.estanciaMinima = int.tryParse(p0),
                onChangedTariffs: !withChangeTariffs
                    ? null
                    : (p0) => setState(() => element.tarifas = p0),
                onChangedUseTariff: !withChangeUseTariff
                    ? null
                    : (p0) => setState(() => element.useTariff = p0),
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionTariffForm({
    required double screenWidth,
    required String title,
    required Color color,
    required Widget child,
    bool autoCalculation = false,
    void Function(bool)? onAutoCalculation,
    void Function()? onAddSeason,
  }) {
    return SizedBox(
      width: getWidthResizableTarifa(screenWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(7))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                alignment: getWrapAligmentContainer(screenWidth),
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextStyles.mediumText(
                      text: title,
                      color: Colors.white,
                      aling: TextAlign.center,
                    ),
                  ),
                  if (onAddSeason != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: _buttonAdd(
                        onPressed: onAddSeason,
                        color: color,
                      ),
                    ),
                  if (!usedBaseTariff && onAutoCalculation != null)
                    FormWidgets.inputSwitch(
                      compact: screenWidth < 1290 && screenWidth > 1020,
                      name: "Auto calculación",
                      context: context,
                      value: autoCalculation,
                      activeColor: Colors.white,
                      onChanged: onAutoCalculation,
                    )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
