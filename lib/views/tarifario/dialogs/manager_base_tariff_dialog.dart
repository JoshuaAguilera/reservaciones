import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/tarifa_base_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/view-models/services/tarifa_base_service.dart';
import 'package:generador_formato/res/ui/inside_snackbar.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/utils/widgets/form_widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../res/helpers/calculator_helpers.dart';
import '../../../res/helpers/colors_helpers.dart';
import '../../../res/ui/buttons.dart';
import '../../../res/ui/custom_widgets.dart';
import '../../../res/ui/show_snackbar.dart';
import '../../../res/helpers/utility.dart';
import '../../../res/helpers/desktop_colors.dart';
import '../../../utils/widgets/custom_dropdown.dart';
import '../../../utils/widgets/dialogs.dart';
import '../../../utils/widgets/form_tariff_widget.dart';
import '../../../res/ui/text_styles.dart';
import '../../../utils/widgets/textformfield_custom.dart';

class ManagerBaseTariffDialog extends StatefulWidget {
  const ManagerBaseTariffDialog({super.key, required this.tarifasBase});

  final List<TarifaBase> tarifasBase;

  @override
  State<ManagerBaseTariffDialog> createState() =>
      _ManagerBaseTariffDialogState();
}

class _ManagerBaseTariffDialogState extends State<ManagerBaseTariffDialog> {
  List<String> categorias = ["VISTA A LA RESERVA", "VISTA PARCIAL AL MAR"];
  String selectCategory = "VISTA A LA RESERVA";
  List<String> tarifasBaseTags = [];
  String selectTarifaPadre = "Ninguna";
  final _nombreTarifaController = TextEditingController();
  final _tarifaAdultoSingleController = TextEditingController();
  final _tarifaAdultoTPLController = TextEditingController();
  final _tarifaAdultoCPLController = TextEditingController();
  final _tarifaPaxAdicionalController = TextEditingController();
  final _tarifaMenoresController = TextEditingController();
  final _dividendoController = TextEditingController();
  final _formKeyManagerBase = GlobalKey<FormState>();
  bool applyUpgrades = false;
  bool showError = false;
  Tarifa? firstTariff;
  Tarifa? saveTariff;
  double? upgradeCateg;
  double? upgradeMenor;
  double? upGradePaxAdic;
  TarifaBase? tarifaPadre;
  TarifaBase? selectBaseTariff;
  String messageError = "";
  bool isLoading = false;
  bool isTariffPadre = false;
  bool applyPropageChange = true;
  bool withAutocalculation = false;

  @override
  void initState() {
    _selectNewBaseTariff(null);

    super.initState();
  }

  void _updateTarifasPadre(TarifaBase? selectTariff) {
    isTariffPadre = false;
    tarifaPadre = selectTariff?.tarifaBase;
    if (widget.tarifasBase.any((element) =>
        (element.tarifaBase?.nombre == (selectTariff?.nombre ?? '') ||
            (element.creadoPor == (selectTariff?.idInt ?? 0))))) {
      isTariffPadre = true;
      setState(() {});
    }
    tarifasBaseTags = [];
    tarifasBaseTags.add("Ninguna");

    //Arreglar administracion de tarifas padre en cuanto a su uso, evitando sobre uso de propios hijos
    for (var element in widget.tarifasBase) {
      if ((element.nombre ?? '') == selectTariff?.nombre) continue;
      if ((element.tarifaBase?.idInt ?? 0) == selectTariff?.idInt) continue;
      if ((element.creadoPor ?? 0) == selectTariff?.idInt) continue;
      if ((element.tarifaBase?.tarifaBase?.idInt ?? 0) == selectTariff?.idInt) {
        continue;
      }
      if ((element.tarifaBase?.tarifaBase?.tarifaBase?.idInt ?? 0) ==
          selectTariff?.idInt) {
        continue;
      }
      if ((element.tarifaBase?.tarifaBase?.tarifaBase?.tarifaBase?.idInt ??
              0) ==
          selectTariff?.idInt) {
        continue;
      }
      tarifasBaseTags.add(element.nombre!);
    }
  }

  Widget _textFieldData(
      double? data, String name, void Function(String)? onChanged) {
    return Expanded(
      child: SizedBox(
        height: 33,
        child: TextFormFieldCustom.textFormFieldwithBorder(
          name: name,
          msgError: "",
          initialValue: data?.toString(),
          marginBottom: 0,
          isNumeric: true,
          onChanged: onChanged,
        ),
      ),
    );
  }

  double? obtenerTarifa({
    required TextEditingController controller,
    required double? Function(Tarifa tarifa) obtenerCampo,
  }) {
    if (controller.text.isNotEmpty && tarifaPadre == null) {
      return double.parse(controller.text);
    }

    String categoriaSeleccionada =
        tipoHabitacion[categorias.indexOf(selectCategory)];

    if (tarifaPadre?.tarifas != null) {
      Tarifa tarifaMayor = tarifaPadre?.tarifas?.firstWhere(
              (element) => element.categoria == categoriaSeleccionada) ??
          Tarifa();
      // Tarifa(categoria: categoriaSeleccionada);
      return obtenerCampo(tarifaMayor) ?? 0;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: 700,
        height: 655,
        child: Row(
          children: [
            Container(
              width: 190,
              height: 655,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              decoration: BoxDecoration(
                color: ColorsHelpers.darken(Theme.of(context).cardColor, 0.07),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.titleText(
                      text: "Tarifas Base",
                      color: Theme.of(context).primaryColor,
                      size: 17,
                    ),
                    const SizedBox(height: 15),
                    _buildStepItem(
                      "Nueva Tarifa",
                      null,
                      isNew: true,
                    ),
                    Divider(),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var element in widget.tarifasBase)
                            _buildStepItem(
                              element.nombre ?? '',
                              element,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKeyManagerBase,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextStyles.titleText(
                                text: "Gestión de Tarifas Base para Tarifario",
                                color: Theme.of(context).primaryColor,
                                size: 17,
                              ),
                              const SizedBox(height: 8),
                              TextStyles.standardText(
                                text:
                                    "Revisa, edita, actualiza o elimina las tarifas base para optimizar el tarifario. Esto permitirá generar de forma ágil y precisa las tarifas para cotizaciones.",
                                overClip: true,
                                size: 12,
                              ),
                              if (tarifasBaseTags.length > 1)
                                const SizedBox(height: 12),
                              if (tarifasBaseTags.length > 1)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextStyles.standardText(
                                      text: "Tarifa Padre:",
                                    ),
                                    const SizedBox(width: 10),
                                    CustomDropdown.dropdownMenuCustom(
                                      initialSelection:
                                          tarifaPadre?.nombre ?? 'Ninguna',
                                      onSelected: (String? value) {
                                        tarifaPadre = widget.tarifasBase
                                            .where((element) =>
                                                (element.nombre ?? '') == value)
                                            .firstOrNull;

                                        saveTariff = tarifaPadre?.tarifas
                                            ?.where((element) =>
                                                element.categoria !=
                                                tipoHabitacion[categorias
                                                    .indexOf(selectCategory)])
                                            .firstOrNull;

                                        saveTariff?.tarifaBase = null;

                                        _applyDiscountTariff(
                                          tarifaPadre?.tarifas
                                              ?.where((element) =>
                                                  element.categoria ==
                                                  tipoHabitacion[categorias
                                                      .indexOf(selectCategory)])
                                              .firstOrNull,
                                          percent: double.tryParse(
                                              _dividendoController.text),
                                        );
                                        setState(() {});
                                      },
                                      elements: tarifasBaseTags,
                                      screenWidth: null,
                                      compact: true,
                                      compactHeight: 37,
                                      compactWidth: 200,
                                      dyCompact: -5,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: AbsorbPointer(
                                        absorbing: tarifaPadre == null,
                                        child: Opacity(
                                          opacity:
                                              tarifaPadre != null ? 1 : 0.5,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextStyles.standardText(
                                                text: "Divisor:",
                                              ),
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                height: 35,
                                                width: 80,
                                                child:
                                                    FormWidgets.textFormField(
                                                  name: "",
                                                  msgError: "",
                                                  enabled: tarifaPadre != null,
                                                  isRequired:
                                                      tarifaPadre != null,
                                                  isNumeric: true,
                                                  isDecimal: true,
                                                  icon: const Icon(
                                                      Icons.splitscreen,
                                                      size: 20),
                                                  controller:
                                                      _dividendoController,
                                                  onChanged: (p0) {
                                                    _applyDiscountTariff(
                                                      tarifaPadre?.tarifas
                                                          ?.where((element) =>
                                                              element
                                                                  .categoria ==
                                                              tipoHabitacion[
                                                                  categorias
                                                                      .indexOf(
                                                                          selectCategory)])
                                                          .firstOrNull,
                                                      percent:
                                                          double.tryParse(p0),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              const SizedBox(height: 12),
                              SizedBox(
                                  height: 35,
                                  child: FormWidgets.textFormField(
                                    name: "Nombre Tarifa Base",
                                    filled: true,
                                    msgError: "",
                                    controller: _nombreTarifaController,
                                    icon: const Icon(
                                      HeroIcons.square_3_stack_3d,
                                      size: 20,
                                    ),
                                  )),
                              if (tarifaPadre == null)
                                const SizedBox(height: 12),
                              if (tarifaPadre == null)
                                FormWidgets.inputSwitch(
                                  value: applyUpgrades,
                                  activeColor: Colors.amber,
                                  context: context,
                                  name:
                                      "Implementar upgrades automaticamente: ",
                                  onChanged: (p0) {
                                    applyUpgrades = p0;
                                    setState(() {});
                                    if (p0) {
                                      if (saveTariff?.categoria ==
                                          tipoHabitacion.first) {
                                        _tarifaAdultoSingleController.text =
                                            (saveTariff?.tarifaAdulto1a2 ?? '')
                                                .toString();
                                        _tarifaAdultoTPLController.text =
                                            (saveTariff?.tarifaAdulto3 ?? '')
                                                .toString();
                                        _tarifaAdultoCPLController.text =
                                            (saveTariff?.tarifaAdulto4 ?? '')
                                                .toString();
                                        _tarifaPaxAdicionalController.text =
                                            (saveTariff?.tarifaPaxAdicional ??
                                                    '')
                                                .toString();
                                        _tarifaMenoresController.text =
                                            (saveTariff?.tarifaMenores7a12 ??
                                                    '')
                                                .toString();
                                      }
                                      saveTariff = null;
                                      selectCategory = categorias.first;

                                      setState(() {});
                                    } else {
                                      _recoverySaveTariff(selectBaseTariff);
                                    }
                                  },
                                ),
                              SizedBox(height: applyUpgrades ? 0 : 8),
                              if (!applyUpgrades)
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  child: StatefulBuilder(
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: 2,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 3),
                                            child: SelectableButton(
                                              selected: selectCategory ==
                                                  categorias[index],
                                              roundActive: 6,
                                              round: 6,
                                              color: ColorsHelpers.darken(
                                                  selectCategory ==
                                                          categorias.first
                                                      ? DesktopColors
                                                          .vistaReserva
                                                      : DesktopColors
                                                          .vistaParcialMar,
                                                  -0.15),
                                              onPressed: () {
                                                if (selectCategory ==
                                                    categorias[index]) return;

                                                Tarifa? selectTariff =
                                                    firstTariff!.copyWith();

                                                Tarifa saveIntTariff = Tarifa(
                                                  // categoria: tipoHabitacion[
                                                  //     categorias.indexOf(
                                                  //         selectCategory)],
                                                  id: selectTariff.id,
                                                  tarifaAdulto1a2:
                                                      obtenerTarifa(
                                                    controller:
                                                        _tarifaAdultoSingleController,
                                                    obtenerCampo: (tarifa) =>
                                                        tarifa.tarifaAdulto1a2,
                                                  ),
                                                  tarifaAdulto3: obtenerTarifa(
                                                    controller:
                                                        _tarifaAdultoTPLController,
                                                    obtenerCampo: (tarifa) =>
                                                        tarifa.tarifaAdulto3,
                                                  ),
                                                  tarifaAdulto4: obtenerTarifa(
                                                    controller:
                                                        _tarifaAdultoCPLController,
                                                    obtenerCampo: (tarifa) =>
                                                        tarifa.tarifaAdulto4,
                                                  ),
                                                  tarifaPaxAdicional:
                                                      obtenerTarifa(
                                                    controller:
                                                        _tarifaPaxAdicionalController,
                                                    obtenerCampo: (tarifa) =>
                                                        tarifa
                                                            .tarifaPaxAdicional,
                                                  ),
                                                  tarifaMenores7a12:
                                                      obtenerTarifa(
                                                    controller:
                                                        _tarifaMenoresController,
                                                    obtenerCampo: (tarifa) =>
                                                        tarifa
                                                            .tarifaMenores7a12,
                                                  ),
                                                );

                                                _applyDiscountTariff(
                                                  saveTariff,
                                                  percent: (tarifaPadre ==
                                                              null ||
                                                          saveTariff
                                                                  ?.tarifaBase !=
                                                              null)
                                                      ? null
                                                      : double.tryParse(
                                                          _dividendoController
                                                              .text),
                                                );

                                                saveTariff =
                                                    saveIntTariff.copyWith();

                                                selectCategory =
                                                    categorias[index];
                                                setState(() {});
                                              },
                                              child: Text(
                                                categorias[index],
                                                style: TextStyle(
                                                  color: ColorsHelpers.darken(
                                                    selectCategory ==
                                                            categorias.first
                                                        ? DesktopColors
                                                            .vistaReserva
                                                        : DesktopColors
                                                            .vistaParcialMar,
                                                    0.15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              if (applyUpgrades && tarifaPadre == null)
                                Column(
                                  children: [
                                    TextStyles.standardText(text: "Up Grades"),
                                    const SizedBox(height: 7),
                                    Row(
                                      children: [
                                        _textFieldData(
                                          upgradeCateg,
                                          "Categoria",
                                          (p0) => upgradeCateg = double.parse(
                                              p0.isEmpty ? "0" : p0),
                                        ),
                                        const SizedBox(width: 10),
                                        _textFieldData(
                                          upgradeMenor,
                                          "Menor",
                                          (p0) => upgradeMenor = double.parse(
                                              p0.isEmpty ? "0" : p0),
                                        ),
                                        const SizedBox(width: 10),
                                        _textFieldData(
                                          upGradePaxAdic,
                                          "Pax Adic",
                                          (p0) => upGradePaxAdic = double.parse(
                                              p0.isEmpty ? "0" : p0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 22),
                              FormTariffWidget(
                                tarifaAdultoController:
                                    _tarifaAdultoSingleController,
                                tarifaAdultoTPLController:
                                    _tarifaAdultoTPLController,
                                tarifaAdultoCPLController:
                                    _tarifaAdultoCPLController,
                                tarifaPaxAdicionalController:
                                    _tarifaPaxAdicionalController,
                                tarifaMenoresController:
                                    _tarifaMenoresController,
                                onUpdate: () {
                                  if (withAutocalculation) setState(() {});
                                },
                                isEditing: tarifaPadre == null,
                                applyAutoCalculation: withAutocalculation,
                                autoCalculation: () => _autoCalculation(),
                              ),
                              if (tarifaPadre == null)
                                CustomWidgets.checkBoxWithDescription(
                                  context,
                                  title: "Autocálculo",
                                  activeColor: DesktopColors.azulCielo,
                                  description:
                                      "Esta opción permite la calculación automatica de la\ntarifas TPLE y CPLE.",
                                  value: withAutocalculation,
                                  compact: true,
                                  onChanged: (p0) {
                                    setState(() => withAutocalculation = p0!);
                                    if (withAutocalculation) {
                                      _autoCalculation();
                                      String saveTariffAdult3 =
                                          CalculatorHelpers.getRate(
                                        tarifaAdulto:
                                            (saveTariff?.tarifaAdulto1a2 ?? 0)
                                                .toString(),
                                        tarifaPaxAdicional:
                                            (saveTariff?.tarifaPaxAdicional ??
                                                    0)
                                                .toString(),
                                        numPaxAdic: 1,
                                        applyRound: false,
                                      );

                                      String saveTariffAdult4 =
                                          CalculatorHelpers.getRate(
                                        tarifaAdulto:
                                            (saveTariff?.tarifaAdulto1a2 ?? 0)
                                                .toString(),
                                        tarifaPaxAdicional:
                                            (saveTariff?.tarifaPaxAdicional ??
                                                    0)
                                                .toString(),
                                        numPaxAdic: 2,
                                        applyRound: false,
                                      );
                                      saveTariff?.tarifaAdulto3 =
                                          double.tryParse(saveTariffAdult3);
                                      saveTariff?.tarifaAdulto4 =
                                          double.tryParse(saveTariffAdult4);

                                      setState(() {});
                                    }
                                  },
                                ),
                              if (isTariffPadre)
                                CustomWidgets.checkBoxWithDescription(
                                  context,
                                  title: "Propagar cambios",
                                  description:
                                      "Esta funcion permite propagar los siguientes cambios\nhacia todos las tarifas base que se asocien a esta Tarifa.",
                                  value: applyPropageChange,
                                  compact: true,
                                  onChanged: (p0) =>
                                      setState(() => applyPropageChange = p0!),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: insideSnackBar(
                                  message: messageError,
                                  type: 'danger',
                                  showAnimation: showError,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: selectBaseTariff == null
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          if (selectBaseTariff != null)
                            Buttons.commonButton(
                              icons: HeroIcons.trash,
                              sizeIcon: 20,
                              text: "Eliminar",
                              sizeText: 12.5,
                              color: Colors.red[800],
                              onPressed: () {
                                _deleteBaseTariff();
                              },
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        Navigator.pop(context);
                                      },
                                child: TextStyles.standardText(
                                  text: "Cancelar",
                                  isBold: true,
                                  size: 12.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Buttons.commonButton(
                                color: DesktopColors.cerulean,
                                isLoading: isLoading,
                                text: "Guardar",
                                sizeText: 12.5,
                                onPressed: () async {
                                  if (!_formKeyManagerBase.currentState!
                                      .validate()) {
                                    return;
                                  }

                                  if (widget.tarifasBase.any((element) =>
                                          element.nombre ==
                                          _nombreTarifaController.text) &&
                                      selectBaseTariff?.nombre !=
                                          _nombreTarifaController.text) {
                                    messageError =
                                        "El nombre ${_nombreTarifaController.text} ya esta siendo utilizado, ingrese otro nombre";
                                    setState(() {});
                                    _toggleSnackbar();
                                    return;
                                  }

                                  if (Utility.revisedPropiertiesSaveTariff(
                                          saveTariff) &&
                                      !applyUpgrades) {
                                    messageError =
                                        "Se detectaron uno o mas campos por capturar en la categoria: ${categorias.firstWhere((element) => element != selectCategory)}*";
                                    setState(() {});
                                    _toggleSnackbar();
                                    return;
                                  }

                                  isLoading = true;
                                  setState(() {});

                                  if (!applyUpgrades) {
                                    upgradeCateg = null;
                                    upgradeMenor = null;
                                    upGradePaxAdic = null;
                                  }

                                  Tarifa nowTariff = Tarifa();
                                  // nowTariff.categoria = tipoHabitacion[
                                  //     categorias.indexOf(selectCategory)];
                                  nowTariff.tarifaAdulto1a2 = double.parse(
                                      _tarifaAdultoSingleController.text);
                                  nowTariff.tarifaAdulto3 = double.parse(
                                      _tarifaAdultoTPLController.text);
                                  nowTariff.tarifaAdulto4 = double.parse(
                                      _tarifaAdultoCPLController.text);
                                  nowTariff.tarifaPaxAdicional = double.parse(
                                      _tarifaPaxAdicionalController.text);
                                  nowTariff.tarifaMenores7a12 = double.parse(
                                      _tarifaMenoresController.text);

                                  if (selectBaseTariff?.idInt != null) {
                                    nowTariff.id = selectBaseTariff?.tarifas
                                        ?.where((element) =>
                                            element.categoria ==
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull
                                        ?.id;
                                  }

                                  if (applyUpgrades) {
                                    // saveTariff?.categoria = tipoHabitacion.last;
                                  }

                                  if (selectBaseTariff?.idInt != null) {
                                    nowTariff.id = selectBaseTariff?.tarifas
                                        ?.where((element) =>
                                            element.categoria ==
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull
                                        ?.id;
                                  }

                                  if (selectBaseTariff?.idInt != null) {
                                    saveTariff?.id = selectBaseTariff?.tarifas
                                        ?.where((element) =>
                                            element.categoria !=
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull
                                        ?.id;
                                  }

                                  if (tarifaPadre != null) {
                                    Tarifa? firstTariff = tarifaPadre?.tarifas
                                        ?.where((element) =>
                                            element.categoria ==
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull;

                                    nowTariff.tarifaAdulto1a2 = _getParentRate(
                                        firstTariff?.tarifaAdulto1a2);

                                    nowTariff.tarifaAdulto3 = _getParentRate(
                                        firstTariff?.tarifaAdulto3);

                                    nowTariff.tarifaAdulto4 = _getParentRate(
                                        firstTariff?.tarifaAdulto4);

                                    nowTariff.tarifaPaxAdicional =
                                        _getParentRate(
                                            firstTariff?.tarifaPaxAdicional);

                                    nowTariff.tarifaMenores7a12 =
                                        _getParentRate(
                                            firstTariff?.tarifaMenores7a12);

                                    Tarifa? secondTariff = tarifaPadre?.tarifas
                                        ?.where((element) =>
                                            element.categoria !=
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull;

                                    saveTariff?.tarifaAdulto1a2 =
                                        _getParentRate(
                                            secondTariff?.tarifaAdulto1a2);

                                    saveTariff?.tarifaAdulto3 = _getParentRate(
                                        secondTariff?.tarifaAdulto3);

                                    saveTariff?.tarifaAdulto4 = _getParentRate(
                                        secondTariff?.tarifaAdulto4);

                                    saveTariff?.tarifaPaxAdicional =
                                        _getParentRate(
                                            secondTariff?.tarifaPaxAdicional);

                                    saveTariff?.tarifaMenores7a12 =
                                        _getParentRate(
                                            secondTariff?.tarifaMenores7a12);
                                  }

                                  TarifaBase tarifaBase = TarifaBase(
                                      idInt: selectBaseTariff?.idInt);
                                  tarifaBase.codigo = selectBaseTariff?.codigo;
                                  tarifaBase.conAutocalculacion =
                                      withAutocalculation;
                                  tarifaBase.nombre =
                                      _nombreTarifaController.text;
                                  tarifaBase.aumIntegrado = double.tryParse(
                                      _dividendoController.text);
                                  tarifaBase.upgradeCategoria = upgradeCateg;
                                  tarifaBase.upgradeMenor = upgradeMenor;
                                  tarifaBase.upgradePaxAdic = upGradePaxAdic;
                                  tarifaBase.tarifaBase = tarifaPadre;
                                  tarifaBase.creadoPor = tarifaPadre?.creadoPor;
                                  tarifaBase.tarifas = [
                                    nowTariff,
                                    if (!applyUpgrades ||
                                        (selectBaseTariff?.idInt != null &&
                                            applyUpgrades &&
                                            saveTariff != null))
                                      saveTariff!
                                  ];

                                  if (mounted) {
                                    // String messageResponse =
                                    //     selectBaseTariff?.idInt != null
                                    //         ? await TarifaBaseService()
                                    //             .updateBaseTariff(
                                    //             tarifaBase,
                                    //             propageChanges:
                                    //                 applyPropageChange,
                                    //           )
                                    //         : await TarifaBaseService()
                                    //             .saveBaseTariff(tarifaBase);

                                    // if (messageResponse.isNotEmpty) {
                                    //   messageError =
                                    //       "Se presento el siguiente problema al registrar una nueva tarifa base: $messageResponse.";
                                    //   setState(() {});
                                    //   _toggleSnackbar();
                                    //   isLoading = false;
                                    //   setState(() {});
                                    //   return;
                                    // }

                                    // if (!mounted) return;
                                    // showSnackBar(
                                    //   context: context,
                                    //   title: "Tarifa Base creada",
                                    //   message:
                                    //       "Se creo la nueva tarifa base: ${tarifaBase.nombre}",
                                    //   type: "success",
                                    // );

                                    // Navigator.of(context).pop(true);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleSnackbar() {
    setState(() => showError = true);
    Future.delayed(5.seconds, () {
      if (mounted) setState(() => showError = false);
    });
  }

  void _selectNewBaseTariff(TarifaBase? baseTariff) {
    _updateTarifasPadre(baseTariff);
    selectBaseTariff = baseTariff;
    selectCategory = categorias.first;
    selectTarifaPadre = baseTariff?.tarifaBase?.nombre ?? 'Ninguna';
    applyPropageChange = true;
    withAutocalculation = baseTariff?.conAutocalculacion ?? false;

    if (selectBaseTariff != null) {
      _updateDataInput(selectBaseTariff);
    } else {
      applyUpgrades = false;
      withAutocalculation = true;
      upgradeCateg = null;
      upgradeMenor = null;
      upGradePaxAdic = null;
      saveTariff = null;
      _nombreTarifaController.text = '';
      _tarifaAdultoSingleController.text = '';
      _tarifaAdultoTPLController.text = '';
      _tarifaAdultoCPLController.text = '';
      _tarifaPaxAdicionalController.text = '';
      _tarifaMenoresController.text = '';
      _dividendoController.text = '';
    }
  }

  double? _getParentRate(double? rate) {
    double dividendo = double.tryParse(_dividendoController.text) ?? 0;
    double parentRate = CalculatorHelpers.getIncrease(
      (rate ?? 0),
      dividendo,
      withRound: false,
    );
    return parentRate;
  }

  void _updateDataInput(TarifaBase? selectTariff, {double? percent}) {
    applyUpgrades = selectTariff?.upgradeCategoria != null;
    if (applyUpgrades) {
      upgradeCateg = selectTariff?.upgradeCategoria;
      upgradeMenor = selectTariff?.upgradeMenor;
      upGradePaxAdic = selectTariff?.upgradePaxAdic;
    }

    _recoverySaveTariff(selectTariff);

    if (percent == null) {
      _nombreTarifaController.text = selectTariff?.nombre ?? '';
    }

    Tarifa? initTariff = selectTariff?.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.first)
        .firstOrNull;

    _dividendoController.text = (selectTariff?.aumIntegrado ?? '').toString();
    _applyDiscountTariff(initTariff, percent: percent);
  }

  void _applyDiscountTariff(Tarifa? initTariff, {double? percent}) {
    _tarifaAdultoSingleController.text = CalculatorHelpers.getIncrease(
            (initTariff?.tarifaAdulto1a2 ?? 0), percent)
        .toString();
    _tarifaAdultoTPLController.text =
        CalculatorHelpers.getIncrease((initTariff?.tarifaAdulto3 ?? 0), percent)
            .toString();
    _tarifaAdultoCPLController.text =
        CalculatorHelpers.getIncrease((initTariff?.tarifaAdulto4 ?? 0), percent)
            .toString();
    _tarifaPaxAdicionalController.text = CalculatorHelpers.getIncrease(
            (initTariff?.tarifaPaxAdicional ?? 0), percent)
        .toString();
    _tarifaMenoresController.text = CalculatorHelpers.getIncrease(
            (initTariff?.tarifaMenores7a12 ?? 0), percent)
        .toString();
  }

  void _recoverySaveTariff(TarifaBase? selectTariff) {
    saveTariff = selectTariff?.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.last)
        .firstOrNull;
  }

  Widget _buildStepItem(
    String title,
    TarifaBase? tariff, {
    bool isNew = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          _selectNewBaseTariff(tariff);
          setState(() {});
        },
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: isNew
                  ? selectBaseTariff == null
                      ? Icon(CupertinoIcons.add_circled,
                          size: 22, color: DesktopColors.turqueza)
                      : const Icon(HeroIcons.plus, size: 16)
                  : Radio<TarifaBase>(
                      value: tariff!,
                      groupValue: selectBaseTariff,
                      onChanged: (value) {
                        _selectNewBaseTariff(tariff);
                        setState(() {});
                      }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextStyles.standardText(
                text: title,
                isBold: (isNew && selectBaseTariff == null) ||
                    selectBaseTariff == tariff,
                overClip: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteBaseTariff() {
    showDialog(
      context: context,
      builder: (context) => Dialogs.customAlertDialog(
        title: "Eliminar tarifa Base",
        contentText:
            "¿Desea eliminar la tarifa base del sistema:\n${selectBaseTariff?.nombre}?",
        nameButtonMain: "Aceptar",
        funtionMain: () async {
          // String response =
          //     await TarifaBaseService().deleteBaseTariff(selectBaseTariff!);

          // if (response.isNotEmpty) {
          //   showSnackBar(
          //     context: context,
          //     title: "Error de eliminación",
          //     message:
          //         "Se presento el siguiente problema al eliminar la tarifa: $response.",
          //     type: "danger",
          //   );
          //   return;
          // } else {
          //   showSnackBar(
          //     context: context,
          //     title: "Tarifa base eliminada",
          //     message: "Se elimino la tarifa base: ${selectBaseTariff?.nombre}",
          //     type: "success",
          //     iconCustom: HeroIcons.trash,
          //   );
          //   Navigator.pop(context);
          //   Navigator.of(context).pop(true);
          // }
        },
        nameButtonCancel: "Cancelar",
        withButtonCancel: true,
        withLoadingProcess: true,
        notCloseInstant: true,
        otherButton: true,
        iconData: Icons.delete,
      ),
    );
  }

  void _autoCalculation() {
    if (withAutocalculation) {
      _tarifaAdultoTPLController.text = CalculatorHelpers.getRate(
        tarifaAdulto: _tarifaAdultoSingleController.text,
        tarifaPaxAdicional: _tarifaPaxAdicionalController.text,
        numPaxAdic: 1,
        applyRound: false,
      );
      _tarifaAdultoCPLController.text = CalculatorHelpers.getRate(
        tarifaAdulto: _tarifaAdultoSingleController.text,
        tarifaPaxAdicional: _tarifaPaxAdicionalController.text,
        numPaxAdic: 1,
        applyRound: false,
      );
    }
  }
}
