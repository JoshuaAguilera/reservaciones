import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/view-models/providers/habitacion_provider.dart';
import 'package:generador_formato/view-models/providers/usuario_provider.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:generador_formato/res/ui/custom_widgets.dart';
import 'package:generador_formato/res/ui/inside_snackbar.dart';
import 'package:generador_formato/res/ui/title_page.dart';
import 'package:generador_formato/res/helpers/constants.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:generador_formato/res/helpers/utility.dart';
import 'package:generador_formato/utils/shared_preferences/settings.dart';
import 'package:generador_formato/utils/widgets/custom_dropdown.dart';
import 'package:generador_formato/utils/widgets/dialogs.dart';
import 'package:generador_formato/utils/widgets/form_tariff_widget.dart';
import 'package:generador_formato/res/ui/text_styles.dart';
import 'package:generador_formato/utils/widgets/textformfield_custom.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart' as acd;

import '../../../models/tarifa_model.dart';
import '../../../models/tarifa_x_habitacion_model.dart';
import '../../../view-models/providers/tarifario_provider.dart';
import '../../../res/ui/progress_indicator.dart';
import '../../../utils/widgets/select_buttons_widget.dart';

class ManagerTariffSingleDialog extends ConsumerStatefulWidget {
  const ManagerTariffSingleDialog({
    super.key,
    required this.tarifaXHabitacion,
    this.isAppling = false,
    required this.numDays,
  });

  final TarifaXHabitacion tarifaXHabitacion;
  final bool isAppling;
  final int numDays;

  @override
  _ManagerTariffDayWidgetState createState() => _ManagerTariffDayWidgetState();
}

class _ManagerTariffDayWidgetState
    extends ConsumerState<ManagerTariffSingleDialog> {
  bool applyAllTariff = false;
  bool applyAllDays = false;
  bool applyAllNoTariff = false;
  bool applyAllCategory = false;
  bool isUnknow = false;
  bool isFreeTariff = false;
  bool showErrorTariff = false;
  final _formKeyTariffDay = GlobalKey<FormState>();
  List<String> categorias = ["VISTA A LA RESERVA", "VISTA PARCIAL AL MAR"];
  String selectCategory = "VISTA A LA RESERVA";
  List<Map<String, Color>> categoriesColor = [
    {"VISTA A LA RESERVA": DesktopColors.vistaReserva},
    {"VISTA PARCIAL AL MAR": DesktopColors.vistaParcialMar},
  ];
  TarifaTableData? saveTariff;
  bool startFlow = false;

  Map<String, RegistroTarifa?>? selectItemTariff;
  Color colorTariff = DesktopColors.cerulean;
  bool isEditing = false;
  bool canBeReset = false;
  bool startFlowTariff = false;
  List<Map<String, RegistroTarifa?>> itemsTariff = [];
  List<Temporada>? seasons;
  Temporada? selectSeason;
  List<TarifaTableData>? tariffs;
  TarifaTableData? selectTariff;
  List<TarifaTableData>? baseTariffs;

  List<String> promociones = ["No aplicar"];
  final TextEditingController _tarifaAdultoController =
      TextEditingController(text: "");
  final TextEditingController _tarifaAdultoTPLController =
      TextEditingController(text: "");
  final TextEditingController _tarifaAdultoCPLController =
      TextEditingController(text: "");
  final TextEditingController _tarifaMenoresController =
      TextEditingController(text: "");
  final TextEditingController _tarifaPaxAdicionalController =
      TextEditingController(text: "");
  final TextEditingController _descuentoController = TextEditingController();

  @override
  void initState() {
    _descuentoController.text =
        (widget.tarifaXHabitacion.descIntegrado ?? 0).toString();
    isUnknow = widget.tarifaXHabitacion.id!.contains("Unknow");
    seasons = widget.tarifaXHabitacion.temporadas;
    selectSeason = widget.tarifaXHabitacion.temporadaSelect;
    selectTariff = widget.tarifaXHabitacion.tarifa;
    tariffs = widget.tarifaXHabitacion.tarifas;
    baseTariffs = widget.tarifaXHabitacion.tarifasBase;
    isFreeTariff = widget.tarifaXHabitacion.id!.contains("tariffFree");
    colorTariff = widget.tarifaXHabitacion.color ?? DesktopColors.ceruleanOscure;
    isEditing = isFreeTariff
        ? true
        : (isUnknow)
            ? (widget.tarifaXHabitacion.tariffCode == null)
                ? true
                : (widget.tarifaXHabitacion.modificado ?? false)
            : (widget.tarifaXHabitacion.modificado ?? false);
    canBeReset = (widget.tarifaXHabitacion.tarifasBase ?? List.empty()).isNotEmpty;

    applyTariffData();

    super.initState();
  }

  void applyTariffData() {
    if (selectTariff != null) {
      _insertTariffForm(selectTariff);
      getSaveTariff();

      selectCategory = categorias[tipoHabitacion
          .indexOf(selectTariff?.categoria ?? tipoHabitacion.first)];
    }
  }

  void getSaveTariff({List<TarifaTableData>? selectTarifas}) {
    TarifaTableData? detectTarifa = (selectTarifas ??
            tariffs ??
            List<TarifaTableData>.empty())
        .where(
            (element) => element.categoria != (selectTariff?.categoria ?? ""))
        .toList()
        .firstOrNull;

    if (detectTarifa != null) saveTariff = detectTarifa.copyWith();
  }

  void _insertTariffForm(TarifaTableData? tarifa) {
    _tarifaAdultoController.text =
        (tarifa?.tarifaAdultoSGLoDBL ?? '').toString();
    _tarifaAdultoTPLController.text =
        (tarifa?.tarifaAdultoTPL ?? '').toString();
    _tarifaAdultoCPLController.text =
        (tarifa?.tarifaAdultoCPLE ?? '').toString();
    _tarifaMenoresController.text =
        (tarifa?.tarifaMenores7a12 ?? '').toString();
    _tarifaPaxAdicionalController.text =
        (tarifa?.tarifaPaxAdicional ?? '').toString();
  }

  @override
  void dispose() {
    _tarifaAdultoController.dispose();
    _tarifaAdultoTPLController.dispose();
    _tarifaAdultoCPLController.dispose();
    _tarifaMenoresController.dispose();
    _tarifaPaxAdicionalController.dispose();
    _descuentoController.dispose();
    super.dispose();
  }

  void _toggleSnackbar() {
    setState(() => showErrorTariff = true);
    Future.delayed(5.seconds, () {
      if (mounted) {
        setState(() => showErrorTariff = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final habitacionProvider = ref.watch(habitacionSelectProvider);
    double tariffAdult = calculateTariffAdult(habitacionProvider.adultos!);
    double tariffChildren =
        calculateTariffMenor(habitacionProvider.menores7a12!);
    double totalTariff = !isEditing
        ? Utility.formatNumberRound((tariffAdult + tariffChildren))
            .roundToDouble()
        : (tariffAdult + tariffChildren);
    double descTariff = !isEditing
        ? -(calculateDiscount(totalTariff)).roundToDouble()
        : -calculateDiscount(totalTariff);
    final typeQuote = ref.watch(typeQuoteProvider);
    final useCashSeason = ref.watch(useCashSeasonProvider);
    final useCashRoomSeason = ref.watch(useCashSeasonRoomProvider);
    final usuario = ref.watch(userProvider);
    final tarifaProvider = ref.watch(allTarifaProvider(""));

    if (!startFlow && selectTariff == null) {
      selectCategory =
          categorias[tipoHabitacion.indexOf(habitacionProvider.categoria!)];
      startFlow = true;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
      elevation: 15,
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      titlePadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.fromLTRB(25, 5, 25, 20),
      title: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            TitlePage(
              icons: HeroIcons.calendar,
              isDialog: true,
              sizeTitle: 18,
              title: widget.isAppling
                  ? "Aplicar nueva Tarifa ${typeQuote ? "Grupal " : ""}libre"
                  : "Modificar tarifa del ${Utility.getCompleteDate(data: widget.tarifaXHabitacion.fecha)}",
              subtitle: widget.isAppling
                  ? Utility.getPeriodReservation([habitacionProvider])
                  : "Tarifa aplicada: ${widget.tarifaXHabitacion.nombreTariff} ${widget.tarifaXHabitacion.subCode != null ? "(modificada)" : ""}",
            ),
            const SizedBox(height: 10),
            Divider(color: Theme.of(context).primaryColor, thickness: 0.6)
          ],
        ),
      ),
      content: SizedBox(
        height: isUnknow
            ? selectItemTariff != null
                ? 710
                : 690
            : 640,
        child: Form(
          key: _formKeyTariffDay,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isUnknow)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextStyles.standardText(
                          text: "Tarifa Aplicada:  ",
                          color: Theme.of(context).primaryColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: tarifaProvider.when(
                                data: (data) {
                                  if (!startFlowTariff) {
                                    for (var element in data) {
                                      itemsTariff
                                          .add({"${element.nombre}": element});
                                    }

                                    selectItemTariff = itemsTariff
                                        .where((element) =>
                                            (element.values.first?.code ??
                                                '') ==
                                            widget.tarifaXHabitacion.tariffCode)
                                        .firstOrNull;

                                    startFlowTariff = true;
                                  }

                                  return SizedBox(
                                    width: selectItemTariff != null ? 275 : 310,
                                    height: 35,
                                    child: acd.CustomDropdown<
                                        Map<String, RegistroTarifa?>>.search(
                                      searchHintText: "Buscar",
                                      hintText: "Selecciona la tarifa definida",
                                      closedHeaderPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical:
                                            selectItemTariff == null ? 10 : 0,
                                      ),
                                      items: itemsTariff,
                                      decoration: acd.CustomDropdownDecoration(
                                        closedFillColor:
                                            Theme.of(context).primaryColorDark,
                                        expandedFillColor:
                                            Theme.of(context).primaryColorDark,
                                        searchFieldDecoration:
                                            acd.SearchFieldDecoration(
                                          fillColor: Theme.of(context)
                                              .primaryColorDark,
                                          hintStyle: TextStyles.styleStandar(),
                                          textStyle: TextStyles.styleStandar(),
                                        ),
                                        closedBorderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(5)),
                                        expandedBorderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(4)),
                                        closedBorder:
                                            Border.all(color: Colors.grey),
                                        hintStyle: TextStyles.styleStandar(),
                                        headerStyle: TextStyles.styleStandar(),
                                        listItemStyle:
                                            TextStyles.styleStandar(),
                                        errorStyle: TextStyles.styleStandar(),
                                        noResultFoundStyle:
                                            TextStyles.styleStandar(),
                                      ),
                                      initialItem: selectItemTariff,
                                      onChanged: (value) {
                                        setState(
                                            () => selectItemTariff = value);

                                        if (value != null) {
                                          Temporada? selectSeason =
                                              Utility.getSeasonNow(
                                            value.values.first?.copyWith(),
                                            widget.numDays,
                                            isGroup: false,
                                            useCashTariff: useCashSeason,
                                          );

                                          selectSeason = selectSeason;
                                          seasons =
                                              value.values.first?.temporadas;
                                          tariffs = (selectSeason?.forCash ??
                                                  false)
                                              ? Utility.getTarifasData(
                                                  selectSeason?.tarifas ??
                                                      List<Tarifa?>.empty())
                                              : value.values.first
                                                  ?.copyWith()
                                                  .tarifas
                                                  ?.map((element) =>
                                                      element.copyWith())
                                                  .toList();

                                          selectTariff = (selectSeason
                                                      ?.forCash ??
                                                  false)
                                              ? Utility.getTarifasData([
                                                  selectSeason?.tarifas
                                                      ?.where((element) =>
                                                          element.categoria ==
                                                          tipoHabitacion[
                                                              categorias.indexOf(
                                                                  selectCategory)])
                                                      .firstOrNull
                                                      ?.copyWith()
                                                ]).first
                                              : value.values.first
                                                  ?.copyWith()
                                                  .tarifas!
                                                  .firstWhere((element) =>
                                                      element.categoria ==
                                                      tipoHabitacion[
                                                          categorias.indexOf(
                                                              selectCategory)])
                                                  .copyWith();

                                          baseTariffs = value.values.first
                                              ?.copyWith()
                                              .tarifas
                                              ?.map((element) =>
                                                  element.copyWith())
                                              .toList();

                                          _descuentoController.text = "0";

                                          isEditing = false;
                                          canBeReset = true;

                                          applyTariffData();
                                          setState(() {});
                                        }
                                      },
                                      noResultFoundText: "Tarifa no encontrada",
                                      headerBuilder:
                                          (context, selectedItem, enabled) {
                                        return DropdownMenuItem(
                                          child: CustomWidgets.itemMedal(
                                            selectedItem.keys.first,
                                            brightness,
                                            color: selectedItem
                                                .values.first?.color,
                                          ),
                                        );
                                      },
                                      expandedHeaderPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                      listItemBuilder: (context, item,
                                          isSelected, onItemSelect) {
                                        return SizedBox(
                                          child: DropdownMenuItem(
                                            child: CustomWidgets.itemMedal(
                                              item.keys.first,
                                              brightness,
                                              color: item.values.first?.color,
                                            ),
                                          ),
                                        );
                                      },
                                      listItemPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15),
                                    ),
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
                              ),
                            ),
                            if (selectItemTariff != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Buttons.iconButtonCard(
                                  tooltip: "Remover",
                                  icon: Icons.close,
                                  onPressed: () {
                                    selectItemTariff = null;

                                    if (widget.tarifaXHabitacion.tariffCode == null) {
                                      selectSeason =
                                          widget.tarifaXHabitacion.temporadaSelect;
                                      seasons = widget.tarifaXHabitacion.temporadas;
                                      selectTariff = widget.tarifaXHabitacion.tarifa;
                                      tariffs = widget.tarifaXHabitacion.tarifas;
                                      baseTariffs =
                                          widget.tarifaXHabitacion.tarifasBase;
                                      setState(() {});
                                    } else {
                                      selectSeason = null;
                                      seasons = null;
                                      selectTariff = null;
                                      tariffs = null;
                                      baseTariffs = null;
                                    }

                                    saveTariff = null;
                                    setState(() {});
                                    applyTariffData();
                                    if (widget.tarifaXHabitacion.tariffCode != null) {
                                      _insertTariffForm(null);
                                    }
                                    if (isUnknow || isFreeTariff) {
                                      isEditing = true;
                                    }
                                    canBeReset = false;
                                    _descuentoController.text =
                                        (widget.tarifaXHabitacion.descIntegrado ?? 0)
                                            .toString();
                                    setState(() {});
                                  },
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: (seasons != null)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    TextStyles.standardText(
                      text: (selectItemTariff != null || selectSeason != null)
                          ? "Temporada: "
                          : "Descuento en toda la tarifa:         ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    if (selectItemTariff != null ||
                        (seasons != null &&
                            (seasons ?? List<Temporada>.empty()).isNotEmpty))
                      CustomDropdown.dropdownMenuCustom(
                        withPermisse: (usuario.rol != 'RECEPCION'),
                        initialSelection: selectSeason?.nombre ?? 'No aplicar',
                        onSelected: (String? value) {
                          selectSeason = seasons
                              ?.where(
                                  (element) => element.nombre == (value ?? ''))
                              .firstOrNull;
                          setState(() {});
                          if (!useCashRoomSeason && !useCashSeason) return;
                          if (isUnknow || isFreeTariff) return;

                          if (value != 'No aplicar') {
                            Temporada? selectSeason = seasons
                                ?.where((element) =>
                                    (element.nombre == value) &&
                                    (element.forCash ?? false))
                                .toList()
                                .firstOrNull;

                            if (selectSeason != null &&
                                selectSeason.descuento == null) {
                              _insertTariffForm(Utility.getTarifasData([
                                selectSeason.tarifas
                                    ?.where((element) =>
                                        element.categoria ==
                                        tipoHabitacion[
                                            categorias.indexOf(selectCategory)])
                                    .toList()
                                    .firstOrNull
                              ]).first);

                              saveTariff = Utility.getTarifasData([
                                selectSeason.tarifas
                                    ?.where((element) =>
                                        element.categoria !=
                                        tipoHabitacion[
                                            categorias.indexOf(selectCategory)])
                                    .toList()
                                    .firstOrNull
                              ]).first;
                            } else {
                              _recoveryTariffsInd();
                            }
                          } else {
                            _recoveryTariffsInd();
                          }

                          setState(() {});
                        },
                        elements: promociones +
                            Utility.getSeasonstoString(
                              seasons,
                              onlyGroups: typeQuote,
                              onlyCash: useCashSeason || useCashRoomSeason,
                            ),
                        excepcionItem: "No aplicar",
                        notElements: Utility.getPromocionesNoValidas(
                          //Revisar Si es necesario el bloqueo dependiendo de la estancia minima
                          habitacionProvider,
                          temporadas: seasons,
                        ),
                      )
                    else
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                            name: "Porcentaje",
                            controller: _descuentoController,
                            icon: const Icon(CupertinoIcons.percent, size: 20),
                            isNumeric: true,
                            onChanged: (p0) => setState(() {}),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        absorbing: applyAllCategory,
                        child: Opacity(
                          opacity: applyAllCategory ? 0.5 : 1,
                          child: SelectButtonsWidget(
                            selectButton: selectCategory,
                            buttons: categoriesColor,
                            width: 350,
                            onPressed: (index) {
                              TarifaTableData? selectTariff =
                                  (isFreeTariff || isUnknow)
                                      ? null
                                      : tariffs
                                          ?.firstWhere(
                                            (element) =>
                                                element.categoria ==
                                                tipoHabitacion[categorias
                                                    .indexOf(selectCategory)],
                                          )
                                          .copyWith();

                              TarifaTableData saveIntTariff = TarifaTableData(
                                categoria: tipoHabitacion[
                                    categorias.indexOf(selectCategory)],
                                code: selectTariff?.code ??
                                    "${widget.tarifaXHabitacion.id} - $selectCategory",
                                fecha: selectTariff?.fecha ?? DateTime.now(),
                                id: selectTariff?.id ??
                                    categorias.indexOf(selectCategory),
                                tarifaAdultoSGLoDBL: double.tryParse(
                                        _tarifaAdultoController.text) ??
                                    selectTariff?.tarifaAdultoSGLoDBL,
                                tarifaAdultoTPL: double.tryParse(
                                        _tarifaAdultoTPLController.text) ??
                                    selectTariff?.tarifaAdultoTPL,
                                tarifaAdultoCPLE: double.tryParse(
                                        _tarifaAdultoCPLController.text) ??
                                    selectTariff?.tarifaAdultoCPLE,
                                tarifaPaxAdicional: double.tryParse(
                                        _tarifaPaxAdicionalController.text) ??
                                    selectTariff?.tarifaPaxAdicional,
                                tarifaMenores7a12: double.tryParse(
                                        _tarifaMenoresController.text) ??
                                    selectTariff?.tarifaMenores7a12,
                              );

                              _insertTariffForm(saveTariff);

                              saveTariff = saveIntTariff.copyWith();
                              showErrorTariff = false;

                              setState(
                                  () => selectCategory = categorias[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                    if (canBeReset && (usuario.rol != 'RECEPCION'))
                      Buttons.iconButtonCard(
                        icon: isEditing
                            ? Iconsax.refresh_bold
                            : Iconsax.edit_outline,
                        backgroundColor: colorTariff,
                        colorIcon: useWhiteForeground(colorTariff)
                            ? Utility.darken(colorTariff, -0.2)
                            : Utility.darken(colorTariff, 0.2),
                        tooltip: isEditing ? "Restablecer" : "Modificar",
                        invertColor: isEditing,
                        onPressed: () {
                          if (!isEditing) {
                            bool showAlertDialog =
                                Settings.showAlertTariffModified;

                            if (!showAlertDialog) {
                              isEditing = true;
                              setState(() {});
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (context) => Dialogs.customAlertDialog(
                                context: context,
                                iconData: Iconsax.danger_outline,
                                iconColor: Colors.amber[400],
                                title: "Alerta de modificación",
                                contentCustom: SizedBox(
                                  height: 110,
                                  width: 300,
                                  child: StatefulBuilder(
                                      builder: (context, snapshot) {
                                    return Column(
                                      children: [
                                        TextStyles.standardText(
                                          text:
                                              "¿Estas seguro de modificar la siguiente tarifa?",
                                          size: 12.5,
                                          overClip: true,
                                        ),
                                        const SizedBox(height: 7.5),
                                        TextStyles.standardText(
                                          text:
                                              "Esta funcion puede remover el redondeo preaplicado a las tarifas originales, tome sus debidas precauciones.",
                                          size: 10.5,
                                          overClip: true,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomWidgets.checkBoxWithDescription(
                                          context,
                                          title: "No volver a preguntar",
                                          compact: true,
                                          value: !showAlertDialog,
                                          onChanged: (p0) {
                                            showAlertDialog = !p0!;
                                            Settings.showAlertTariffModified =
                                                showAlertDialog;
                                            snapshot(() {});
                                          },
                                        )
                                      ],
                                    );
                                  }),
                                ),
                                nameButtonMain: "SI",
                                withButtonCancel: true,
                                nameButtonCancel: "NO",
                                otherButton: true,
                                funtionMain: () {
                                  isEditing = true;
                                  setState(() {});
                                },
                              ),
                            );
                            return;
                          }

                          bool isModificado =
                              widget.tarifaXHabitacion.modificado ?? false;

                          TarifaTableData? tariffVG =
                              (isModificado ? baseTariffs : tariffs)
                                  ?.where((element) =>
                                      element.categoria ==
                                      tipoHabitacion[
                                          categorias.indexOf(selectCategory)])
                                  .firstOrNull;

                          TarifaTableData? tariffVPM =
                              (isModificado ? baseTariffs : tariffs)
                                  ?.where((element) =>
                                      element.categoria !=
                                      tipoHabitacion[
                                          categorias.indexOf(selectCategory)])
                                  .firstOrNull;

                          _insertTariffForm(tariffVG);
                          saveTariff = tariffVPM;
                          isEditing = false;
                          setState(() {});
                        },
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      FormTariffWidget(
                        tarifaAdultoController: _tarifaAdultoController,
                        tarifaAdultoTPLController: _tarifaAdultoTPLController,
                        tarifaAdultoCPLController: _tarifaAdultoCPLController,
                        tarifaPaxAdicionalController:
                            _tarifaPaxAdicionalController,
                        tarifaMenoresController: _tarifaMenoresController,
                        onUpdate: () => setState(() {}),
                        applyRound: (isUnknow || isFreeTariff)
                            ? (!isEditing && selectItemTariff != null)
                            : !isEditing,
                        isEditing: ((isUnknow || isFreeTariff)
                                ? selectItemTariff == null
                                : false) ||
                            ((isEditing) && (usuario.rol != 'RECEPCION')),
                      ),
                      Divider(color: Theme.of(context).primaryColor),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if ((widget.isAppling || isUnknow) &&
                                    selectItemTariff == null)
                                  CustomWidgets.checkBoxWithDescription(
                                    context,
                                    activeColor: colorTariff,
                                    title: "Aplicar en ambas categorias",
                                    description:
                                        "(Vista Reserva, Vista Parcial al mar)",
                                    value: applyAllCategory,
                                    onChanged: (value) => setState(
                                      () {
                                        applyAllCategory = value!;
                                        showErrorTariff = false;
                                      },
                                    ),
                                  ),
                                if (isValidForApplyNotTariff(
                                        habitacionProvider) &&
                                    !widget.isAppling &&
                                    !isFreeTariff &&
                                    widget.numDays > 1)
                                  CustomWidgets.checkBoxWithDescription(
                                    context,
                                    activeColor: colorTariff,
                                    title: "Aplicar en dias sin tarifa",
                                    description:
                                        "(Esta opción aplicara los siguientes cambios en todos los dias que no esten en el margen de las tarifas definidas).",
                                    value: applyAllNoTariff,
                                    onChanged: (value) => setState(
                                      () {
                                        applyAllNoTariff = value!;
                                        applyAllTariff = false;
                                        applyAllDays = false;
                                      },
                                    ),
                                  ),
                                if ((usuario.rol != 'RECEPCION'))
                                  if (!isUnknow &&
                                      !widget.isAppling &&
                                      !isFreeTariff &&
                                      widget.numDays > 1)
                                    CustomWidgets.checkBoxWithDescription(
                                      context,
                                      activeColor: colorTariff,
                                      title: "Aplicar en toda la tarifa",
                                      description:
                                          "(Esta opción aplicara los siguientes cambios en todos los periodos de la tarifa actual: \"${widget.tarifaXHabitacion.nombreTariff}${widget.tarifaXHabitacion.subCode != null ? " [modificado]" : ""}\").",
                                      value: applyAllTariff,
                                      onChanged: (value) => setState(
                                        () {
                                          applyAllTariff = value!;
                                          applyAllNoTariff = false;
                                          applyAllDays = false;
                                        },
                                      ),
                                    ),
                                if (habitacionProvider.tarifasXHabitacion!.any(
                                        (element) => element.id != 'Unknow') &&
                                    (usuario.rol != 'RECEPCION'))
                                  if (!widget.isAppling && widget.numDays > 1)
                                    CustomWidgets.checkBoxWithDescription(
                                      context,
                                      activeColor: colorTariff,
                                      title: "Aplicar en todos los dias",
                                      description: "",
                                      value: applyAllDays,
                                      onChanged: (value) => setState(
                                        () {
                                          applyAllDays = value!;
                                          applyAllTariff = false;
                                          applyAllNoTariff = false;
                                        },
                                      ),
                                    ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          StatefulBuilder(builder: (context, snapshot) {
                            return SizedBox(
                              width: 225,
                              child: Column(
                                children: [
                                  CustomWidgets.itemListCount(
                                    nameItem:
                                        "Adultos (x${habitacionProvider.adultos}):",
                                    count: !isEditing
                                        ? Utility.formatNumberRound(tariffAdult)
                                            .roundToDouble()
                                        : tariffAdult,
                                    context: context,
                                    height: 40,
                                  ),
                                  CustomWidgets.itemListCount(
                                    nameItem:
                                        "Menores de 7 a 12 (x${habitacionProvider.menores7a12}):",
                                    count: !isEditing
                                        ? Utility.formatNumberRound(
                                                tariffChildren)
                                            .roundToDouble()
                                        : tariffChildren,
                                    context: context,
                                    height: 40,
                                  ),
                                  CustomWidgets.itemListCount(
                                    nameItem:
                                        "Menores de 0 a 6 (x${habitacionProvider.menores0a6}):",
                                    count: 0,
                                    context: context,
                                    height: 40,
                                  ),
                                  Divider(
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(height: 5),
                                  CustomWidgets.itemListCount(
                                      nameItem: "Total:",
                                      count: totalTariff,
                                      context: context,
                                      height: 40),
                                  CustomWidgets.itemListCount(
                                      nameItem:
                                          "Descuento (${(selectSeason != null) ? selectSeason?.descuento ?? 0 : _descuentoController.text}%):",
                                      count: descTariff,
                                      context: context,
                                      height: 40),
                                  Divider(
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(height: 5),
                                  CustomWidgets.itemListCount(
                                    nameItem: "Total del dia(s):",
                                    count: isEditing
                                        ? (totalTariff + descTariff)
                                        : ((tariffChildren + tariffAdult) -
                                                (calculateDiscount(tariffAdult +
                                                    tariffChildren)))
                                            .roundToDouble(),
                                    context: context,
                                    height: 40,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                insideSnackBar(
                  message:
                      "Se detectaron uno o mas campos por capturar la categoria: ${categorias.firstWhere((element) => element != selectCategory)}*",
                  type: 'danger',
                  showAnimation: showErrorTariff,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: TextStyles.buttonText(
              text: "CANCELAR", color: Theme.of(context).primaryColor),
        ),
        SizedBox(
          width: 100,
          child: Buttons.commonButton(
            text: "APLICAR",
            isBold: true,
            colorText: useWhiteForeground(colorTariff)
                ? Utility.darken(colorTariff, -0.25)
                : Utility.darken(colorTariff, 0.25),
            color: widget.tarifaXHabitacion.color ?? DesktopColors.cerulean,
            onPressed: () {
              if (!_formKeyTariffDay.currentState!.validate()) return;

              bool withChanges = detectFixInChanges();

              if (!withChanges &&
                  selectTariff != null &&
                  !applyAllDays &&
                  !applyAllNoTariff &&
                  !applyAllDays &&
                  !applyAllTariff) {
                Navigator.pop(context);
                return;
              }

              if (applyAllTariff &&
                  (widget.tarifaXHabitacion.subCode == null && !withChanges)) {
                Navigator.pop(context);
                return;
              }

              if (revisedPropiertiesSaveTariff() && !applyAllCategory) {
                _toggleSnackbar();
                return;
              }

              TarifaTableData? newTarifa = selectTariff;

              if (selectTariff != null &&
                  (saveTariff!.categoria == selectTariff?.categoria)) {
                selectTariff = saveTariff;

                int indexFirstTariff = (tariffs ?? []).indexWhere(
                    (element) => element.categoria == saveTariff!.categoria);

                if (indexFirstTariff != -1) {
                  tariffs![indexFirstTariff] = selectTariff!;
                }

                newTarifa = (tariffs ?? List<TarifaTableData>.empty())
                    .firstWhere((element) =>
                        element.categoria != saveTariff!.categoria);

                TarifaTableData? secondTariff = TarifaTableData(
                  id: newTarifa.id,
                  code: newTarifa.code,
                  categoria: newTarifa.categoria,
                  fecha: newTarifa.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL:
                      double.tryParse(_tarifaAdultoController.text),
                  tarifaAdultoTPL:
                      double.tryParse(_tarifaAdultoTPLController.text),
                  tarifaAdultoCPLE:
                      double.tryParse(_tarifaAdultoCPLController.text),
                  tarifaMenores7a12:
                      double.tryParse(_tarifaMenoresController.text),
                  tarifaPaxAdicional:
                      double.tryParse(_tarifaPaxAdicionalController.text),
                );

                int indexSecondTariff = (tariffs ?? []).indexWhere(
                    (element) => element.categoria == secondTariff.categoria);

                if (indexSecondTariff != -1) {
                  tariffs![indexSecondTariff] = secondTariff;
                }

                if (applyAllNoTariff || applyAllDays || widget.numDays == 1) {
                  _saveTariffNoDefined(selectTariff, secondTariff);
                }
              } else if (selectTariff != null) {
                selectTariff = TarifaTableData(
                  id: newTarifa?.id ?? 0,
                  code: newTarifa?.code ?? widget.tarifaXHabitacion.id ?? '',
                  categoria:
                      newTarifa?.categoria ?? widget.tarifaXHabitacion.categoria,
                  fecha: newTarifa?.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL:
                      double.tryParse(_tarifaAdultoController.text),
                  tarifaAdultoTPL:
                      double.tryParse(_tarifaAdultoTPLController.text),
                  tarifaAdultoCPLE:
                      double.tryParse(_tarifaAdultoCPLController.text),
                  tarifaMenores7a12:
                      double.tryParse(_tarifaMenoresController.text),
                  tarifaPaxAdicional:
                      double.tryParse(_tarifaPaxAdicionalController.text),
                );

                int indexFirstTariff = (tariffs ?? []).indexWhere(
                    (element) => element.categoria == selectTariff?.categoria);

                if (indexFirstTariff != -1) {
                  tariffs![indexFirstTariff] = selectTariff!;
                }

                int indexSecondTariff = (tariffs ?? []).indexWhere(
                    (element) => element.categoria == saveTariff?.categoria);

                if (indexSecondTariff != -1) {
                  tariffs![indexSecondTariff] = saveTariff!;
                }
              }

              if (selectTariff == null) {
                TarifaTableData newTariff = TarifaTableData(
                  id: newTarifa?.id ?? categorias.indexOf(selectCategory),
                  code: newTarifa?.code ?? '',
                  categoria: tipoHabitacion[categorias.indexOf(selectCategory)],
                  fecha: newTarifa?.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL:
                      double.tryParse(_tarifaAdultoController.text),
                  tarifaAdultoTPL:
                      double.tryParse(_tarifaAdultoTPLController.text),
                  tarifaAdultoCPLE:
                      double.tryParse(_tarifaAdultoCPLController.text),
                  tarifaMenores7a12:
                      double.tryParse(_tarifaMenoresController.text),
                  tarifaPaxAdicional:
                      double.tryParse(_tarifaPaxAdicionalController.text),
                );

                selectTariff = newTariff.copyWith();

                if (applyAllCategory) {
                  saveTariff = selectTariff!.copyWith();
                }

                TarifaTableData secondTariff = TarifaTableData(
                  id: categorias.indexOf(categorias
                      .firstWhere((element) => element != selectCategory)),
                  // code: saveTariff?.code ?? '',
                  code: '',
                  categoria: tipoHabitacion[categorias.indexOf(categorias
                      .firstWhere((element) => element != selectCategory))],
                  fecha: saveTariff?.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL: saveTariff?.tarifaAdultoSGLoDBL,
                  tarifaAdultoTPL: saveTariff?.tarifaAdultoTPL,
                  tarifaAdultoCPLE: saveTariff?.tarifaAdultoCPLE,
                  tarifaPaxAdicional: saveTariff?.tarifaPaxAdicional,
                  tarifaMenores7a12: saveTariff?.tarifaMenores7a12,
                );

                if (tariffs == null) {
                  tariffs = [newTariff, secondTariff];
                } else {
                  int indexSecondTariff = (tariffs ?? []).indexWhere(
                      (element) => element.categoria == secondTariff.categoria);

                  if (indexSecondTariff != -1) {
                    tariffs![indexSecondTariff] = secondTariff;
                  } else {
                    tariffs!.add(secondTariff);
                  }
                }

                if (applyAllNoTariff || applyAllDays || widget.numDays == 1) {
                  _saveTariffNoDefined(selectTariff, secondTariff);
                }
              }

              widget.tarifaXHabitacion.temporadaSelect = selectSeason;
              widget.tarifaXHabitacion.tarifas = tariffs;
              widget.tarifaXHabitacion.tarifa = selectTariff;
              widget.tarifaXHabitacion.modificado = isEditing;

              if (isUnknow) {
                widget.tarifaXHabitacion.temporadas = seasons;
                widget.tarifaXHabitacion.tarifasBase = baseTariffs;
                widget.tarifaXHabitacion.tariffCode =
                    selectItemTariff?.values.first?.code;
              }

              if (isUnknow || isFreeTariff) {
                widget.tarifaXHabitacion.descIntegrado =
                    double.tryParse(_descuentoController.text);
              }

              if (selectItemTariff != null && isUnknow) {
                widget.tarifaXHabitacion.descIntegrado = null;
              }

              if (applyAllTariff) {
                for (var element in habitacionProvider.tarifasXHabitacion!) {
                  if (element.id == widget.tarifaXHabitacion.id) {
                    element.tarifa = selectTariff;
                    element.subCode = null;
                    element.temporadaSelect = selectSeason;
                    element.tarifas = tariffs;
                    element.modificado = isEditing;
                  }
                }
              }

              if (applyAllNoTariff && !isUnknow) {
                widget.tarifaXHabitacion.subCode = !detectFixInChanges()
                    ? null
                    : UniqueKey().hashCode.toString();

                for (var element in habitacionProvider.tarifasXHabitacion!
                    .where((element) => element.id!.contains("Unknow"))) {
                  element.tarifa = selectTariff;
                  element.subCode = widget.tarifaXHabitacion.subCode;
                  element.categoria = widget.tarifaXHabitacion.categoria;
                  element.id = widget.tarifaXHabitacion.id;
                  element.color = widget.tarifaXHabitacion.color;
                  element.nombreTariff = widget.tarifaXHabitacion.nombreTariff;
                  element.temporadaSelect = selectSeason;
                  element.temporadas = seasons;
                  element.tarifas = tariffs;
                  element.periodo = widget.tarifaXHabitacion.periodo;
                  element.tarifasBase = baseTariffs;
                  element.tarifasEfectivo = widget.tarifaXHabitacion.tarifasEfectivo;
                  element.modificado = isEditing;
                }
              }

              if (applyAllNoTariff && isUnknow) {
                for (var element in habitacionProvider.tarifasXHabitacion!
                    .where((element) => element.id!.contains("Unknow"))) {
                  element.tarifa = selectTariff;
                  element.tarifasBase = baseTariffs;
                  element.temporadaSelect = selectSeason;
                  element.temporadas = seasons;
                  element.categoria = widget.tarifaXHabitacion.categoria;
                  element.tarifas = tariffs;
                  element.subCode = null;
                  element.modificado = isEditing;
                  element.tariffCode = selectItemTariff?.values.first?.code;
                  element.descuentoProvisional =
                      double.parse(_descuentoController.text);
                }
              }

              if (!applyAllTariff && !applyAllNoTariff && !widget.isAppling) {
                widget.tarifaXHabitacion.subCode = UniqueKey().hashCode.toString();
              }

              if (applyAllDays) {
                for (var element in habitacionProvider.tarifasXHabitacion!) {
                  element.tarifa = selectTariff?.copyWith();
                  element.nombreTariff =
                      widget.tarifaXHabitacion.copyWith().nombreTariff!;
                  element.id = widget.tarifaXHabitacion.copyWith().id;
                  element.color = widget.tarifaXHabitacion.copyWith().color;
                  element.subCode = null;
                  if (isUnknow || isFreeTariff) {
                    element.descuentoProvisional =
                        double.parse(_descuentoController.text);
                  }
                  element.tariffCode = selectItemTariff?.values.first?.code;
                  element.temporadaSelect = selectSeason;
                  element.temporadas = seasons;
                  element.tarifas = tariffs?.map((e) => e.copyWith()).toList();
                  element.periodo = widget.tarifaXHabitacion.copyWith().periodo;
                  element.tarifasBase = baseTariffs;
                  element.tarifasEfectivo = widget.tarifaXHabitacion.tarifasEfectivo;
                  element.modificado = isEditing;
                }

                if (isUnknow) {
                  ref.read(descuentoProvisionalProvider.notifier).update(
                      (state) => double.parse(_descuentoController.text));

                  ref
                      .read(TarifasProvisionalesProvider.provider.notifier)
                      .addAll(tariffs ?? []);
                }
              }

              if (widget.isAppling) {
                widget.tarifaXHabitacion.tarifa = tariffs?.firstWhere((element) =>
                    element.categoria == habitacionProvider.categoria);
              }

              ref
                  .read(detectChangeProvider.notifier)
                  .update((state) => UniqueKey().hashCode);

              Navigator.of(context).pop(true);
            },
          ),
        ),
      ],
    );
  }

  double calculateTariffAdult(int adultos) {
    switch (adultos) {
      case 1 || 2:
        return double.tryParse(_tarifaAdultoController.text) ?? 0;
      case 3:
        return double.tryParse(_tarifaAdultoTPLController.text) ?? 0;
      case 4:
        return double.tryParse(_tarifaAdultoCPLController.text) ?? 0;
      default:
        return double.tryParse(_tarifaAdultoController.text) ?? 0;
    }
  }

  double calculateTariffMenor(int menores) =>
      menores * (double.tryParse(_tarifaMenoresController.text) ?? 0);

  double calculateDiscount(double total) {
    double discount = 0;

    if (selectSeason != null) {
      discount = (total * 0.01) * (selectSeason?.descuento ?? 0);
    } else {
      if (isUnknow || isFreeTariff) {
        discount = (total * 0.01) *
            double.parse(_descuentoController.text.isEmpty
                ? '0'
                : _descuentoController.text);
      }
    }

    return discount;
  }

  bool isSameSeason() {
    bool isSame = false;

    isSame = widget.tarifaXHabitacion.temporadaSelect?.nombre ==
        (selectSeason?.nombre ?? '');

    if ((isUnknow || isFreeTariff) && selectItemTariff == null) {
      isSame = double.tryParse(_descuentoController.text) ==
          (widget.tarifaXHabitacion.descIntegrado ?? 0);
    }

    return isSame;
  }

  bool detectFixInChanges() {
    bool withChanges = false;

    if (!isSameSeason()) return true;
    if (widget.tarifaXHabitacion.temporadas != seasons) return true;
    if (selectTariff != null &&
        selectTariff?.categoria ==
            tipoHabitacion[categorias.indexOf(selectCategory)]) {
      if (selectTariff?.tarifaAdultoSGLoDBL !=
          double.tryParse(_tarifaAdultoController.text)) return true;
      if (selectTariff?.tarifaAdultoTPL !=
          double.tryParse(_tarifaAdultoTPLController.text)) return true;
      if (selectTariff?.tarifaAdultoCPLE !=
          double.tryParse(_tarifaAdultoCPLController.text)) return true;
      if (selectTariff?.tarifaMenores7a12 !=
          double.tryParse(_tarifaMenoresController.text)) return true;
      if (selectTariff?.tarifaPaxAdicional !=
          double.tryParse(_tarifaPaxAdicionalController.text)) return true;

      if (widget.tarifaXHabitacion.tarifas == null) return false;
      TarifaTableData? secondTariff = tariffs
          ?.where((element) => element.categoria == saveTariff!.categoria)
          .firstOrNull;
      if (secondTariff == null) return false;

      if (secondTariff.tarifaAdultoSGLoDBL != saveTariff!.tarifaAdultoSGLoDBL) {
        return true;
      }
      if (secondTariff.tarifaAdultoTPL != saveTariff!.tarifaAdultoTPL) {
        return true;
      }
      if (secondTariff.tarifaAdultoCPLE != saveTariff!.tarifaAdultoCPLE) {
        return true;
      }
      if (secondTariff.tarifaMenores7a12 != saveTariff!.tarifaMenores7a12) {
        return true;
      }
      if (secondTariff.tarifaPaxAdicional != saveTariff!.tarifaPaxAdicional) {
        return true;
      }
    } else if (saveTariff != null &&
        selectTariff != null &&
        selectTariff?.categoria !=
            tipoHabitacion[categorias.indexOf(selectCategory)]) {
      if (selectTariff?.tarifaAdultoSGLoDBL !=
          saveTariff!.tarifaAdultoSGLoDBL) {
        return true;
      }
      if (selectTariff?.tarifaAdultoTPL != saveTariff!.tarifaAdultoTPL) {
        return true;
      }
      if (selectTariff?.tarifaAdultoCPLE != saveTariff!.tarifaAdultoCPLE) {
        return true;
      }
      if (selectTariff?.tarifaMenores7a12 != saveTariff!.tarifaMenores7a12) {
        return true;
      }
      if (selectTariff?.tarifaPaxAdicional != saveTariff!.tarifaPaxAdicional) {
        return true;
      }

      if (tariffs == null) return false;
      TarifaTableData? secondTariff = tariffs
          ?.where((element) =>
              element.categoria ==
              tipoHabitacion[categorias.indexOf(selectCategory)])
          .firstOrNull;
      if (secondTariff == null) return false;

      if (secondTariff.tarifaAdultoSGLoDBL !=
          double.tryParse(_tarifaAdultoController.text)) return true;
      if (secondTariff.tarifaAdultoTPL !=
          double.tryParse(_tarifaAdultoTPLController.text)) return true;
      if (secondTariff.tarifaAdultoCPLE !=
          double.tryParse(_tarifaAdultoCPLController.text)) return true;
      if (secondTariff.tarifaMenores7a12 !=
          double.tryParse(_tarifaMenoresController.text)) return true;
      if (secondTariff.tarifaPaxAdicional !=
          double.tryParse(_tarifaPaxAdicionalController.text)) return true;
    }

    if (widget.tarifaXHabitacion.modificado != isEditing) return true;

    return withChanges;
  }

  bool revisedPropiertiesSaveTariff() {
    if (saveTariff?.tarifaAdultoSGLoDBL == null) return true;
    if (saveTariff?.tarifaAdultoTPL == null) return true;
    if (saveTariff?.tarifaAdultoCPLE == null) return true;
    if (saveTariff?.tarifaPaxAdicional == null) return true;
    if (saveTariff?.tarifaMenores7a12 == null) return true;

    return false;
  }

  bool isValidForApplyNotTariff(Habitacion habitacion) {
    bool isValid = false;
    if (isUnknow) return true;
    if (habitacion.tarifasXHabitacion!
        .any((element) => element.id!.contains("Unknow"))) isValid = true;

    return isValid;
  }

  void _saveTariffNoDefined(
      TarifaTableData? firstTariff, TarifaTableData? secondTariff) {
    ref
        .read(descuentoProvisionalProvider.notifier)
        .update((state) => double.parse(_descuentoController.text));

    final tarifasProvider = TarifasProvisionalesProvider.provider;

    ref.read(tarifasProvider.notifier).clear();
    // ref.read(tarifasProvider.notifier).remove(widget.tarifaXDia.categoria!);
    ref.read(tarifasProvider.notifier).addItem(firstTariff!);
    ref.read(tarifasProvider.notifier).addItem(secondTariff!);
  }

  void _recoveryTariffsInd() {
    _insertTariffForm(baseTariffs
        ?.where((element) =>
            element.categoria ==
            tipoHabitacion[categorias.indexOf(selectCategory)])
        .toList()
        .firstOrNull);

    saveTariff = baseTariffs
        ?.where((element) =>
            element.categoria !=
            tipoHabitacion[categorias.indexOf(selectCategory)])
        .toList()
        .firstOrNull;
  }
}
