import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/form_tariff_widget.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../../models/tarifa_x_dia_model.dart';
import '../../providers/habitacion_provider.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/item_rows.dart';
import '../../widgets/textformfield_custom.dart';

class ManagerTariffGroupDialog extends ConsumerStatefulWidget {
  const ManagerTariffGroupDialog({super.key});

  @override
  _ManagerTariffGroupDialogState createState() =>
      _ManagerTariffGroupDialogState();
}

class _ManagerTariffGroupDialogState
    extends ConsumerState<ManagerTariffGroupDialog> {
  final _tarifaAdultoController = TextEditingController();
  final _tarifaAdultoTPLController = TextEditingController();
  final _tarifaAdultoCPLController = TextEditingController();
  final _tarifaPaxAdicionalController = TextEditingController();
  final _tarifaMenoresController = TextEditingController();
  final _descuentoController = TextEditingController();
  Habitacion? selectRoom;
  bool startFlow = false;
  List<TarifaXDia> selectTariffs = [];
  TarifaXDia? selectTariff;
  String temporadaSelect = '';

  @override
  void dispose() {
    _tarifaAdultoController.dispose();
    _tarifaAdultoTPLController.dispose();
    _tarifaAdultoCPLController.dispose();
    _tarifaPaxAdicionalController.dispose();
    _tarifaMenoresController.dispose();
    _descuentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitaciones = ref
        .watch(HabitacionProvider.provider)
        .where((element) => !element.isFree)
        .toList();

    if (!startFlow) {
      _selectNewRoom(habitaciones.firstOrNull);
      startFlow = true;
    }

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
                    text: "Habitaciones",
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var element in habitaciones)
                          _buildStepItem(
                            "Room ${habitaciones.indexOf(element) + 1}",
                            element,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: SizedBox(
                  height: 550,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextStyles.titleText(
                          text:
                              "Gestión de temporadas para cotizaciones grupales",
                          color: Theme.of(context).primaryColor,
                          size: 17,
                        ),
                        const SizedBox(height: 8),
                        TextStyles.standardText(
                          text:
                              "Revisa, selecciona o ajusta las tarifas aplicadas para las habitaciones en esta cotización grupal."
                              " Asegúrate de que las tarifas sean correctas y coherentes con los términos de esta operación.",
                          overClip: true,
                        ),
                        const SizedBox(height: 16),
                        TextStyles.standardText(text: "Tarifa seleccionada:"),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: ListView.builder(
                                itemCount: selectTariffs.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    if (selectTariff != selectTariffs[index]) {
                                      setState(() =>
                                          selectTariff = selectTariffs[index]);
                                    }
                                  },
                                  child: ItemRows.filterItemRow(
                                    withDeleteButton: false,
                                    colorCard: selectTariffs[index].color ??
                                        DesktopColors.cerulean,
                                    title:
                                        selectTariffs[index].nombreTariff ?? '',
                                    withOutWidth: true,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    isSelect:
                                        selectTariff == selectTariffs[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextStyles.standardText(
                              text: selectTariff?.temporadas != null
                                  ? "Temporada: "
                                  : "Descuento de tarifa:",
                              overClip: true,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 10),
                            if (selectTariff?.temporadas != null &&
                                selectTariff!.temporadas!.isNotEmpty)
                              CustomDropdown.dropdownMenuCustom(
                                initialSelection: temporadaSelect,
                                onSelected: (String? value) =>
                                    setState(() => temporadaSelect = value!),
                                elements: ['No aplicar'] +
                                    Utility.getSeasonstoString(
                                      selectTariff?.temporadas,
                                      onlyGroups: true,
                                    ),
                                excepcionItem: "No aplicar",
                                // notElements: Utility.getPromocionesNoValidas(
                                //   selectRoom!,
                                //   temporadas: selectTariff?.temporadas!
                                //       .where((element) =>
                                //           element.forGroup ?? false)
                                //       .toList(),
                                // ),
                              )
                            else
                              SizedBox(
                                width: 145,
                                height: 50,
                                child:
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "Porcentaje",
                                  controller: _descuentoController,
                                  icon: const Icon(CupertinoIcons.percent,
                                      size: 20),
                                  isNumeric: true,
                                  onChanged: (p0) => setState(() {}),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        FormTariffWidget(
                          tarifaAdultoController: _tarifaAdultoController,
                          tarifaAdultoTPLController: _tarifaAdultoTPLController,
                          tarifaAdultoCPLController: _tarifaAdultoCPLController,
                          tarifaPaxAdicionalController:
                              _tarifaPaxAdicionalController,
                          tarifaMenoresController: _tarifaMenoresController,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Volver'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Siguiente'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String title, Habitacion room) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Radio<Habitacion>(
              value: room,
              groupValue: selectRoom,
              onChanged: (value) => setState(() => _selectNewRoom(room)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextStyles.standardText(
              text: title,
              isBold: selectRoom == room,
              overClip: true,
            ),
          ),
        ],
      ),
    );
  }

  void _selectNewRoom(Habitacion? room) {
    selectRoom = room;
    selectTariffs = Utility.getUniqueTariffs(selectRoom!.tarifaXDia!);
    setState(() {
      _selectTariff(selectTariffs.firstOrNull);
    });
  }

  void _selectTariff(TarifaXDia? tarifa) {
    selectTariff = selectTariffs.firstOrNull;
    _descuentoController.text =
        selectTariff?.descuentoProvisional?.toString() ?? '';
    temporadaSelect = Utility.getSeasonNow(
          RegistroTarifa(temporadas: selectTariff?.temporadas),
          DateTime.parse(selectRoom!.fechaCheckOut!)
              .difference(DateTime.parse(selectRoom!.fechaCheckIn!))
              .inDays,
          isGroup: true,
        )?.nombre ??
        'No aplicar';
    _tarifaAdultoController.text =
        (selectTariff!.tarifa!.tarifaAdultoSGLoDBL ?? 0).toString();
    _tarifaAdultoTPLController.text =
        (selectTariff!.tarifa!.tarifaAdultoTPL ?? 0).toString();
    _tarifaAdultoCPLController.text =
        (selectTariff!.tarifa!.tarifaAdultoCPLE ?? 0).toString();
    _tarifaPaxAdicionalController.text =
        (selectTariff!.tarifa!.tarifaPaxAdicional ?? 0).toString();
    _tarifaMenoresController.text =
        (selectTariff!.tarifa!.tarifaMenores7a12 ?? 0).toString();
  }
}
