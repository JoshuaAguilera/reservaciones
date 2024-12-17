import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/periodo_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_base_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/providers/tarifario_provider.dart';
import 'package:generador_formato/services/tarifa_service.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/views/tarifario/calendar_controller_widget.dart';
import 'package:generador_formato/widgets/form_tariff_widget.dart';
import 'package:generador_formato/widgets/item_rows.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/custom_widgets.dart';
import '../../ui/progress_indicator.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

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
  RegistroTarifa? oldRegister;
  TextEditingController nombreTarifaController = TextEditingController();
  TextEditingController _fechaEntrada = TextEditingController(text: "");
  TextEditingController _fechaSalida = TextEditingController(text: "");
  String codeTarifa =
      "${UniqueKey()} - ${Preferences.username} - ${Preferences.userId} - ${DateTime.now().toString()}";

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
  TarifaBaseInt? selectBaseTariff;
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final actualTarifa = ref.watch(editTarifaProvider);
    final temporadaIndListProvider = ref.read(temporadasIndividualesProvider);
    final temporadaGrupListProvider = ref.read(temporadasGrupalesProvider);
    final temporadaEfectivoListProvider = ref.read(temporadasEfectivoProvider);
    final tarifasBase = ref.watch(tarifaBaseProvider(""));

    if (!starflow && actualTarifa.code != null) {
      nombreTarifaController.text = actualTarifa.nombre!;
      colorTarifa = actualTarifa.color!;
      initiallyExpanded = true;
      oldRegister = actualTarifa;
      autoCalculationVPM = false;
      autoCalculationVR = false;

      if (actualTarifa.periodos!.isNotEmpty) {
        selectedDayWeek[0] = actualTarifa.periodos!.first.enLunes ?? false;
        selectedDayWeek[1] = actualTarifa.periodos!.first.enMartes ?? false;
        selectedDayWeek[2] = actualTarifa.periodos!.first.enMiercoles ?? false;
        selectedDayWeek[3] = actualTarifa.periodos!.first.enJueves ?? false;
        selectedDayWeek[4] = actualTarifa.periodos!.first.enViernes ?? false;
        selectedDayWeek[5] = actualTarifa.periodos!.first.enSabado ?? false;
        selectedDayWeek[6] = actualTarifa.periodos!.first.enDomingo ?? false;
      }
      periodos = Utility.getPeriodsRegister(actualTarifa.periodos);

      adults1_2VRController.text =
          actualTarifa.tarifas!.first.tarifaAdultoSGLoDBL!.round().toString();
      paxAdicVRController.text =
          actualTarifa.tarifas!.first.tarifaPaxAdicional!.round().toString();
      adults3VRController.text =
          actualTarifa.tarifas!.first.tarifaAdultoTPL != null
              ? actualTarifa.tarifas!.first.tarifaAdultoTPL!.round().toString()
              : Utility.calculateRate(
                  adults1_2VRController, paxAdicVRController, 1);
      adults4VRController.text =
          actualTarifa.tarifas!.first.tarifaAdultoCPLE != null
              ? actualTarifa.tarifas!.first.tarifaAdultoCPLE!.round().toString()
              : Utility.calculateRate(
                  adults1_2VRController, paxAdicVRController, 2);
      minors7_12VRController.text =
          actualTarifa.tarifas!.first.tarifaMenores7a12!.round().toString();

      adults1_2VPMController.text =
          actualTarifa.tarifas![1].tarifaAdultoSGLoDBL!.round().toString();
      paxAdicVPMController.text =
          actualTarifa.tarifas![1].tarifaPaxAdicional!.round().toString();
      adults3VPMController.text =
          actualTarifa.tarifas![1].tarifaAdultoTPL != null
              ? actualTarifa.tarifas![1].tarifaAdultoTPL!.round().toString()
              : Utility.calculateRate(
                  adults1_2VPMController, paxAdicVPMController, 1);
      adults4VPMController.text =
          actualTarifa.tarifas![1].tarifaAdultoCPLE != null
              ? actualTarifa.tarifas![1].tarifaAdultoCPLE!.round().toString()
              : Utility.calculateRate(
                  adults1_2VPMController, paxAdicVPMController, 2);
      minors7_12VPMController.text =
          actualTarifa.tarifas![1].tarifaMenores7a12!.round().toString();

      if (actualTarifa.tarifas?.first.tarifaPadreId != null) {
        tarifasBase.when(
          data: (data) {
            selectBaseTariff = data
                .where((element) =>
                    element.code == actualTarifa.tarifas?.first.code)
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
          child: Form(
            key: _formKeyTarifa,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidgets.titleFormPage(
                  context: context,
                  title: actualTarifa.code != null
                      ? "Editar tarifa: ${nombreTarifaController.text}"
                      : "Registrar nueva tarifa",
                  onPressedBack: () {
                    setState(() => target = 0);

                    Future.delayed(
                        500.ms, () => widget.sideController.selectIndex(4));
                  },
                  onPressedSaveButton: () async => await savedTariff(
                      temporadaIndListProvider + temporadaGrupListProvider),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextStyles.titleText(
                                  text: "Datos generales",
                                  size: 18,
                                  color: Theme.of(context).dividerColor,
                                ),
                                Divider(color: Theme.of(context).primaryColor),
                              ],
                            ),
                          ),
                          Wrap(
                            runSpacing: 15,
                            spacing: 25,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              SizedBox(
                                width: 500,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextFormFieldCustom
                                          .textFormFieldwithBorder(
                                        name: "Nombre de la tarifa Rack",
                                        controller: nombreTarifaController,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: FormWidgets.inputColor(
                                        nameInput: "Color:",
                                        primaryColor: colorTarifa,
                                        colorText:
                                            Theme.of(context).primaryColor,
                                        onChangedColor: (p0) =>
                                            setState(() => colorTarifa = p0),
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
                                            color:
                                                Theme.of(context).primaryColor),
                                        CustomWidgets.sectionButton(
                                          listModes: selectedDayWeek,
                                          modesVisual: [],
                                          onChanged: (p0, p1) {},
                                          isReactive: false,
                                          isCompact: true,
                                          arrayStrings: daysNameShort,
                                          borderRadius: 12,
                                          selectedBorderColor: colorTarifa,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextStyles.titleText(
                                  text: "Periodos",
                                  size: 18,
                                  color: Theme.of(context).dividerColor,
                                ),
                                Divider(color: Theme.of(context).primaryColor),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 800,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormFieldCustom
                                      .textFormFieldwithBorderCalendar(
                                    name: "Fecha de apertura",
                                    msgError: "Campo requerido*",
                                    fechaLimite:
                                        DateTime(DateTime.now().year, 1, 1)
                                            .subtract(const Duration(days: 1))
                                            .toIso8601String(),
                                    dateController: _fechaEntrada,
                                    onChanged: () => setState(
                                      () {
                                        if (DateTime.parse(_fechaSalida.text)
                                            .isBefore(DateTime.parse(
                                                _fechaEntrada.text))) {
                                          _fechaSalida.text =
                                              Utility.getNextDay(
                                                  _fechaEntrada.text);
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: TextFormFieldCustom
                                      .textFormFieldwithBorderCalendar(
                                    name: "Fecha de clausura",
                                    msgError: "Campo requerido*",
                                    dateController: _fechaSalida,
                                    fechaLimite:
                                        DateTime.parse(_fechaEntrada.text)
                                            .subtract(const Duration(days: 1))
                                            .toIso8601String(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Tooltip(
                                  margin: const EdgeInsets.only(top: 10),
                                  message: "Agregar periodo",
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (!evaluatedDates(
                                          periodos,
                                          _fechaEntrada.text,
                                          _fechaSalida.text)) {
                                        periodos.add(
                                          Periodo(
                                            fechaInicial: DateTime.parse(
                                                _fechaEntrada.text),
                                            fechaFinal: DateTime.parse(
                                                _fechaSalida.text),
                                          ),
                                        );
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
                                    },
                                    style: ButtonStyle(
                                      padding: const WidgetStatePropertyAll(
                                          EdgeInsets.zero),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Theme.of(context).primaryColorDark),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SizedBox(
                              child: Wrap(
                                children: [
                                  for (var element in periodos)
                                    ItemRows.filterItemRow(
                                      colorCard: colorTarifa,
                                      initDate: element.fechaInicial!,
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextStyles.titleText(
                                    text: "Tarífas",
                                    size: 18,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                  tarifasBase.when(
                                    data: (data) {
                                      String selectTariff =
                                          selectBaseTariff != null
                                              ? selectBaseTariff?.nombre ??
                                                  'Ninguna'
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
                                            fontSize: 12,
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
                                                minors7_12VRController.text =
                                                    '';
                                                adults1_2VPMController.text =
                                                    '';
                                                adults3VPMController.text = '';
                                                adults4VPMController.text = '';
                                                paxAdicVPMController.text = '';
                                                minors7_12VPMController.text =
                                                    '';
                                                setState(() {});
                                                return;
                                              }

                                              autoCalculationVPM = false;
                                              autoCalculationVR = false;
                                              usedBaseTariff = true;

                                              Tarifa? firstTariff =
                                                  selectBaseTariff
                                                      ?.tarifas
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

                                              adults1_2VRController
                                                  .text = (firstTariff
                                                          ?.tarifaAdulto1a2 ??
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

                                              adults1_2VPMController
                                                  .text = (secondTariff
                                                          ?.tarifaAdulto1a2 ??
                                                      0)
                                                  .toString();

                                              adults3VPMController.text =
                                                  (secondTariff
                                                              ?.tarifaAdulto3 ??
                                                          0)
                                                      .toString();

                                              adults4VPMController.text =
                                                  (secondTariff
                                                              ?.tarifaAdulto4 ??
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
                                  )
                                ],
                              ),
                              Divider(color: Theme.of(context).primaryColor),
                            ],
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
                                child: SizedBox(
                                  width: getWidthResizableTarifa(screenWidth),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: DesktopColors.vistaReserva,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Wrap(
                                            alignment: getWrapAligmentContainer(
                                                screenWidth),
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            runAlignment: WrapAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: TextStyles.mediumText(
                                                  text: tipoHabitacion[0],
                                                  color: Colors.white,
                                                  aling: TextAlign.center,
                                                ),
                                              ),
                                              if (!usedBaseTariff)
                                                FormWidgets.inputSwitch(
                                                  name: "Auto calculación:",
                                                  context: context,
                                                  value: autoCalculationVR,
                                                  activeColor: Colors.white,
                                                  onChanged: (p0) {
                                                    autoCalculationVR = p0;
                                                    if (!autoCalculationVR) {
                                                      adults3VRController.text =
                                                          '';
                                                      adults4VRController.text =
                                                          '';
                                                    } else {
                                                      _autoCalculationVR();
                                                    }

                                                    setState(() {});
                                                  },
                                                )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      FormTariffWidget(
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
                                        applyAutoCalculation: autoCalculationVR,
                                        isEditing: !usedBaseTariff,
                                        autoCalculation: () {
                                          _autoCalculationVR();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AbsorbPointer(
                                absorbing: usedBaseTariff,
                                child: SizedBox(
                                  width: getWidthResizableTarifa(screenWidth),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color:
                                                DesktopColors.vistaParcialMar,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Wrap(
                                            alignment: getWrapAligmentContainer(
                                                screenWidth),
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            runAlignment: WrapAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: TextStyles.mediumText(
                                                  text: tipoHabitacion[1],
                                                  color: Colors.white,
                                                  aling: TextAlign.center,
                                                ),
                                              ),
                                              if (!usedBaseTariff)
                                                FormWidgets.inputSwitch(
                                                  name: "Auto calculación:",
                                                  context: context,
                                                  value: autoCalculationVPM,
                                                  activeColor: Colors.white,
                                                  onChanged: (p0) {
                                                    autoCalculationVPM = p0;
                                                    if (!autoCalculationVPM) {
                                                      adults3VPMController
                                                          .text = '';
                                                      adults4VPMController
                                                          .text = '';
                                                    } else {
                                                      _autoCalculationVPM();
                                                    }

                                                    setState(() {});
                                                  },
                                                )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      FormTariffWidget(
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
                                        isEditing: !usedBaseTariff,
                                        autoCalculation: () {
                                          _autoCalculationVPM();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 1, top: 20),
                          child: TextStyles.titleText(
                            text: "Temporadas",
                            size: 18,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        Divider(color: Theme.of(context).primaryColor),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            spacing: 2,
                            runSpacing: 4,
                            children: [
                              for (var element in temporadaIndListProvider)
                                SizedBox(
                                  width:
                                      getWidthResizableTemporada(screenWidth) -
                                          35,
                                  child: CustomWidgets.sectionConfigSeason(
                                    context: context,
                                    temporada: element,
                                    temporadas: temporadaIndListProvider,
                                    onRemove: () => setState(() =>
                                        temporadaIndListProvider
                                            .remove(element)),
                                    onChangedDescuento: (p0) => setState(() =>
                                        element.porcentajePromocion =
                                            double.tryParse(p0)),
                                    onChangedName: (p0) =>
                                        setState(() => element.nombre = p0),
                                    onChangedEstancia: (p0) => element
                                        .estanciaMinima = int.tryParse(p0),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 23),
                                child: InkWell(
                                  onTap: () => setState(() {
                                    temporadaIndListProvider.add(Temporada(
                                        nombre:
                                            "BAR ${Utility.intToRoman(temporadaIndListProvider.length)}"));
                                  }),
                                  child: Container(
                                    width: 95,
                                    height: 109,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.add,
                                          size: 35,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        TextStyles.standardText(
                                          text: "Agregar\nTemporada",
                                          aling: TextAlign.center,
                                          color: Theme.of(context).primaryColor,
                                          size: 11,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 1, top: 5),
                          child: Row(
                            children: [
                              TextStyles.titleText(
                                text: "Temporadas Grupales  ",
                                size: 18,
                                color: Theme.of(context).dividerColor,
                              ),
                              TextStyles.titleText(
                                text: "(Solo para cotizaciones grupales)",
                                size: 13,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Theme.of(context).primaryColor),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            spacing: 2,
                            runSpacing: 4,
                            children: [
                              for (var element in temporadaGrupListProvider)
                                SizedBox(
                                  width:
                                      getWidthResizableTemporada(screenWidth) -
                                          35,
                                  child: CustomWidgets.sectionConfigSeason(
                                    context: context,
                                    temporadas: temporadaGrupListProvider,
                                    temporada: element,
                                    onRemove: () => setState(() =>
                                        temporadaGrupListProvider
                                            .remove(element)),
                                    onChangedDescuento: (p0) => setState(() =>
                                        element.porcentajePromocion =
                                            double.tryParse(p0)),
                                    onChangedName: (p0) =>
                                        setState(() => element.nombre = p0),
                                    onChangedEstancia: (p0) => element
                                        .estanciaMinima = int.tryParse(p0),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 23),
                                child: InkWell(
                                  onTap: () => setState(() {
                                    temporadaGrupListProvider.add(Temporada(
                                      nombre: (temporadaGrupListProvider
                                              .isEmpty)
                                          ? "GRUPOS"
                                          : "GRUPOS (${temporadaGrupListProvider.length + 1})",
                                      forGroup: true,
                                    ));
                                  }),
                                  child: Container(
                                    width: 95,
                                    height: 109,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.add,
                                          size: 35,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        TextStyles.standardText(
                                          text: "Agregar\nTemporada",
                                          aling: TextAlign.center,
                                          color: Theme.of(context).primaryColor,
                                          size: 11,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 1, top: 5),
                          child: Row(
                            children: [
                              TextStyles.titleText(
                                text: "Temporadas en Efectivo  ",
                                size: 18,
                                color: Theme.of(context).dividerColor,
                              ),
                              Expanded(
                                child: TextStyles.titleText(
                                  text:
                                      "(Solo para cotizaciones con método de pago en Efectivo)",
                                  size: 13,
                                  color: Theme.of(context).primaryColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Theme.of(context).primaryColor),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            spacing: 2,
                            runSpacing: 4,
                            children: [
                              for (var element in temporadaEfectivoListProvider)
                                SizedBox(
                                  width:
                                      getWidthResizableTemporada(screenWidth) -
                                          35,
                                  child: CustomWidgets.sectionConfigSeason(
                                    context: context,
                                    temporadas: temporadaEfectivoListProvider,
                                    temporada: element,
                                    onRemove: () => setState(() =>
                                        temporadaEfectivoListProvider
                                            .remove(element)),
                                    onChangedDescuento: (p0) => setState(() =>
                                        element.porcentajePromocion =
                                            double.tryParse(p0)),
                                    onChangedUseTariff: (p0) =>
                                        setState(() => element.useTariff = p0),
                                    onChangedName: (p0) =>
                                        setState(() => element.nombre = p0),
                                    onChangedEstancia: (p0) => element
                                        .estanciaMinima = int.tryParse(p0),
                                    onChangedTariffs: (p0) =>
                                        setState(() => element.tarifas = p0),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 23),
                                child: InkWell(
                                  onTap: () => setState(() {
                                    temporadaEfectivoListProvider.add(Temporada(
                                      nombre: (temporadaEfectivoListProvider
                                              .isEmpty)
                                          ? "EFECTIVO"
                                          : "EFECTIVO (${temporadaEfectivoListProvider.length + 1})",
                                      forCash: true,
                                    ));
                                  }),
                                  child: Container(
                                    width: 95,
                                    height: 109,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.add,
                                          size: 35,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        TextStyles.standardText(
                                          text: "Agregar\nTemporada",
                                          aling: TextAlign.center,
                                          color: Theme.of(context).primaryColor,
                                          size: 11,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.titleText(
                                text: "Tarífas de temporada",
                                size: 18,
                                color: Theme.of(context).dividerColor,
                              ),
                              Divider(color: Theme.of(context).primaryColor),
                            ],
                          ),
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
              ],
            ),
          ),
        ),
      ),
    ).animate(target: target).fadeIn();
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
    return screenWidth > 800
        ? ((screenWidth - 37) - (widget.sideController.extended ? 230 : 122)) *
            0.499
        : screenWidth > 650
            ? ((screenWidth - 32)) * 0.47
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
        categoria: tipoHabitacion[0],
        tarifaAdulto1a2: double.parse(adults1_2VRController.text),
        tarifaAdulto3: double.parse(adults3VRController.text),
        tarifaAdulto4: double.parse(adults4VRController.text),
        tarifaMenores7a12: double.parse(minors7_12VRController.text),
        tarifaPaxAdicional: double.parse(paxAdicVRController.text),
      );

      tarifaVPM = Tarifa(
        categoria: tipoHabitacion[1],
        tarifaAdulto1a2: double.parse(adults1_2VPMController.text),
        tarifaAdulto3: double.parse(adults3VPMController.text),
        tarifaAdulto4: double.parse(adults4VPMController.text),
        tarifaMenores7a12: double.parse(minors7_12VPMController.text),
        tarifaPaxAdicional: double.parse(paxAdicVPMController.text),
      );
    }

    bool isSaves = oldRegister != null
        ? await TarifaService().updateTarifaBD(
            oldRegister: oldRegister!,
            name: nombreTarifaController.text,
            colorIdentificativo: colorTarifa,
            diasAplicacion: selectedDayWeek,
            periodos: periodos,
            temporadas: temporadas,
            tarifaVPM: tarifaVPM,
            tarifaVR: tarifaVR,
            withBaseTariff: usedBaseTariff,
          )
        : await TarifaService().saveTarifaBD(
            name: nombreTarifaController.text,
            colorIdentificativo: colorTarifa,
            diasAplicacion: selectedDayWeek,
            temporadas: temporadas,
            periodos: periodos,
            tarifaVPM: tarifaVPM,
            tarifaVR: tarifaVR,
            withBaseTariff: usedBaseTariff,
          );

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
      adults3VRController.text =
          Utility.calculateRate(adults1_2VRController, paxAdicVRController, 1);
      adults4VRController.text =
          Utility.calculateRate(adults1_2VRController, paxAdicVRController, 2);
    }
  }

  void _autoCalculationVPM() {
    if (autoCalculationVPM) {
      adults3VPMController.text = Utility.calculateRate(
          adults1_2VPMController, paxAdicVPMController, 1);
      adults4VPMController.text = Utility.calculateRate(
          adults1_2VPMController, paxAdicVPMController, 2);
    }
  }
}
