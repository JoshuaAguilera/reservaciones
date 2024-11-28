import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../ui/buttons.dart';
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/form_tariff_widget.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class ManagerBaseTariffDialog extends StatefulWidget {
  const ManagerBaseTariffDialog({super.key});

  @override
  State<ManagerBaseTariffDialog> createState() =>
      _ManagerBaseTariffDialogState();
}

class _ManagerBaseTariffDialogState extends State<ManagerBaseTariffDialog> {
  List<String> categorias = ["VISTA A LA RESERVA", "VISTA PARCIAL AL MAR"];
  String selectCategory = "VISTA A LA RESERVA";
  final _tarifaAdultoSingleController = TextEditingController();
  final _tarifaAdultoTPLController = TextEditingController();
  final _tarifaAdultoCPLController = TextEditingController();
  final _tarifaPaxAdicionalController = TextEditingController();
  final _tarifaMenoresController = TextEditingController();
  final _descuentoController = TextEditingController();
  final _formKeyManagerBase = GlobalKey<FormState>();
  bool applyUpgrades = false;
  String selectTarifaPadre = "Ninguna";
  TarifaData? firstTariff = TarifaData(
    id: 0,
    categoria: tipoHabitacion.first,
    code: "new_tariff",
  );
  TarifaData? saveTariff;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: 700,
        height: 550,
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
                  AbsorbPointer(
                    absorbing: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                child: SizedBox(
                  height: 550,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: _formKeyManagerBase,
                        child: SizedBox(
                          height: 460,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextStyles.titleText(
                                  text:
                                      "Gestión de Tarifas Base para Tarifario",
                                  color: Theme.of(context).primaryColor,
                                  size: 17,
                                ),
                                const SizedBox(height: 8),
                                TextStyles.standardText(
                                  text:
                                      "Revisa, edita, elimina o actualiza las tarifas base principales para optimizar el tarifario. Esto permitirá generar de forma ágil y precisa las tarifas definitivas adaptadas para las cotizaciones.",
                                  overClip: true,
                                  size: 12.6,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        TextStyles.standardText(
                                          text: "Tarifa Base Padre:",
                                          overClip: true,
                                          color: Theme.of(context).primaryColor,
                                          size: 12.6,
                                        ),
                                        const SizedBox(width: 10),
                                        CustomDropdown.dropdownMenuCustom(
                                          compactWidth: 180,
                                          initialSelection: selectTarifaPadre,
                                          onSelected: (String? value) {},
                                          elements: ['Ninguna'],
                                          excepcionItem: "Ninguna",
                                          compact: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 33,
                                      child: Opacity(
                                        opacity: selectTarifaPadre == "Ninguna"
                                            ? 0.6
                                            : 1,
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Desc. ",
                                          controller: _descuentoController,
                                          msgError: "",
                                          icon: const Icon(
                                            EvaIcons.percent,
                                            size: 20,
                                          ),
                                          isNumeric: true,
                                          onChanged: (p0) {},
                                          marginBottom: 0,
                                          blocked:
                                              selectTarifaPadre == "Ninguna",
                                          readOnly:
                                              selectTarifaPadre == "Ninguna",
                                          isRequired:
                                              selectTarifaPadre != "Ninguna",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
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
                                            (saveTariff?.tarifaAdultoSGLoDBL ??
                                                    '')
                                                .toString();
                                        _tarifaAdultoTPLController.text =
                                            (saveTariff?.tarifaAdultoTPL ?? '')
                                                .toString();
                                        _tarifaAdultoCPLController.text =
                                            (saveTariff?.tarifaAdultoCPLE ?? '')
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 3),
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

                                                  TarifaData? selectTariff =
                                                      firstTariff!.copyWith();

                                                  TarifaData saveIntTariff =
                                                      TarifaData(
                                                    categoria: tipoHabitacion[
                                                        categorias.indexOf(
                                                            selectCategory)],
                                                    code: selectTariff.code ??
                                                        "${firstTariff?.code} - $selectCategory",
                                                    fecha: selectTariff.fecha ??
                                                        DateTime.now(),
                                                    id: selectTariff?.id ??
                                                        categorias.indexOf(
                                                            selectCategory),
                                                    tarifaAdultoSGLoDBL:
                                                        _tarifaAdultoSingleController
                                                                .text.isEmpty
                                                            ? selectTariff
                                                                .tarifaAdultoSGLoDBL
                                                            : double.parse(
                                                                _tarifaAdultoSingleController
                                                                    .text),
                                                    tarifaAdultoTPL:
                                                        _tarifaAdultoTPLController
                                                                .text.isEmpty
                                                            ? selectTariff
                                                                .tarifaAdultoTPL
                                                            : double.parse(
                                                                _tarifaAdultoTPLController
                                                                    .text),
                                                    tarifaAdultoCPLE:
                                                        _tarifaAdultoCPLController
                                                                .text.isEmpty
                                                            ? selectTariff
                                                                .tarifaAdultoCPLE
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
                                                              ?.tarifaAdultoSGLoDBL ??
                                                          '')
                                                      .toString();
                                                  _tarifaAdultoTPLController
                                                      .text = (saveTariff
                                                              ?.tarifaAdultoTPL ??
                                                          '')
                                                      .toString();
                                                  _tarifaAdultoCPLController
                                                      .text = (saveTariff
                                                              ?.tarifaAdultoCPLE ??
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

                                                  setState(() =>
                                                      selectCategory =
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
                                      TextStyles.standardText(
                                          text: "Up Grades"),
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
                                                marginBottom: 0,
                                                isNumeric: true,
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
                                                marginBottom: 0,
                                                isNumeric: true,
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
                                                marginBottom: 0,
                                                isNumeric: true,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: TextStyles.standardText(
                              text: "Cancelar",
                              isBold: true,
                              size: 12.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: DesktopColors.cerulean),
                            onPressed: () {
                              if (!_formKeyManagerBase.currentState!.validate())
                                return;

                              
                            },
                            child: TextStyles.standardText(
                              text: "Guardar",
                              size: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String title, TemporadaData season) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          // SizedBox(
          //   height: 20,
          //   width: 20,
          //   child: Radio<Habitacion>(
          //     value: season,
          //     groupValue: selectRoom,
          //     onChanged: (value) => setState(() => _selectNewRoom(season)),
          //   ),
          // ),
          // const SizedBox(width: 8),
          // Expanded(
          //   child: TextStyles.standardText(
          //     text: title,
          //     isBold: selectRoom == season,
          //     overClip: true,
          //   ),
          // ),
        ],
      ),
    );
  }
}
