import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/form_tariff_widget.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../../models/tarifa_x_dia_model.dart';
import '../../providers/habitacion_provider.dart';
import '../../ui/buttons.dart';
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
  final _scrollController = ScrollController(initialScrollOffset: 0);
  Habitacion? selectRoom;
  bool startFlow = false;
  List<TarifaXDia> selectTariffs = [];
  TarifaXDia? selectTariff;
  String temporadaSelect = '';
  TemporadaData? temporadaDataSelect;
  List<String> categorias = ["VISTA A LA RESERVA", "VISTA PARCIAL AL MAR"];
  String selectCategory = "VISTA A LA RESERVA";

  @override
  void dispose() {
    _tarifaAdultoController.dispose();
    _tarifaAdultoTPLController.dispose();
    _tarifaAdultoCPLController.dispose();
    _tarifaPaxAdicionalController.dispose();
    _tarifaMenoresController.dispose();
    _descuentoController.dispose();
    _scrollController.dispose();
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
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                child: SizedBox(
                  height: 550,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
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
                                  " Asegúrate de que las tarifas y temporadas grupales sean correctas y coherentes con los términos de esta operación.",
                              overClip: true,
                              size: 12.6,
                            ),
                            const SizedBox(height: 16),
                            TextStyles.standardText(
                              text: "Tarifa seleccionada:",
                              size: 12.6,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: ListView.builder(
                                  itemCount: selectTariffs.length,
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      if (selectTariff !=
                                          selectTariffs[index]) {
                                        setState(() => _selectTariff(
                                            selectTariffs[index]));
                                      }
                                    },
                                    child: ItemRows.filterItemRow(
                                      withDeleteButton: false,
                                      colorCard: selectTariffs[index].color ??
                                          DesktopColors.cerulean,
                                      title:
                                          selectTariffs[index].nombreTariff ??
                                              '',
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
                            SizedBox(
                                height: (selectTariff?.temporadas != null &&
                                        selectTariff!.temporadas!.isNotEmpty)
                                    ? 20
                                    : 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextStyles.standardText(
                                  text: selectTariff?.temporadas != null
                                      ? "Temporada: "
                                      : "Descuento de tarifa:",
                                  overClip: true,
                                  color: Theme.of(context).primaryColor,
                                  size: 12.6,
                                ),
                                const SizedBox(width: 10),
                                if (selectTariff?.temporadas != null &&
                                    selectTariff!.temporadas!.isNotEmpty)
                                  CustomDropdown.dropdownMenuCustom(
                                    compactWidth: 180,
                                    initialSelection: temporadaSelect,
                                    onSelected: (String? value) {
                                      temporadaDataSelect = selectTariff
                                          ?.temporadas
                                          ?.where((element) =>
                                              element.nombre == value)
                                          .toList()
                                          .firstOrNull;
                                      _applyDiscountTariff(temporadaDataSelect);
                                      setState(() {});
                                    },
                                    elements: ['No aplicar'] +
                                        Utility.getSeasonstoString(
                                          selectTariff?.temporadas,
                                          onlyGroups: true,
                                        ),
                                    excepcionItem: "No aplicar",
                                    compact: true,
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
                                    height: 40,
                                    child: TextFormFieldCustom
                                        .textFormFieldwithBorder(
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
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                              selectCategory == categorias.first
                                                  ? DesktopColors.vistaReserva
                                                  : DesktopColors
                                                      .vistaParcialMar,
                                              -0.15),
                                          onPressed: () {
                                            if (selectCategory ==
                                                categorias[index]) return;

                                            setState(() => selectCategory =
                                                categorias[index]);
                                            _applyDiscountTariff(
                                                temporadaDataSelect);
                                            setState(() {});
                                          },
                                          child: Text(
                                            categorias[index],
                                            style: TextStyle(
                                              color: Utility.darken(
                                                selectCategory ==
                                                        categorias.first
                                                    ? DesktopColors.vistaReserva
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
                            const SizedBox(height: 22),
                            FormTariffWidget(
                              tarifaAdultoController: _tarifaAdultoController,
                              tarifaAdultoTPLController:
                                  _tarifaAdultoTPLController,
                              tarifaAdultoCPLController:
                                  _tarifaAdultoCPLController,
                              tarifaPaxAdicionalController:
                                  _tarifaPaxAdicionalController,
                              tarifaMenoresController: _tarifaMenoresController,
                            ),
                          ],
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
                              text: "AutoGestionar",
                              isBold: true,
                              size: 12.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: DesktopColors.cerulean),
                            onPressed: () {},
                            child: TextStyles.standardText(
                              text: selectRoom == habitaciones.last
                                  ? "Aplicar"
                                  : "Siguiente",
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
    setState(
      () => _selectTariff(
        selectTariffs.reduce(
          ((a, b) => a.numDays > b.numDays ? a : b),
        ),
      ),
    );
  }

  void _selectTariff(TarifaXDia? tarifa) {
    selectTariff = tarifa;
    _descuentoController.text =
        selectTariff?.descuentoProvisional?.toString() ?? '';
    temporadaDataSelect = Utility.getSeasonNow(
      RegistroTarifa(temporadas: selectTariff?.temporadas),
      DateTime.parse(selectRoom!.fechaCheckOut!)
          .difference(DateTime.parse(selectRoom!.fechaCheckIn!))
          .inDays,
      isGroup: true,
    );

    int indexSeason = selectTariffs.indexOf(tarifa ?? TarifaXDia());

    if (indexSeason != -1) {
      Future.delayed(
        Durations.short2,
        () => _scrollController.animateTo((indexSeason + 0.0) * 50,
            curve: Curves.easeIn, duration: Durations.medium1),
      );
    }
    _applyDiscountTariff(temporadaDataSelect);
  }

  void _applyDiscountTariff(TemporadaData? seasonSelect) {
    temporadaSelect = seasonSelect?.nombre ?? 'No aplicar';

    TarifaData? tarifaSelect = selectTariff?.tarifas
        ?.where((element) =>
            element.categoria ==
            tipoHabitacion[categorias.indexOf(selectCategory)])
        .toList()
        .firstOrNull;

    _tarifaAdultoController.text = Utility.applyDiscount(
      tarifaSelect?.tarifaAdultoSGLoDBL ?? 0,
      seasonSelect?.porcentajePromocion ??
          double.parse(
            _descuentoController.text.isEmpty ? "0" : _descuentoController.text,
          ),
    ).toString();
    _tarifaAdultoTPLController.text = Utility.applyDiscount(
      tarifaSelect?.tarifaAdultoTPL ?? 0,
      seasonSelect?.porcentajePromocion ??
          double.parse(
            _descuentoController.text.isEmpty ? "0" : _descuentoController.text,
          ),
    ).toString();
    _tarifaAdultoCPLController.text = Utility.applyDiscount(
            tarifaSelect?.tarifaAdultoCPLE ?? 0,
            seasonSelect?.porcentajePromocion ??
                double.parse(
                  _descuentoController.text.isEmpty
                      ? "0"
                      : _descuentoController.text,
                ))
        .toString();
    _tarifaPaxAdicionalController.text = Utility.applyDiscount(
      tarifaSelect?.tarifaPaxAdicional ?? 0,
      seasonSelect?.porcentajePromocion ??
          double.parse(
            _descuentoController.text.isEmpty ? "0" : _descuentoController.text,
          ),
    ).toString();
    _tarifaMenoresController.text = Utility.applyDiscount(
      tarifaSelect?.tarifaMenores7a12 ?? 0,
      seasonSelect?.porcentajePromocion ??
          double.parse(
            _descuentoController.text.isEmpty ? "0" : _descuentoController.text,
          ),
    ).toString();
  }
}
