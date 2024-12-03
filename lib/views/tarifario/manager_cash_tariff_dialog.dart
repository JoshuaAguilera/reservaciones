import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/tarifa_model.dart';
import '../../ui/buttons.dart';
import '../../ui/inside_snackbar.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/form_tariff_widget.dart';
import '../../widgets/text_styles.dart';

class ManagerCashTariffDialog extends StatefulWidget {
  const ManagerCashTariffDialog({super.key, required this.temporada});

  final Temporada temporada;

  @override
  State<ManagerCashTariffDialog> createState() =>
      _ManagerCashTariffDialogState();
}

class _ManagerCashTariffDialogState extends State<ManagerCashTariffDialog> {
  List<String> categorias = ["VISTA A LA RESERVA", "VISTA PARCIAL AL MAR"];
  String selectCategory = "VISTA A LA RESERVA";
  Tarifa? firstTariff = Tarifa(categoria: tipoHabitacion.first);
  Tarifa? saveTariff;
  bool inProcess = false;
  bool showError = false;
  String messageError = "";
  final _formKeyCashTarriff = GlobalKey<FormState>();
  final _tarifaAdultoSingleController = TextEditingController();
  final _tarifaAdultoTPLController = TextEditingController();
  final _tarifaAdultoCPLController = TextEditingController();
  final _tarifaPaxAdicionalController = TextEditingController();
  final _tarifaMenoresController = TextEditingController();

  @override
  void dispose() {
    _tarifaAdultoSingleController.dispose();
    _tarifaAdultoTPLController.dispose();
    _tarifaAdultoCPLController.dispose();
    _tarifaMenoresController.dispose();
    _tarifaPaxAdicionalController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Tarifa? initTariff = widget.temporada.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.first)
        .firstOrNull;

    firstTariff = widget.temporada.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.first)
        .firstOrNull;
    saveTariff = widget.temporada.tarifas
        ?.where((element) => element.categoria == tipoHabitacion.last)
        .firstOrNull;

    _tarifaAdultoSingleController.text =
        (initTariff?.tarifaAdulto1a2 ?? '').toString();
    _tarifaAdultoTPLController.text =
        (initTariff?.tarifaAdulto3 ?? '').toString();
    _tarifaAdultoCPLController.text =
        (initTariff?.tarifaAdulto4 ?? '').toString();
    _tarifaPaxAdicionalController.text =
        (initTariff?.tarifaPaxAdicional ?? '').toString();
    _tarifaMenoresController.text =
        (initTariff?.tarifaMenores7a12 ?? '').toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: 500,
        height: 460,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: brightness == Brightness.light
                                    ? Colors.black87
                                    : Colors.white,
                                width: 0.5,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(9)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Clarity.dollar_bill_line,
                                size: 32,
                                color: brightness == Brightness.light
                                    ? Colors.black87
                                    : Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.titleText(
                                text: "Implementar tarifas en Efectivo",
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: 18,
                                child: TextStyles.standardText(
                                  text:
                                      "Gestiona tarifas especiales para cotizaciones en efectivo.",
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 0.6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Form(
                        key: _formKeyCashTarriff,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextStyles.standardText(
                                      text: "Categorias: "),
                                ),
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
                                                    categorias[index]) {
                                                  return;
                                                }

                                                Tarifa? selectTariff =
                                                    firstTariff?.copyWith();

                                                Tarifa saveIntTariff = Tarifa(
                                                  categoria: tipoHabitacion[
                                                      categorias.indexOf(
                                                          selectCategory)],
                                                  code: selectTariff?.code ??
                                                      "${firstTariff?.code} - $selectCategory",
                                                  id: selectTariff?.id ??
                                                      categorias.indexOf(
                                                          selectCategory),
                                                  tarifaAdulto1a2:
                                                      _tarifaAdultoSingleController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              ?.tarifaAdulto1a2
                                                          : double.parse(
                                                              _tarifaAdultoSingleController
                                                                  .text),
                                                  tarifaAdulto3:
                                                      _tarifaAdultoTPLController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              ?.tarifaAdulto3
                                                          : double.parse(
                                                              _tarifaAdultoTPLController
                                                                  .text),
                                                  tarifaAdulto4:
                                                      _tarifaAdultoCPLController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              ?.tarifaAdulto4
                                                          : double.parse(
                                                              _tarifaAdultoCPLController
                                                                  .text),
                                                  tarifaPaxAdicional:
                                                      _tarifaPaxAdicionalController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              ?.tarifaPaxAdicional
                                                          : double.parse(
                                                              _tarifaPaxAdicionalController
                                                                  .text),
                                                  tarifaMenores7a12:
                                                      _tarifaMenoresController
                                                              .text.isEmpty
                                                          ? selectTariff
                                                              ?.tarifaMenores7a12
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
                              tarifaMenoresController: _tarifaMenoresController,
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: inProcess
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child: TextStyles.standardText(
                      text: "Cancelar",
                      isBold: true,
                      color: brightness == Brightness.light
                          ? DesktopColors.cerulean
                          : DesktopColors.azulUltClaro,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Buttons.commonButton(
                    text: "Guardar",
                    isLoading: inProcess,
                    onPressed: () {
                      if (!_formKeyCashTarriff.currentState!.validate()) {
                        return;
                      }

                      if (Utility.revisedPropiertiesSaveTariff(saveTariff)) {
                        messageError =
                            "Se detectaron uno o mas campos por capturar la categoria: ${categorias.firstWhere((element) => element != selectCategory)}*";
                        setState(() {});
                        _toggleSnackbar();
                        return;
                      }

                      inProcess = true;
                      setState(() {});

                      Tarifa nowTariff = Tarifa();
                      nowTariff.id = widget.temporada.tarifas
                          ?.where((element) =>
                              element.categoria ==
                              tipoHabitacion[
                                  categorias.indexOf(selectCategory)])
                          .firstOrNull
                          ?.id;
                      nowTariff.code = widget.temporada.tarifas
                          ?.where((element) =>
                              element.categoria ==
                              tipoHabitacion[
                                  categorias.indexOf(selectCategory)])
                          .firstOrNull
                          ?.code;
                      nowTariff.categoria =
                          tipoHabitacion[categorias.indexOf(selectCategory)];
                      nowTariff.tarifaAdulto1a2 =
                          double.parse(_tarifaAdultoSingleController.text);
                      nowTariff.tarifaAdulto3 =
                          double.parse(_tarifaAdultoTPLController.text);
                      nowTariff.tarifaAdulto4 =
                          double.parse(_tarifaAdultoCPLController.text);
                      nowTariff.tarifaPaxAdicional =
                          double.parse(_tarifaPaxAdicionalController.text);
                      nowTariff.tarifaMenores7a12 =
                          double.parse(_tarifaMenoresController.text);

                      Navigator.of(context).pop([nowTariff, saveTariff!]);
                    },
                  ),
                ],
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
}
