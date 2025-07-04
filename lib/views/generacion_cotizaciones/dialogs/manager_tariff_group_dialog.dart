import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/res/helpers/utility.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/widgets/form_tariff_widget.dart';
import 'package:generador_formato/res/ui/text_styles.dart';

import '../../../models/categoria_model.dart';
import '../../../models/tarifa_model.dart';
import '../../../models/tarifa_x_dia_model.dart';
import '../../../res/helpers/colors_helpers.dart';
import '../../../res/ui/buttons.dart';
import '../../../view-models/providers/categoria_provider.dart';
import '../../../view-models/providers/habitacion_provider.dart';
import '../../../utils/widgets/custom_dropdown.dart';
import '../../../utils/widgets/item_rows.dart';
import '../../../utils/widgets/select_buttons_widget.dart';
import '../../../utils/widgets/textformfield_custom.dart';

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
  bool startFlow = false, isUnknow = false, isFree = false;
  List<TarifaXDia> roomTariffs = [];
  TarifaXDia? selectTariff;
  String temporadaSelect = '';
  Tarifa? saveTariffUnknow;
  Temporada? temporadaDataSelect;
  Categoria? selectCategory;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoriasAsync = ref.watch(categoriasReqProvider(""));
    final habitaciones = widget.tarifasHabitacion != null
        ? [ref.watch(habitacionSelectProvider)]
        : ref
            .watch(HabitacionProvider.provider)
            .where((element) => !element.esCortesia)
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
                color: ColorsHelpers.darken(Theme.of(context).cardColor, 0.07),
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
                            text:
                                "Tarifa seleccionada (La tarifa inicial es la más frecuente en el periodo):",
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
                                    colorCard:
                                        roomTariffs[index].tarifaRack?.color ??
                                            DesktopColors.cerulean,
                                    title:
                                        roomTariffs[index].tarifaRack?.nombre ??
                                            '',
                                    withOutWidth: true,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    isSelect: selectTariff!.id ==
                                        roomTariffs[index].id,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: (selectTariff?.tarifaRack?.temporadas !=
                                          null &&
                                      selectTariff!
                                          .tarifaRack!.temporadas!.isNotEmpty)
                                  ? 20
                                  : 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextStyles.standardText(
                                text:
                                    selectTariff?.tarifaRack?.temporadas != null
                                        ? "Temporada: "
                                        : "Descuento de tarifa:",
                                overClip: true,
                                size: 12.6,
                              ),
                              const SizedBox(width: 10),
                              if (selectTariff?.tarifaRack?.temporadas !=
                                      null &&
                                  selectTariff!
                                      .tarifaRack!.temporadas!.isNotEmpty)
                                CustomDropdown.dropdownMenuCustom(
                                  compactWidth: 180,
                                  initialSelection: temporadaSelect,
                                  onSelected: (String? value) {
                                    temporadaDataSelect = selectTariff
                                        ?.tarifaRack?.temporadas
                                        ?.where((element) =>
                                            element.nombre == value)
                                        .toList()
                                        .firstOrNull;
                                    _applyDiscountTariff(temporadaDataSelect);
                                    setState(() {});
                                  },
                                  elements: ['No aplicar'] +
                                      Utility.getSeasonstoString(
                                        selectTariff?.tarifaRack?.temporadas,
                                        tipo: "grupal",
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
                                    onChanged: (p0) {
                                      setState(() {
                                        _applyDiscountTariff(null,
                                            descuentoText: p0);
                                      });
                                    },
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          categoriasAsync.when(
                            data: (data) {
                              return SelectButtonsWidget(
                                selectButton: selectCategory?.nombre ?? '',
                                buttons: data
                                    .map((e) => {
                                          e.nombre ?? '': e.color ??
                                              DesktopColors.grisPalido
                                        })
                                    .toList(),
                                onPressed: (index) {
                                  Tarifa? saveIntTariff;
                                  selectCategory = data[index];

                                  if (isUnknow || isFree) {
                                    saveIntTariff = Tarifa(
                                      categoria: selectCategory,
                                      idInt: selectTariff?.idInt,
                                      tarifaAdulto1a2: double.tryParse(
                                          _tarifaAdultoSingleController.text),
                                      tarifaAdulto3: double.tryParse(
                                          _tarifaAdultoTPLController.text),
                                      tarifaAdulto4: double.tryParse(
                                          _tarifaAdultoCPLController.text),
                                      tarifaMenores0a6: double.tryParse(
                                          _tarifaMenoresController.text),
                                      tarifaPaxAdicional: double.tryParse(
                                          _tarifaPaxAdicionalController.text),
                                    );
                                  }

                                  _applyDiscountTariff(
                                    temporadaDataSelect,
                                    descuentoText: _descuentoController.text,
                                  );
                                  setState(() {});

                                  if (isFree || isUnknow) {
                                    saveTariffUnknow =
                                        saveIntTariff?.copyWith();
                                    setState(() {});
                                  }
                                },
                              );
                            },
                            error: (error, stackTrace) =>
                                TextStyles.standardText(
                              text: "Error al consultar destinos",
                            ),
                            loading: () {
                              return const Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
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
                            isEditing: (isFree || isUnknow),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (selectTariff!.id != "tariffFree")
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
                                  onPressed: (habitaciones.first.id ==
                                          selectRoom?.id)
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
                              categoriasAsync.when(
                                data: (data) {
                                  return Buttons.buttonPrimary(
                                    text: selectRoom == habitaciones.last
                                        ? "Aplicar"
                                        : "Siguiente",
                                    onPressed: () {
                                      if (!_formKeyManager.currentState!
                                          .validate()) {
                                        return;
                                      }

                                      _saveChanges();
                                    },
                                  );
                                },
                                error: (error, stackTrace) =>
                                    TextStyles.standardText(
                                  text: "Error al consultar destinos",
                                ),
                                loading: () {
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
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
        Utility.getUniqueTariffs(selectRoom!.tarifasXHabitacion!);
    _selectTariff(
      roomTariffs.reduce(
        ((a, b) => a.numDays > b.numDays ? a : b),
      ),
    );
    setState(() {});
  }

  void _selectTariff(TarifaXDia? tarifa) {
    selectTariff = tarifa;
    _descuentoController.text = selectTariff?.descIntegrado?.toString() ?? '';
    temporadaDataSelect = Utility.getSeasonNow(
      RegistroTarifa(temporadas: selectTariff?.temporadas),
      DateTime.parse(selectRoom!.checkOut!)
          .difference(DateTime.parse(selectRoom!.checkIn!))
          .inDays,
      isGroup: true,
    );

    isUnknow = tarifa?.id == "Unknow";
    isFree = tarifa?.id == "tariffFree";

    int indexSeason = roomTariffs.indexOf(tarifa ?? TarifaXDia());

    if (indexSeason != -1) {
      Future.delayed(
        Durations.short2,
        () {
          if (mounted) {
            return _scrollController.animateTo((indexSeason + 0.0) * 50,
                curve: Curves.easeIn, duration: Durations.medium1);
          }
        },
      );
    }

    if (isUnknow || isFree) {
      saveTariffUnknow = selectTariff?.tarifas
          ?.where((element) =>
              element.categoria !=
              tipoHabitacion[categorias.indexOf(selectCategory)])
          .toList()
          .firstOrNull;
    }

    _applyDiscountTariff(
      temporadaDataSelect,
      descuentoProvisional: tarifa?.descIntegrado,
    );
  }

  void _applyDiscountTariff(
    Temporada? seasonSelect, {
    String descuentoText = '',
    double? descuentoProvisional,
  }) {
    temporadaSelect = seasonSelect?.nombre ?? 'No aplicar';
    TarifaTableData? selectCategoryTariff =
        ((selectRoom?.useCashSeason ?? false)
                ? selectTariff?.tarifasBase
                : selectTariff?.tarifas)
            ?.where((element) =>
                element.categoria ==
                tipoHabitacion[categorias.indexOf(selectCategory)])
            .toList()
            .firstOrNull;

    double descuento = seasonSelect?.descuento ??
        descuentoProvisional ??
        (descuentoText.isEmpty ? 0 : double.parse(descuentoText));

    if (isFree || isUnknow) descuento = 0;

    _tarifaAdultoSingleController.text = Utility.calculatePromotion(
      descuento > 100
          ? "0"
          : (selectCategoryTariff?.tarifaAdultoSGLoDBL ?? 0).toString(),
      descuento,
      returnDouble: true,
      rounded: !(isFree || isUnknow),
    ).toString();

    _tarifaAdultoTPLController.text = Utility.calculatePromotion(
      descuento > 100
          ? "0"
          : (selectCategoryTariff?.tarifaAdultoTPL ?? 0).toString(),
      descuento,
      returnDouble: true,
      rounded: !(isFree || isUnknow),
    ).toString();

    _tarifaAdultoCPLController.text = Utility.calculatePromotion(
      descuento > 100
          ? "0"
          : (selectCategoryTariff?.tarifaAdultoCPLE ?? 0).toString(),
      descuento,
      returnDouble: true,
      rounded: !(isFree || isUnknow),
    ).toString();

    _tarifaPaxAdicionalController.text = Utility.calculatePromotion(
      descuento > 100
          ? "0"
          : (selectCategoryTariff?.tarifaPaxAdicional ?? 0).toString(),
      descuento,
      returnDouble: true,
      rounded: !(isFree || isUnknow),
    ).toString();

    _tarifaMenoresController.text = Utility.calculatePromotion(
      descuento > 100
          ? "0"
          : (selectCategoryTariff?.tarifaMenores7a12 ?? 0).toString(),
      descuento,
      returnDouble: true,
      rounded: !(isFree || isUnknow),
    ).toString();
  }

  void _saveChanges() {
    if (isFree || isUnknow) {
      Categoria? _selectCategory = selectCategory?.copyWith();

      selectTariff?.tarifaRack?.registros ??= [];

      Tarifa _selectTariff = Tarifa(
        categoria: _selectCategory,
        tarifaAdulto4: double.tryParse(_tarifaAdultoCPLController.text),
        tarifaAdulto3: double.tryParse(_tarifaAdultoTPLController.text),
        tarifaAdulto1a2: double.tryParse(_tarifaAdultoSingleController.text),
        tarifaMenores7a12: double.tryParse(_tarifaMenoresController.text),
        tarifaPaxAdicional: double.tryParse(_tarifaPaxAdicionalController.text),
      );
      
      selectTariff?.tarifa = _selectTariff;

      int indexFirst = selectTariff?.tarifas
              ?.indexWhere((element) => element.categoria == _selectCategory) ??
          -1;

      if (indexFirst != -1) {
        selectTariff?.tarifas?[indexFirst] = _selectTariff;
      } else {
        selectTariff?.tarifas?.add(_selectTariff);
      }

      int indexLast = selectTariff?.tarifas?.indexWhere((element) =>
              element.categoria == (saveTariffUnknow?.categoria ?? '')) ??
          -1;

      if (indexLast != -1) {
        selectTariff?.tarifas?[indexLast] = saveTariffUnknow!;
      } else {
        selectTariff?.tarifas?.add(saveTariffUnknow!);
      }
    }

    selectTariff!.temporadaSelect = temporadaDataSelect;
    if (selectTariff?.temporadas?.isEmpty ?? true) {
      selectTariff!.descIntegrado =
          double.parse(_descuentoController.text.trim());
    }

    if (habitaciones.length == 1 && widget.tarifasHabitacion != null) {
      Navigator.of(context).pop([selectTariff]);
      return;
    }

    TarifaXDia? foundTariff = selectTariffs.firstWhere(
      (element) => element?.folioRoom == selectRoom?.id,
      orElse: () => null,
    );

    if (foundTariff != null) {
      if (foundTariff.id != selectTariff?.id) {
        int indexFound = selectTariffs
            .indexWhere((element) => element?.folioRoom == selectRoom?.id);
        if (indexFound != -1) {
          selectTariffs[indexFound] = selectTariff!;
        }
      }
    } else {
      selectTariff?.folioRoom = selectRoom?.id;
      selectTariffs.add(selectTariff!);
    }

    if (selectRoom == habitaciones.last) {
      Navigator.of(context).pop(selectTariffs);
      return;
    }

    int index = habitaciones.indexOf(selectRoom!);
    if (index != -1 && index < habitaciones.length - 1) {
      _selectNewRoom(selectRoom = habitaciones[(index + 1)]);
      setState(() {});
    }
  }
}
