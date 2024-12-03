import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
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
  const ManagerTariffGroupDialog({super.key, this.tarifasHabitacion});

  final List<TarifaXDia>? tarifasHabitacion;

  @override
  _ManagerTariffGroupDialogState createState() =>
      _ManagerTariffGroupDialogState();
}

class _ManagerTariffGroupDialogState
    extends ConsumerState<ManagerTariffGroupDialog> {
  final _tarifaAdultoSingleController = TextEditingController();
  final _tarifaAdultoTPLController = TextEditingController();
  final _tarifaAdultoCPLController = TextEditingController();
  final _tarifaPaxAdicionalController = TextEditingController();
  final _tarifaMenoresController = TextEditingController();
  final _descuentoController = TextEditingController();
  final _scrollController = ScrollController(initialScrollOffset: 0);
  Habitacion? selectRoom;
  bool startFlow = false;
  List<TarifaXDia> roomTariffs = [];
  TarifaXDia? selectTariff;
  String temporadaSelect = '';
  Temporada? temporadaDataSelect;
  List<String> categorias = ["VISTA A LA RESERVA", "VISTA PARCIAL AL MAR"];
  String selectCategory = "VISTA A LA RESERVA";
  final _formKeyManager = GlobalKey<FormState>();
  List<TarifaXDia?> selectTariffs = [];

  @override
  void dispose() {
    _tarifaAdultoSingleController.dispose();
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
    final habitaciones = widget.tarifasHabitacion != null
        ? [ref.watch(habitacionSelectProvider)]
        : ref
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
                    text: widget.tarifasHabitacion != null
                        ? "Operación"
                        : "Habitaciones",
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                  const SizedBox(height: 15),
                  AbsorbPointer(
                    absorbing: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var element in habitaciones)
                            _buildStepItem(
                              widget.tarifasHabitacion != null
                                  ? "Habitación actual"
                                  : "Room ${habitaciones.indexOf(element) + 1}",
                              element,
                            ),
                        ],
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
                  child: Form(
                    key: _formKeyManager,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextStyles.titleText(
                            text:
                                "Gestión de tarifas ${widget.tarifasHabitacion != null ? "en la habitación actual" : "para cotizaciones grupales"}",
                            color: Theme.of(context).primaryColor,
                            size: 17,
                          ),
                          const SizedBox(height: 8),
                          TextStyles.standardText(
                            text:
                                "Revisa, selecciona o ajusta ${widget.tarifasHabitacion != null ? "la tarifa seleccionada en la habitación actual" : "las tarifas aplicadas para las habitaciones"} en esta cotización grupal."
                                " Asegúrate de que las tarifas y temporadas grupales sean correctas y coherentes con los términos de esta operación.",
                            overClip: true,
                            size: 12.6,
                          ),
                          const SizedBox(height: 16),
                          TextStyles.standardText(
                            text: "Tarifa seleccionada (La tarifa inicial es la más frecuente):",
                            size: 12.6,
                          ),
                          Padding(
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
                                itemCount: roomTariffs.length,
                                controller: _scrollController,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    if (selectTariff != roomTariffs[index]) {
                                      setState(() =>
                                          _selectTariff(roomTariffs[index]));
                                    }
                                  },
                                  child: ItemRows.filterItemRow(
                                    withDeleteButton: false,
                                    colorCard: roomTariffs[index].color ??
                                        DesktopColors.cerulean,
                                    title:
                                        roomTariffs[index].nombreTariff ?? '',
                                    withOutWidth: true,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    isSelect: selectTariff!.code ==
                                        roomTariffs[index].code,
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
                                )
                              else
                                SizedBox(
                                  width: 145,
                                  height: 40,
                                  child: TextFormFieldCustom
                                      .textFormFieldwithBorder(
                                    name: "Porcentaje",
                                    controller: _descuentoController,
                                    msgError: "",
                                    icon: const Icon(CupertinoIcons.percent,
                                        size: 20),
                                    isNumeric: true,
                                    onChanged: (p0) => setState(() =>
                                        _applyDiscountTariff(null,
                                            descuentoText: p0)),
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: StatefulBuilder(
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: 2,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 3),
                                      child: SelectableButton(
                                        selected:
                                            selectCategory == categorias[index],
                                        roundActive: 6,
                                        round: 6,
                                        color: Utility.darken(
                                            selectCategory == categorias.first
                                                ? DesktopColors.vistaReserva
                                                : DesktopColors.vistaParcialMar,
                                            -0.15),
                                        onPressed: () {
                                          if (selectCategory ==
                                              categorias[index]) return;

                                          setState(() => selectCategory =
                                              categorias[index]);
                                          _applyDiscountTariff(
                                            temporadaDataSelect,
                                            descuentoText:
                                                _descuentoController.text,
                                          );
                                          setState(() {});
                                        },
                                        child: Text(
                                          categorias[index],
                                          style: TextStyle(
                                            color: Utility.darken(
                                              selectCategory == categorias.first
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (selectTariff!.code != "tariffFree")
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                        widget.tarifasHabitacion != null
                                            ? List<TarifaXDia>.empty()
                                            : null);
                                  },
                                  child: TextStyles.standardText(
                                    text: "AutoGestionar",
                                    isBold: true,
                                    size: 12.5,
                                  ),
                                ),
                              if (widget.tarifasHabitacion == null)
                                const SizedBox(width: 8),
                              if (widget.tarifasHabitacion == null)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          DesktopColors.ceruleanOscure),
                                  onPressed: (habitaciones
                                              .first.folioHabitacion ==
                                          selectRoom?.folioHabitacion)
                                      ? null
                                      : () {
                                          int index =
                                              habitaciones.indexOf(selectRoom!);
                                          if (index != -1) {
                                            _selectNewRoom(selectRoom =
                                                habitaciones[(index - 1)]);
                                            setState(() {});
                                          }
                                        },
                                  child: TextStyles.standardText(
                                    text: "Anterior",
                                    size: 12.5,
                                  ),
                                ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: DesktopColors.cerulean),
                                onPressed: () {
                                  if (!_formKeyManager.currentState!
                                      .validate()) {
                                    return;
                                  }

                                  selectTariff!.temporadaSelect =
                                      temporadaDataSelect;
                                  if (selectTariff?.temporadas?.isEmpty ??
                                      true) {
                                    selectTariff!.descuentoProvisional =
                                        double.parse(
                                            _descuentoController.text.trim());
                                  }

                                  if (habitaciones.length == 1 &&
                                      widget.tarifasHabitacion != null) {
                                    Navigator.of(context).pop([selectTariff]);
                                    return;
                                  }

                                  TarifaXDia? foundTariff =
                                      selectTariffs.firstWhere(
                                          (element) =>
                                              element?.folioRoom ==
                                              selectRoom?.folioHabitacion,
                                          orElse: () => null);

                                  if (foundTariff != null) {
                                    if (foundTariff.code !=
                                        selectTariff?.code) {
                                      int indexFound = selectTariffs.indexWhere(
                                          (element) =>
                                              element?.folioRoom ==
                                              selectRoom?.folioHabitacion);
                                      if (indexFound != -1) {
                                        selectTariffs[indexFound] =
                                            selectTariff!;
                                      }
                                    }
                                  } else {
                                    selectTariff?.folioRoom =
                                        selectRoom?.folioHabitacion;
                                    selectTariffs.add(selectTariff!);
                                  }

                                  if (selectRoom == habitaciones.last) {
                                    Navigator.of(context).pop(selectTariffs);
                                    return;
                                  }

                                  int index = habitaciones.indexOf(selectRoom!);
                                  if (index != -1 &&
                                      index < habitaciones.length - 1) {
                                    _selectNewRoom(
                                        selectRoom = habitaciones[(index + 1)]);
                                    setState(() {});
                                  }
                                },
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
    roomTariffs = widget.tarifasHabitacion ??
        Utility.getUniqueTariffs(selectRoom!.tarifaXDia!);
    _selectTariff(
      roomTariffs.reduce(
        ((a, b) => a.numDays > b.numDays ? a : b),
      ),
    );
    setState(() {});
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

    int indexSeason = roomTariffs.indexOf(tarifa ?? TarifaXDia());

    if (indexSeason != -1) {
      Future.delayed(
        Durations.short2,
        () => _scrollController.animateTo((indexSeason + 0.0) * 50,
            curve: Curves.easeIn, duration: Durations.medium1),
      );
    }
    _applyDiscountTariff(
      temporadaDataSelect,
      descuentoProvisional: tarifa?.descuentoProvisional,
    );
  }

  void _applyDiscountTariff(
    Temporada? seasonSelect, {
    String descuentoText = '',
    double? descuentoProvisional,
  }) {
    temporadaSelect = seasonSelect?.nombre ?? 'No aplicar';
    TarifaData? selectCategoryTariff = selectTariff?.tarifas
        ?.where((element) =>
            element.categoria ==
            tipoHabitacion[categorias.indexOf(selectCategory)])
        .toList()
        .firstOrNull;

    double descuento = seasonSelect?.porcentajePromocion ??
        descuentoProvisional ??
        (descuentoText.isEmpty ? 0 : double.parse(descuentoText));

    _tarifaAdultoSingleController.text = Utility.calculatePromotion(
            descuento > 100
                ? "0"
                : (selectCategoryTariff?.tarifaAdultoSGLoDBL ?? 0).toString(),
            descuento,
            returnDouble: true)
        .toString();

    _tarifaAdultoTPLController.text = Utility.calculatePromotion(
            descuento > 100
                ? "0"
                : (selectCategoryTariff?.tarifaAdultoTPL ?? 0).toString(),
            descuento,
            returnDouble: true)
        .toString();

    _tarifaAdultoCPLController.text = Utility.calculatePromotion(
            descuento > 100
                ? "0"
                : (selectCategoryTariff?.tarifaAdultoCPLE ?? 0).toString(),
            descuento,
            returnDouble: true)
        .toString();

    _tarifaPaxAdicionalController.text = Utility.calculatePromotion(
            descuento > 100
                ? "0"
                : (selectCategoryTariff?.tarifaPaxAdicional ?? 0).toString(),
            descuento,
            returnDouble: true)
        .toString();

    _tarifaMenoresController.text = Utility.calculatePromotion(
            descuento > 100
                ? "0"
                : (selectCategoryTariff?.tarifaMenores7a12 ?? 0).toString(),
            descuento,
            returnDouble: true)
        .toString();
  }
}
