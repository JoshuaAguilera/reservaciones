import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/tarifa_base_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/services/tarifa_service.dart';
import 'package:generador_formato/ui/inside_snackbar.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../ui/buttons.dart';
import '../../ui/show_snackbar.dart';
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/form_tariff_widget.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class ManagerBaseTariffDialog extends StatefulWidget {
  const ManagerBaseTariffDialog({super.key, required this.tarifasBase});

  final List<TarifaBaseInt> tarifasBase;

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
  final _descuentoController = TextEditingController();
  final _formKeyManagerBase = GlobalKey<FormState>();
  bool applyUpgrades = false;
  bool showError = false;
  Tarifa? firstTariff = Tarifa(categoria: tipoHabitacion.first);
  Tarifa? saveTariff;
  double? upgradeCateg;
  double? upgradeMenor;
  double? upGradePaxAdic;
  TarifaBaseInt? tarifaPadre;
  TarifaBaseInt? selectBaseTariff;
  String messageError = "";
  bool isLoading = false;

  @override
  void initState() {
    for (var element in widget.tarifasBase) {
      tarifasBaseTags.add(element.nombre!);
    }

    _selectNewBaseTariff(widget.tarifasBase.firstOrNull);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: 700,
        height: 570,
        child: Row(
          children: [
            Container(
              width: 190,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              decoration: BoxDecoration(
                color: Utility.darken(Theme.of(context).cardColor, 0.07),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyles.titleText(
                    text: "Tarifas Base",
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var element in widget.tarifasBase)
                          _buildStepItem(
                            element.nombre ?? '',
                            element,
                          ),
                        _buildStepItem(
                          "Nueva Tarifa",
                          null,
                          isNew: true,
                        ),
                      ],
                    ),
                  ),
                ],
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
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 35,
                                child:
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "Nombre Tarifa Base",
                                  msgError: "",
                                  controller: _nombreTarifaController,
                                  icon: const Icon(
                                    HeroIcons.square_3_stack_3d,
                                    size: 20,
                                  ),
                                  onChanged: (p0) {},
                                  marginBottom: 0,
                                ),
                              ),
                              const SizedBox(height: 12),
                              FormWidgets.inputSwitch(
                                value: applyUpgrades,
                                activeColor: Colors.amber,
                                context: context,
                                name: "Implementar upgrades automaticamente: ",
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
                                          (saveTariff?.tarifaPaxAdicional ?? '')
                                              .toString();
                                      _tarifaMenoresController.text =
                                          (saveTariff?.tarifaMenores7a12 ?? '')
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
                                              color: Utility.darken(
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
                                                  categoria: tipoHabitacion[
                                                      categorias.indexOf(
                                                          selectCategory)],
                                                  code: selectTariff.code ??
                                                      "${firstTariff?.code} - $selectCategory",
                                                  id: selectTariff.id ??
                                                      categorias.indexOf(
                                                          selectCategory),
                                                  tarifaAdulto1a2:
                                                      _tarifaAdultoSingleController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              .tarifaAdulto1a2
                                                          : double.parse(
                                                              _tarifaAdultoSingleController
                                                                  .text),
                                                  tarifaAdulto3:
                                                      _tarifaAdultoTPLController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              .tarifaAdulto3
                                                          : double.parse(
                                                              _tarifaAdultoTPLController
                                                                  .text),
                                                  tarifaAdulto4:
                                                      _tarifaAdultoCPLController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              .tarifaAdulto4
                                                          : double.parse(
                                                              _tarifaAdultoCPLController
                                                                  .text),
                                                  tarifaPaxAdicional:
                                                      _tarifaPaxAdicionalController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              .tarifaPaxAdicional
                                                          : double.parse(
                                                              _tarifaPaxAdicionalController
                                                                  .text),
                                                  tarifaMenores7a12:
                                                      _tarifaMenoresController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              .tarifaMenores7a12
                                                          : double.parse(
                                                              _tarifaMenoresController
                                                                  .text),
                                                );

                                                _tarifaAdultoSingleController
                                                    .text = (saveTariff
                                                            ?.tarifaAdulto1a2 ??
                                                        '')
                                                    .toString();
                                                _tarifaAdultoTPLController
                                                    .text = (saveTariff
                                                            ?.tarifaAdulto3 ??
                                                        '')
                                                    .toString();
                                                _tarifaAdultoCPLController
                                                    .text = (saveTariff
                                                            ?.tarifaAdulto4 ??
                                                        '')
                                                    .toString();
                                                _tarifaPaxAdicionalController
                                                    .text = (saveTariff
                                                            ?.tarifaPaxAdicional ??
                                                        '')
                                                    .toString();
                                                _tarifaMenoresController
                                                    .text = (saveTariff
                                                            ?.tarifaMenores7a12 ??
                                                        '')
                                                    .toString();

                                                saveTariff =
                                                    saveIntTariff.copyWith();

                                                setState(() => selectCategory =
                                                    categorias[index]);
                                                setState(() {});
                                              },
                                              child: Text(
                                                categorias[index],
                                                style: TextStyle(
                                                  color: Utility.darken(
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
                              if (applyUpgrades)
                                Column(
                                  children: [
                                    TextStyles.standardText(text: "Up Grades"),
                                    const SizedBox(height: 7),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 33,
                                            child: TextFormFieldCustom
                                                .textFormFieldwithBorder(
                                              name: "Categoria",
                                              msgError: "",
                                              initialValue:
                                                  upgradeCateg?.toString(),
                                              marginBottom: 0,
                                              isNumeric: true,
                                              onChanged: (p0) {
                                                upgradeCateg = double.parse(
                                                    p0.isEmpty ? "0" : p0);
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: SizedBox(
                                            height: 33,
                                            child: TextFormFieldCustom
                                                .textFormFieldwithBorder(
                                              name: "Menor",
                                              msgError: "",
                                              initialValue:
                                                  upgradeMenor?.toString(),
                                              marginBottom: 0,
                                              isNumeric: true,
                                              onChanged: (p0) {
                                                upgradeMenor = double.parse(
                                                    p0.isEmpty ? "0" : p0);
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: SizedBox(
                                            height: 33,
                                            child: TextFormFieldCustom
                                                .textFormFieldwithBorder(
                                              name: "Pax Adic",
                                              msgError: "",
                                              initialValue:
                                                  upGradePaxAdic?.toString(),
                                              marginBottom: 0,
                                              isNumeric: true,
                                              onChanged: (p0) {
                                                upGradePaxAdic = double.parse(
                                                    p0.isEmpty ? "0" : p0);
                                              },
                                            ),
                                          ),
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
                                onUpdate: () {},
                                isEditing: true,
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
                                onPressed: () {
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
                                        "El nombre ${_nombreTarifaController.text} ya esta siendo ocupado, ingrese otro nombre";
                                    setState(() {});
                                    _toggleSnackbar();
                                    return;
                                  }

                                  if (Utility.revisedPropiertiesSaveTariff(
                                          saveTariff) &&
                                      !applyUpgrades) {
                                    messageError =
                                        "Se detectaron uno o mas campos por capturar la categoria: ${categorias.firstWhere((element) => element != selectCategory)}*";
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
                                  nowTariff.categoria = tipoHabitacion[
                                      categorias.indexOf(selectCategory)];
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

                                  if (selectBaseTariff?.id != null) {
                                    nowTariff.id = selectBaseTariff?.tarifas
                                        ?.where((element) =>
                                            element.categoria ==
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull
                                        ?.id;
                                  }

                                  if (applyUpgrades) {
                                    saveTariff?.categoria = tipoHabitacion.last;
                                  }

                                  if (selectBaseTariff?.id != null) {
                                    nowTariff.id = selectBaseTariff?.tarifas
                                        ?.where((element) =>
                                            element.categoria ==
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull
                                        ?.id;
                                  }

                                  if (selectBaseTariff?.id != null) {
                                    saveTariff?.id = selectBaseTariff?.tarifas
                                        ?.where((element) =>
                                            element.categoria !=
                                            tipoHabitacion[categorias
                                                .indexOf(selectCategory)])
                                        .firstOrNull
                                        ?.id;
                                  }

                                  TarifaBaseInt tarifaBase =
                                      TarifaBaseInt(id: selectBaseTariff?.id);
                                  tarifaBase.code = selectBaseTariff?.code;
                                  tarifaBase.nombre =
                                      _nombreTarifaController.text;
                                  tarifaBase.descIntegrado = double.tryParse(
                                      _descuentoController.text);
                                  tarifaBase.upgradeCategoria = upgradeCateg;
                                  tarifaBase.upgradeMenor = upgradeMenor;
                                  tarifaBase.upgradePaxAdic = upGradePaxAdic;
                                  tarifaBase.tarifaPadre = tarifaPadre;
                                  tarifaBase.tarifas = [
                                    nowTariff,
                                    if (!applyUpgrades) saveTariff!
                                  ];

                                  String messageResponse =
                                      selectBaseTariff?.id != null
                                          ? await TarifaService()
                                              .updateBaseTariff(tarifaBase)
                                          : await TarifaService()
                                              .saveBaseTariff(tarifaBase);

                                  if (messageResponse.isNotEmpty) {
                                    messageError =
                                        "Se presento el siguiente problema al registrar una nueva tarifa base: $messageResponse.";
                                    setState(() {});
                                    _toggleSnackbar();
                                    isLoading = false;
                                    setState(() {});
                                    return;
                                  }

                                  showSnackBar(
                                    context: context,
                                    title: "Tarifa Base creada",
                                    message:
                                        "Se creo la nueva tarifa base: ${tarifaBase.nombre}",
                                    type: "success",
                                  );

                                  Navigator.of(context).pop(true);
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
    Future.delayed(5.seconds, () => setState(() => showError = false));
  }

  void _selectNewBaseTariff(TarifaBaseInt? baseTariff) {
    selectBaseTariff = baseTariff;
    selectCategory = categorias.first;
    selectTarifaPadre = baseTariff?.tarifaPadre?.nombre ?? 'Ninguna';

    if (selectBaseTariff != null) {
      _updateDataInput(selectBaseTariff);
    } else {
      applyUpgrades = false;
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
      _descuentoController.text = '';
    }
  }

  void _updateDataInput(TarifaBaseInt? selectTariff, {double? percent}) {
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

    _descuentoController.text = (selectTariff?.descIntegrado ?? '').toString();

    _applyDiscountTariff(initTariff, percent: percent);
  }

  void _applyDiscountTariff(Tarifa? initTariff, {double? percent}) {
    _tarifaAdultoSingleController.text =
        Utility.calculateIncrease((initTariff?.tarifaAdulto1a2 ?? 0), percent)
            .toString();
    _tarifaAdultoTPLController.text =
        Utility.calculateIncrease((initTariff?.tarifaAdulto3 ?? 0), percent)
            .toString();
    _tarifaAdultoCPLController.text =
        Utility.calculateIncrease((initTariff?.tarifaAdulto4 ?? 0), percent)
            .toString();
    _tarifaPaxAdicionalController.text = Utility.calculateIncrease(
            (initTariff?.tarifaPaxAdicional ?? 0), percent)
        .toString();
    _tarifaMenoresController.text =
        Utility.calculateIncrease((initTariff?.tarifaMenores7a12 ?? 0), percent)
            .toString();
  }

  void _recoverySaveTariff(TarifaBaseInt? selectTariff) {
    saveTariff = selectTariff?.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.last)
        .firstOrNull;
  }

  Widget _buildStepItem(
    String title,
    TarifaBaseInt? tariff, {
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
                  : Radio<TarifaBaseInt>(
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
        context: context,
        title: "Eliminar tarifa Base",
        contentText:
            "¿Desea eliminar la tarifa base del sistema:\n${selectBaseTariff?.nombre}?",
        nameButtonMain: "Aceptar",
        funtionMain: () async {
          String response =
              await TarifaService().deleteBaseTariff(selectBaseTariff!);

          if (response.isNotEmpty) {
            showSnackBar(
              context: context,
              title: "Error de eliminación",
              message:
                  "Se presento el siguiente problema al eliminar la tarifa: $response.",
              type: "danger",
            );
            return;
          } else {
            showSnackBar(
              context: context,
              title: "Tarifa base eliminada",
              message: "Se elimino la tarifa base: ${selectBaseTariff?.nombre}",
              type: "success",
              iconCustom: HeroIcons.trash,
            );
            Navigator.pop(context);
            Navigator.of(context).pop(true);
          }
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
}
