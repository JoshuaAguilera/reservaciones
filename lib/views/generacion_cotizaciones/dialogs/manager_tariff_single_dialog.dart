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
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/providers/usuario_provider.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/ui/inside_snackbar.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/form_tariff_widget.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart' as ACD;

import '../../../models/tarifa_model.dart';
import '../../../providers/tarifario_provider.dart';
import '../../../ui/progress_indicator.dart';
import '../../../widgets/select_buttons_widget.dart';

class ManagerTariffSingleDialog extends ConsumerStatefulWidget {
  const ManagerTariffSingleDialog({
    super.key,
    required this.tarifaXDia,
    this.isAppling = false,
    required this.numDays,
  });

  final TarifaXDia tarifaXDia;
  final bool isAppling;
  final int numDays;

  @override
  _ManagerTariffDayWidgetState createState() => _ManagerTariffDayWidgetState();
}

class _ManagerTariffDayWidgetState
    extends ConsumerState<ManagerTariffSingleDialog> {
  String temporadaSelect = "No aplica";
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
  TarifaData? saveTariff;
  bool startFlow = false;
  List<TarifaData?> baseTariffs = [];
  RegistroTarifa? selectTariffDefined;
  Color colorTariff = DesktopColors.cerulean;
  bool isEditing = false;
  bool canBeReset = false;

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
        (widget.tarifaXDia.descuentoProvisional ?? 0).toString();
    isUnknow = widget.tarifaXDia.code!.contains("Unknow");
    isFreeTariff = widget.tarifaXDia.code!.contains("tariffFree");
    colorTariff = widget.tarifaXDia.color ?? DesktopColors.ceruleanOscure;
    isEditing =
        (widget.tarifaXDia.modificado ?? false) || (isUnknow || isFreeTariff);
    canBeReset = (widget.tarifaXDia.tarifasBase ?? List.empty()).isNotEmpty;
    applyTariffData();

    super.initState();
  }

  void applyTariffData() {
    temporadaSelect = widget.tarifaXDia.temporadaSelect?.nombre ?? 'No aplicar';

    if (widget.tarifaXDia.tarifa != null) {
      _insertTariffForm(widget.tarifaXDia.tarifa);

      selectCategory = categorias[
          tipoHabitacion.indexOf(widget.tarifaXDia.tarifa!.categoria!)];
    }

    if ((widget.tarifaXDia.tarifas ?? List<TarifaData>.empty()).isNotEmpty) {
      baseTariffs = widget.tarifaXDia.tarifas!;
    }

    if (widget.tarifaXDia.tarifa != null) {
      TarifaData? detectTarifa =
          (widget.tarifaXDia.tarifas ?? List<TarifaData>.empty())
              .where((element) =>
                  element.categoria != widget.tarifaXDia.tarifa!.categoria)
              .toList()
              .firstOrNull;
      if (detectTarifa != null) saveTariff = detectTarifa.copyWith();
    }
  }

  void _insertTariffForm(TarifaData? tarifa) {
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
    Future.delayed(5.seconds, () => setState(() => showErrorTariff = false));
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

    if (!startFlow && widget.tarifaXDia.tarifa == null) {
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
                  : "Modificar tarifa del ${Utility.getCompleteDate(data: widget.tarifaXDia.fecha)}",
              subtitle: widget.isAppling
                  ? Utility.getPeriodReservation([habitacionProvider])
                  : "Tarifa aplicada: ${widget.tarifaXDia.nombreTariff} ${widget.tarifaXDia.subCode != null ? "(modificada)" : ""}",
            ),
            const SizedBox(height: 10),
            Divider(color: Theme.of(context).primaryColor, thickness: 0.6)
          ],
        ),
      ),
      content: SizedBox(
        height: isUnknow ? 690 : 640,
        child: Form(
          key: _formKeyTariffDay,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ////Custom
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
                                  return SizedBox(
                                    width:
                                        selectTariffDefined != null ? 275 : 310,
                                    height: 35,
                                    child: ACD
                                        .CustomDropdown<RegistroTarifa>.search(
                                      searchHintText: "Buscar",
                                      hintText: "Selecciona la tarifa definida",
                                      closedHeaderPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: selectTariffDefined == null
                                              ? 10
                                              : 0),
                                      items: data,
                                      decoration: ACD.CustomDropdownDecoration(
                                        closedFillColor:
                                            Theme.of(context).primaryColorDark,
                                        expandedFillColor:
                                            Theme.of(context).primaryColorDark,
                                        searchFieldDecoration:
                                            ACD.SearchFieldDecoration(
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
                                      initialItem: selectTariffDefined,
                                      onChanged: (value) {
                                        setState(
                                            () => selectTariffDefined = value);

                                        if (value != null) {
                                          Temporada? selectSeason =
                                              Utility.getSeasonNow(
                                            value.copyWith(),
                                            widget.numDays,
                                            isGroup: false,
                                            useCashTariff: useCashSeason,
                                          );

                                          widget.tarifaXDia.temporadaSelect =
                                              selectSeason;
                                          widget.tarifaXDia.temporadas =
                                              value.temporadas;
                                          widget.tarifaXDia.tarifas =
                                              (selectSeason?.forCash ?? false)
                                                  ? Utility.getTarifasData(
                                                      selectSeason?.tarifas ??
                                                          List<Tarifa?>.empty())
                                                  : value
                                                      .copyWith()
                                                      .tarifas
                                                      ?.map((element) =>
                                                          element.copyWith())
                                                      .toList();

                                          widget.tarifaXDia.tarifasBase = value
                                              .copyWith()
                                              .tarifas
                                              ?.map((element) =>
                                                  element.copyWith())
                                              .toList();

                                          widget
                                              .tarifaXDia.tarifa = (selectSeason
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
                                              : value
                                                  .copyWith()
                                                  .tarifas!
                                                  .firstWhere((element) =>
                                                      element.categoria ==
                                                      tipoHabitacion[
                                                          categorias.indexOf(
                                                              selectCategory)])
                                                  .copyWith();

                                          applyTariffData();
                                          setState(() {});
                                        }
                                      },
                                      noResultFoundText: "Tarifa no encontrada",
                                      headerBuilder:
                                          (context, selectedItem, enabled) {
                                        return DropdownMenuItem(
                                          child: CustomWidgets.itemMedal(
                                            selectedItem.nombre ?? '',
                                            brightness,
                                            color: selectedItem.color,
                                          ),
                                        );
                                      },
                                      expandedHeaderPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      listItemBuilder: (context, item,
                                          isSelected, onItemSelect) {
                                        return DropdownMenuItem(
                                          child: CustomWidgets.itemMedal(
                                            item.nombre ?? '',
                                            brightness,
                                            color: item.color,
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
                            if (selectTariffDefined != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Buttons.iconButtonCard(
                                  tooltip: "Remover",
                                  icon: Icons.close,
                                  onPressed: () {
                                    selectTariffDefined = null;
                                    //Remplazar modo de operacion al trabajar con 
                                    //tarifas no definidas, preAlmacenar temporadas 
                                    //en vez de autoInsertarlas en el modelo original
                                    widget.tarifaXDia.temporadaSelect = null;
                                    widget.tarifaXDia.temporadas = null;
                                    widget.tarifaXDia.tarifas = null;
                                    widget.tarifaXDia.tarifasBase = null;
                                    widget.tarifaXDia.tarifa = null;

                                    applyTariffData();
                                    _insertTariffForm(null);
                                    setState(() {});
                                  },
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                /////
                Row(
                  mainAxisAlignment:
                      (widget.tarifaXDia.temporadaSelect != null ||
                              widget.tarifaXDia.temporadas != null)
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                  children: [
                    TextStyles.standardText(
                      text: (selectTariffDefined != null ||
                              widget.tarifaXDia.temporadaSelect != null)
                          ? "Temporada: "
                          : "Descuento en toda la tarifa:         ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    if (selectTariffDefined != null ||
                        (widget.tarifaXDia.temporadas != null &&
                            widget.tarifaXDia.temporadas!.isNotEmpty))
                      CustomDropdown.dropdownMenuCustom(
                        withPermisse: (usuario.rol != 'RECEPCION'),
                        initialSelection: temporadaSelect,
                        onSelected: (String? value) {
                          setState(() => temporadaSelect = value!);
                          if (!useCashRoomSeason && !useCashSeason) return;

                          if (temporadaSelect != 'No aplicar') {
                            Temporada? selectSeason = widget
                                .tarifaXDia.temporadas
                                ?.where((element) =>
                                    (element.nombre == temporadaSelect) &&
                                    (element.forCash ?? false))
                                .toList()
                                .firstOrNull;

                            if (selectSeason != null &&
                                selectSeason.porcentajePromocion == null) {
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
                              widget.tarifaXDia.temporadas,
                              onlyGroups: typeQuote,
                              onlyCash: useCashSeason || useCashRoomSeason,
                            ),
                        excepcionItem: "No aplicar",
                        notElements: Utility.getPromocionesNoValidas(
                          //Revisar Si es necesario el bloqueo dependiendo de la estancia minima
                          habitacionProvider,
                          temporadas: widget.tarifaXDia.temporadas,
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
                              TarifaData? selectTariff =
                                  (isFreeTariff || isUnknow)
                                      ? null
                                      : widget.tarifaXDia.tarifas
                                          ?.firstWhere(
                                            (element) =>
                                                element.categoria ==
                                                tipoHabitacion[categorias
                                                    .indexOf(selectCategory)],
                                          )
                                          .copyWith();

                              TarifaData saveIntTariff = TarifaData(
                                categoria: tipoHabitacion[
                                    categorias.indexOf(selectCategory)],
                                code: selectTariff?.code ??
                                    "${widget.tarifaXDia.code} - $selectCategory",
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
                    if (canBeReset &&
                        (usuario.rol != 'RECEPCION') &&
                        !(isUnknow || isFreeTariff))
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
                                Preferences.showAlertTariffModified;

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
                                            Preferences
                                                    .showAlertTariffModified =
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
                              widget.tarifaXDia.modificado ?? false;

                          TarifaData? tariffVG = (isModificado
                                  ? widget.tarifaXDia.tarifasBase
                                  : widget.tarifaXDia.tarifas)
                              ?.where((element) =>
                                  element.categoria ==
                                  tipoHabitacion[
                                      categorias.indexOf(selectCategory)])
                              .firstOrNull;

                          TarifaData? tariffVPM = (isModificado
                                  ? widget.tarifaXDia.tarifasBase
                                  : widget.tarifaXDia.tarifas)
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
                        applyRound: (!isEditing),
                        isEditing: (isEditing || (isUnknow || isFreeTariff)) &&
                            ((usuario.rol != 'RECEPCION') ||
                                (isUnknow || isFreeTariff)),
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
                                if (widget.isAppling || isUnknow)
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
                                          "(Esta opción aplicara los siguientes cambios en todos los periodos de la tarifa actual: \"${widget.tarifaXDia.nombreTariff}${widget.tarifaXDia.subCode != null ? " [modificado]" : ""}\").",
                                      value: applyAllTariff,
                                      onChanged: (value) => setState(
                                        () {
                                          applyAllTariff = value!;
                                          applyAllNoTariff = false;
                                          applyAllDays = false;
                                        },
                                      ),
                                    ),
                                if (habitacionProvider.tarifaXDia!.any(
                                        (element) =>
                                            element.code != 'Unknow') &&
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
                                          "Descuento (${(getSeasonSelect() != null) ? getSeasonSelect()?.porcentajePromocion ?? 0 : _descuentoController.text}%):",
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
            text: "ACEPTAR",
            isBold: true,
            colorText: useWhiteForeground(colorTariff)
                ? Utility.darken(colorTariff, -0.25)
                : Utility.darken(colorTariff, 0.25),
            color: widget.tarifaXDia.color ?? DesktopColors.cerulean,
            onPressed: () {
              if (!_formKeyTariffDay.currentState!.validate()) return;

              bool withChanges = detectFixInChanges();

              if (!withChanges &&
                  widget.tarifaXDia.tarifa != null &&
                  !applyAllDays &&
                  !applyAllNoTariff &&
                  !applyAllDays &&
                  !applyAllTariff) {
                Navigator.pop(context);
                return;
              }

              if (applyAllTariff &&
                  (widget.tarifaXDia.subCode == null && !withChanges)) {
                Navigator.pop(context);
                return;
              }

              if (revisedPropiertiesSaveTariff() && !applyAllCategory) {
                _toggleSnackbar();
                return;
              }

              TarifaData? newTarifa = widget.tarifaXDia.tarifa;

              if (widget.tarifaXDia.tarifa != null &&
                  saveTariff!.categoria ==
                      widget.tarifaXDia.tarifa!.categoria) {
                widget.tarifaXDia.tarifa = saveTariff;

                int indexFirstTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) => element.categoria == saveTariff!.categoria);

                if (indexFirstTariff != -1) {
                  widget.tarifaXDia.tarifas![indexFirstTariff] =
                      widget.tarifaXDia.tarifa!;
                }

                newTarifa = widget.tarifaXDia.tarifas!.firstWhere(
                    (element) => element.categoria != saveTariff!.categoria);

                TarifaData? secondTariff = TarifaData(
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

                int indexSecondTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) => element.categoria == secondTariff.categoria);

                if (indexSecondTariff != -1) {
                  widget.tarifaXDia.tarifas![indexSecondTariff] = secondTariff;
                }

                if (applyAllNoTariff || applyAllDays || widget.numDays == 1) {
                  _saveTariffNoDefined(widget.tarifaXDia.tarifa, secondTariff);
                }
              } else if (widget.tarifaXDia.tarifa != null) {
                widget.tarifaXDia.tarifa = TarifaData(
                  id: newTarifa?.id ?? 0,
                  code: newTarifa?.code ?? widget.tarifaXDia.code ?? '',
                  categoria:
                      newTarifa?.categoria ?? widget.tarifaXDia.categoria,
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

                int indexFirstTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) =>
                        element.categoria ==
                        widget.tarifaXDia.tarifa!.categoria);

                if (indexFirstTariff != -1) {
                  widget.tarifaXDia.tarifas![indexFirstTariff] =
                      widget.tarifaXDia.tarifa!;
                }

                int indexSecondTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) => element.categoria == saveTariff?.categoria);

                if (indexSecondTariff != -1) {
                  widget.tarifaXDia.tarifas![indexSecondTariff] = saveTariff!;
                }
              }

              if (widget.tarifaXDia.tarifa == null) {
                TarifaData newTariff = TarifaData(
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

                widget.tarifaXDia.tarifa = newTariff.copyWith();

                if (applyAllCategory) {
                  saveTariff = widget.tarifaXDia.tarifa!.copyWith();
                }

                TarifaData secondTariff = TarifaData(
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

                if (widget.tarifaXDia.tarifas == null) {
                  widget.tarifaXDia.tarifas = [newTariff, secondTariff];
                } else {
                  int indexSecondTariff = widget.tarifaXDia.tarifas!.indexWhere(
                      (element) => element.categoria == secondTariff.categoria);

                  if (indexSecondTariff != -1) {
                    widget.tarifaXDia.tarifas![indexSecondTariff] =
                        secondTariff;
                  } else {
                    widget.tarifaXDia.tarifas!.add(secondTariff);
                  }
                }

                if (applyAllNoTariff || applyAllDays || widget.numDays == 1) {
                  _saveTariffNoDefined(widget.tarifaXDia.tarifa, secondTariff);
                }
              }

              widget.tarifaXDia.temporadaSelect = getSeasonSelect();
              widget.tarifaXDia.modificado = isEditing;

              if (isUnknow || isFreeTariff) {
                widget.tarifaXDia.descuentoProvisional =
                    double.parse(_descuentoController.text);
              }

              if (applyAllTariff) {
                for (var element in habitacionProvider.tarifaXDia!) {
                  if (element.code == widget.tarifaXDia.code) {
                    element.tarifa = widget.tarifaXDia.tarifa;
                    element.subCode = null;
                    element.temporadaSelect = getSeasonSelect();
                    element.tarifas = widget.tarifaXDia.tarifas;
                  }
                }
              }

              if (applyAllNoTariff && !isUnknow) {
                widget.tarifaXDia.subCode = !detectFixInChanges()
                    ? null
                    : UniqueKey().hashCode.toString();

                for (var element in habitacionProvider.tarifaXDia!
                    .where((element) => element.code!.contains("Unknow"))) {
                  element.tarifa = widget.tarifaXDia.tarifa;
                  element.subCode = widget.tarifaXDia.subCode;
                  element.categoria = widget.tarifaXDia.categoria;
                  element.code = widget.tarifaXDia.code;
                  element.color = widget.tarifaXDia.color;
                  element.nombreTariff = widget.tarifaXDia.nombreTariff;
                  element.temporadaSelect = getSeasonSelect();
                  element.temporadas = widget.tarifaXDia.temporadas;
                  element.tarifas = widget.tarifaXDia.tarifas;
                  element.periodo = widget.tarifaXDia.periodo;
                }
              }

              if (applyAllNoTariff && isUnknow) {
                for (var element in habitacionProvider.tarifaXDia!
                    .where((element) => element.code!.contains("Unknow"))) {
                  element.tarifa = widget.tarifaXDia.tarifa;
                  element.tarifas = widget.tarifaXDia.tarifas;
                  element.subCode = null;
                  element.descuentoProvisional =
                      double.parse(_descuentoController.text);
                }
              }

              if (!applyAllTariff && !applyAllNoTariff && !widget.isAppling) {
                widget.tarifaXDia.subCode = UniqueKey().hashCode.toString();
              }

              if (applyAllDays) {
                for (var element in habitacionProvider.tarifaXDia!) {
                  element.tarifa =
                      widget.tarifaXDia.copyWith().tarifa!.copyWith();
                  element.nombreTariff =
                      widget.tarifaXDia.copyWith().nombreTariff!;
                  element.code = widget.tarifaXDia.copyWith().code;
                  element.color = widget.tarifaXDia.copyWith().color;
                  element.subCode = null;
                  if (isUnknow || isFreeTariff) {
                    element.descuentoProvisional =
                        double.parse(_descuentoController.text);
                  }

                  element.temporadaSelect = getSeasonSelect();
                  element.temporadas = widget.tarifaXDia
                      .copyWith()
                      .temporadas
                      ?.map((element) => element.copyWith())
                      .toList();
                  element.tarifas = widget.tarifaXDia
                      .copyWith()
                      .tarifas
                      ?.map((element) => element.copyWith())
                      .toList();
                  element.periodo = widget.tarifaXDia.copyWith().periodo;
                }

                if (isUnknow) {
                  ref.read(descuentoProvisionalProvider.notifier).update(
                      (state) => double.parse(_descuentoController.text));

                  ref
                      .read(TarifasProvisionalesProvider.provider.notifier)
                      .addAll(widget.tarifaXDia.tarifas ?? []);
                }
              }

              if (widget.isAppling) {
                widget.tarifaXDia.tarifa = widget.tarifaXDia.tarifas
                    ?.firstWhere((element) =>
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
      menores * (double.tryParse(_tarifaAdultoController.text) ?? 0);

  Temporada? getSeasonSelect() {
    if (widget.tarifaXDia.temporadas != null) {
      return widget.tarifaXDia.temporadas!
          .where((element) => element.nombre == temporadaSelect)
          .firstOrNull;
    } else {
      return null;
    }
  }

  double calculateDiscount(double total) {
    double discount = 0;

    if (getSeasonSelect() != null) {
      discount = (total * 0.01) * (getSeasonSelect()?.porcentajePromocion ?? 0);
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

    if (widget.tarifaXDia.temporadaSelect != null) {
      isSame = widget.tarifaXDia.temporadaSelect!.nombre == temporadaSelect;
    }

    if (isUnknow || isFreeTariff) {
      isSame = double.parse(_descuentoController.text) ==
          widget.tarifaXDia.descuentoProvisional!;
    }

    return isSame;
  }

  bool detectFixInChanges() {
    bool withChanges = false;

    if (!isSameSeason()) return true;
    if (widget.tarifaXDia.tarifa != null &&
        widget.tarifaXDia.tarifa!.categoria ==
            tipoHabitacion[categorias.indexOf(selectCategory)]) {
      if (widget.tarifaXDia.tarifa!.tarifaAdultoSGLoDBL !=
          double.tryParse(_tarifaAdultoController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoTPL !=
          double.tryParse(_tarifaAdultoTPLController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoCPLE !=
          double.tryParse(_tarifaAdultoCPLController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaMenores7a12 !=
          double.tryParse(_tarifaMenoresController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaPaxAdicional !=
          double.tryParse(_tarifaPaxAdicionalController.text)) return true;

      if (widget.tarifaXDia.tarifas == null) return false;
      TarifaData? secondTariff = widget.tarifaXDia.tarifas
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
        widget.tarifaXDia.tarifa != null &&
        widget.tarifaXDia.tarifa!.categoria !=
            tipoHabitacion[categorias.indexOf(selectCategory)]) {
      if (widget.tarifaXDia.tarifa!.tarifaAdultoSGLoDBL !=
          saveTariff!.tarifaAdultoSGLoDBL) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoTPL !=
          saveTariff!.tarifaAdultoTPL) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoCPLE !=
          saveTariff!.tarifaAdultoCPLE) return true;
      if (widget.tarifaXDia.tarifa!.tarifaMenores7a12 !=
          saveTariff!.tarifaMenores7a12) return true;
      if (widget.tarifaXDia.tarifa!.tarifaPaxAdicional !=
          saveTariff!.tarifaPaxAdicional) return true;

      if (widget.tarifaXDia.tarifas == null) return false;
      TarifaData? secondTariff = widget.tarifaXDia.tarifas
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
    if (habitacion.tarifaXDia!
        .any((element) => element.code!.contains("Unknow"))) isValid = true;

    return isValid;
  }

  void _saveTariffNoDefined(TarifaData? firstTariff, TarifaData? secondTariff) {
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
    _insertTariffForm(widget.tarifaXDia.tarifasBase
        ?.where((element) =>
            element.categoria ==
            tipoHabitacion[categorias.indexOf(selectCategory)])
        .toList()
        .firstOrNull);

    saveTariff = widget.tarifaXDia.tarifasBase
        ?.where((element) =>
            element.categoria !=
            tipoHabitacion[categorias.indexOf(selectCategory)])
        .toList()
        .firstOrNull;
  }
}
