import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../models/tarifa_model.dart';
import '../../../res/ui/buttons.dart';
import '../../../res/ui/inside_snackbar.dart';
import '../../../res/ui/title_page.dart';
import '../../../res/helpers/constants.dart';
import '../../../res/helpers/utility.dart';
import '../../../res/helpers/desktop_colors.dart';
import '../../../utils/widgets/form_tariff_widget.dart';
import '../../../utils/widgets/select_buttons_widget.dart';
import '../../../res/ui/text_styles.dart';

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
  List<Map<String, Color>> categoriesColor = [
    {"VISTA A LA RESERVA": DesktopColors.vistaReserva},
    {"VISTA PARCIAL AL MAR": DesktopColors.vistaParcialMar},
  ];
  Tarifa? firstTariff;
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
                    const TitlePage(
                      icons: Clarity.dollar_bill_line,
                      isDialog: true,
                      title: "Implementar tarifas en Efectivo",
                      subtitle:
                          "Gestiona tarifas especiales para cotizaciones en efectivo.",
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
                                SelectButtonsWidget(
                                  selectButton: selectCategory,
                                  buttons: categoriesColor,
                                  onPressed: (index) {
                                    Tarifa? selectTariff =
                                        firstTariff?.copyWith();

                                    Tarifa saveIntTariff = Tarifa(
                                      // categoria: tipoHabitacion[
                                      //     categorias.indexOf(selectCategory)],
                                      // id: selectTariff?.id ??
                                      //     categorias.indexOf(selectCategory),
                                      tarifaAdulto1a2:
                                          _tarifaAdultoSingleController
                                                  .text.isEmpty
                                              ? selectTariff?.tarifaAdulto1a2
                                              : double.parse(
                                                  _tarifaAdultoSingleController
                                                      .text),
                                      tarifaAdulto3: _tarifaAdultoTPLController
                                              .text.isEmpty
                                          ? selectTariff?.tarifaAdulto3
                                          : double.parse(
                                              _tarifaAdultoTPLController.text),
                                      tarifaAdulto4: _tarifaAdultoCPLController
                                              .text.isEmpty
                                          ? selectTariff?.tarifaAdulto4
                                          : double.parse(
                                              _tarifaAdultoCPLController.text),
                                      tarifaPaxAdicional:
                                          _tarifaPaxAdicionalController
                                                  .text.isEmpty
                                              ? selectTariff?.tarifaPaxAdicional
                                              : double.parse(
                                                  _tarifaPaxAdicionalController
                                                      .text),
                                      tarifaMenores7a12:
                                          _tarifaMenoresController.text.isEmpty
                                              ? selectTariff?.tarifaMenores7a12
                                              : double.parse(
                                                  _tarifaMenoresController
                                                      .text),
                                    );

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

                                    saveTariff = saveIntTariff.copyWith();

                                    setState(() =>
                                        selectCategory = categorias[index]);
                                    setState(() {});
                                  },
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

                      // nowTariff.categoria =
                      //     tipoHabitacion[categorias.indexOf(selectCategory)];
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
