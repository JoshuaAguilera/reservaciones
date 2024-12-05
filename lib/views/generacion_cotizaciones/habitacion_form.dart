import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/providers/cotizacion_provider.dart';
import 'package:generador_formato/providers/habitacion_provider.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/views/generacion_cotizaciones/dias_list_view.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:generador_formato/widgets/summary_controller_widget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../models/registro_tarifa_model.dart';
import '../../models/temporada_model.dart';
import '../../providers/tarifario_provider.dart';
import '../../providers/usuario_provider.dart';
import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/dynamic_widget.dart';
import 'manager_tariff_single_dialog.dart';
import '../../widgets/number_input_with_increment_decrement.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';
import 'manager_tariff_group_dialog.dart';

class HabitacionForm extends ConsumerStatefulWidget {
  const HabitacionForm({
    super.key,
    required this.sideController,
  });

  final SidebarXController sideController;

  @override
  _HabitacionFormState createState() => _HabitacionFormState();
}

class _HabitacionFormState extends ConsumerState<HabitacionForm> {
  final _formKeyHabitacion = GlobalKey<FormState>();
  TextEditingController _fechaEntrada = TextEditingController();
  TextEditingController _fechaSalida = TextEditingController();
  bool changedDate = false;
  bool startflow = false;
  bool showSaveButton = false;
  List<Widget> modesVisualRange = <Widget>[
    const Icon(Icons.table_chart),
    const Icon(HeroIcons.list_bullet),
  ];
  double target = 1;
  bool isEditing = false;
  bool applyFreeTariff = false;
  TarifaXDia tarifaLibre = TarifaXDia(
    color: DesktopColors.turquezaOscure,
    descuentoProvisional: 0,
    code: "tariffFree",
    nombreTariff: "Tarifa Libre",
  );
  List<TarifaXDia> recoveryTariffs = [];
  bool alreadySaveTariff = false;
  bool alreadyApply = false;
  List<TarifaXDia> alternativeTariffInd = [];
  TarifaXDia? alternativeGrupTariff;

  final List<bool> _selectedModeRange = <bool>[
    true,
    false,
  ];

  final List<bool> selectedMode = <bool>[
    true,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fechaEntrada.dispose();
    _fechaSalida.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final tarifaProvider = ref.watch(allTarifaProvider(""));
    final habitacionProvider = ref.watch(habitacionSelectProvider);
    final tarifasProvisionalesProvider =
        ref.watch(TarifasProvisionalesProvider.provider);
    final descuentoProvider = ref.watch(descuentoProvisionalProvider);
    final politicaTarifaProvider = ref.watch(tariffPolicyProvider(""));
    final saveTariff = ref.watch(saveTariffPolityProvider);
    final typeQuote = ref.watch(typeQuoteProvider);
    final habitaciones = ref.watch(HabitacionProvider.provider);
    final usuario = ref.watch(userProvider);
    final useCashSeasonRoom = ref.watch(useCashSeasonRoomProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomWidgets.titleFormPage(
                      context: context,
                      title:
                          isEditing ? "Editar Habitación" : "Nueva Habitación",
                      showSaveButton: false,
                      optionPage: typeQuote
                          ? null
                          : FormWidgets.inputSwitch(
                              compact: screenWidth < 950,
                              activeColor: DesktopColors.azulClaro,
                              value: useCashSeasonRoom,
                              context: context,
                              name: "Usar Temporadas en Efectivo",
                              onChanged: (p0) => ref
                                  .watch(useCashSeasonRoomProvider.notifier)
                                  .update((ref) => p0),
                            ),
                      onPressedBack: () {
                        if (target == 1) {
                          setState(() => target = 0);

                          Future.delayed(
                            500.ms,
                            () => widget.sideController.selectIndex(1),
                          );
                        }
                      },
                    ),
                    politicaTarifaProvider.when(
                      data: (politicas) {
                        Future.delayed(
                          Durations.extralong1,
                          () {
                            if (!mounted) return;
                            if (saveTariff == null) {
                              ref
                                  .read(saveTariffPolityProvider.notifier)
                                  .update((state) => politicas);
                            }
                          },
                        );

                        return tarifaProvider.when(
                          data: (list) {
                            ref.listen<bool>(useCashSeasonRoomProvider,
                                (previous, next) {
                              if (next) {
                                getTarifasSelect(
                                  list,
                                  habitacionProvider,
                                  tarifasProvisionalesProvider,
                                  descuentoProvider,
                                  refreshTariff: isEditing,
                                  isGroup: typeQuote,
                                  useCashSeason: true,
                                );
                              } else {
                                getTarifasSelect(
                                  list,
                                  habitacionProvider,
                                  tarifasProvisionalesProvider,
                                  descuentoProvider,
                                  refreshTariff: isEditing,
                                  isGroup: typeQuote,
                                  useCashSeason: false,
                                );
                              }
                            });

                            if (!startflow) {
                              isEditing =
                                  habitacionProvider.tarifaXDia!.isNotEmpty;
                              if (list.isEmpty) {
                                Future.delayed(
                                  600.ms,
                                  () => showSnackBar(
                                      context: context,
                                      title: "Tarifario no configurado",
                                      message:
                                          "Aun no se cuenta con tarifas predefinidas en el sistema. Consulte con el administrador.",
                                      type: "danger"),
                                );
                              }
                              Future.delayed(250.ms,
                                  () => setState(() => showSaveButton = true));

                              _fechaEntrada = TextEditingController(
                                  text: habitacionProvider.fechaCheckIn ??
                                      DateTime.now()
                                          .toString()
                                          .substring(0, 10));
                              _fechaSalida = TextEditingController(
                                  text: habitacionProvider.fechaCheckOut ??
                                      DateTime.now()
                                          .add(const Duration(days: 1))
                                          .toString()
                                          .substring(0, 10));

                              if (habitacionProvider.tarifaXDia!.any(
                                  (element) => element.code == "tariffFree")) {
                                applyFreeTariff = true;
                              }

                              getTarifasSelect(
                                list,
                                habitacionProvider,
                                tarifasProvisionalesProvider,
                                descuentoProvider,
                                isGroup: typeQuote,
                                useCashSeason: useCashSeasonRoom,
                              );

                              startflow = true;
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Center(
                                  child: Card(
                                    elevation: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 45, 25, 35),
                                      child: Form(
                                        key: _formKeyHabitacion,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Wrap(
                                              spacing: 20,
                                              runSpacing: 15,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                TextStyles.standardText(
                                                  text: "Ver categoría:",
                                                  overClip: true,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                SizedBox(
                                                  child: CustomDropdown
                                                      .dropdownMenuCustom(
                                                    initialSelection:
                                                        habitacionProvider
                                                                .categoria ??
                                                            tipoHabitacion
                                                                .first,
                                                    onSelected:
                                                        (String? value) {
                                                      habitacionProvider
                                                          .categoria = value!;
                                                      getTarifasSelect(
                                                        list,
                                                        habitacionProvider,
                                                        tarifasProvisionalesProvider,
                                                        descuentoProvider,
                                                        onlyCategory: true,
                                                        isGroup: typeQuote,
                                                        useCashSeason:
                                                            useCashSeasonRoom,
                                                      );
                                                      setState(() {});
                                                    },
                                                    elements: tipoHabitacion,
                                                    screenWidth: screenWidth >
                                                            800
                                                        ? (screenWidth +
                                                                (widget.sideController
                                                                        .extended
                                                                    ? 0
                                                                    : 250)) *
                                                            0.26
                                                        : 295,
                                                    calculateWidth: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            Wrap(
                                              spacing: 20,
                                              runSpacing: 15,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child:
                                                      TextStyles.standardText(
                                                    text:
                                                        "Fechas de ocupación:",
                                                    overClip: true,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenWidth > 1120
                                                      ? 500
                                                      : null,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormFieldCustom
                                                            .textFormFieldwithBorderCalendar(
                                                          compact: (screenWidth <
                                                                      1000 &&
                                                                  widget
                                                                      .sideController
                                                                      .extended) ||
                                                              (screenWidth <
                                                                      900 &&
                                                                  !widget
                                                                      .sideController
                                                                      .extended),
                                                          name:
                                                              "Fecha de entrada",
                                                          msgError:
                                                              "Campo requerido*",
                                                          fechaLimite: DateTime
                                                                  .now()
                                                              .subtract(
                                                                  const Duration(
                                                                      days: 1))
                                                              .toIso8601String()
                                                              .substring(0, 10),
                                                          dateController:
                                                              _fechaEntrada,
                                                          onChanged: () {
                                                            setState(() {
                                                              _fechaSalida
                                                                      .text =
                                                                  Utility.getNextDay(
                                                                      _fechaEntrada
                                                                          .text);
                                                              changedDate =
                                                                  true;
                                                            });

                                                            habitacionProvider
                                                                    .fechaCheckIn =
                                                                _fechaEntrada
                                                                    .text;
                                                            habitacionProvider
                                                                    .fechaCheckOut =
                                                                _fechaSalida
                                                                    .text;

                                                            getTarifasSelect(
                                                              list,
                                                              habitacionProvider,
                                                              tarifasProvisionalesProvider,
                                                              descuentoProvider,
                                                              refreshTariff:
                                                                  isEditing,
                                                              isGroup:
                                                                  typeQuote,
                                                              useCashSeason:
                                                                  useCashSeasonRoom,
                                                            );
                                                            Future.delayed(
                                                              Durations.medium1,
                                                              () => setState(
                                                                () {
                                                                  changedDate =
                                                                      false;
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .ellipsis),
                                                      ),
                                                      Expanded(
                                                        child: TextFormFieldCustom
                                                            .textFormFieldwithBorderCalendar(
                                                          compact: (screenWidth <
                                                                      1000 &&
                                                                  widget
                                                                      .sideController
                                                                      .extended) ||
                                                              (screenWidth <
                                                                      900 &&
                                                                  !widget
                                                                      .sideController
                                                                      .extended),
                                                          name:
                                                              "Fecha de salida",
                                                          msgError:
                                                              "Campo requerido*",
                                                          dateController:
                                                              _fechaSalida,
                                                          fechaLimite:
                                                              _fechaEntrada
                                                                  .text,
                                                          onChanged: () {
                                                            setState(() =>
                                                                changedDate =
                                                                    true);
                                                            habitacionProvider
                                                                    .fechaCheckOut =
                                                                _fechaSalida
                                                                    .text;
                                                            getTarifasSelect(
                                                              list,
                                                              habitacionProvider,
                                                              tarifasProvisionalesProvider,
                                                              descuentoProvider,
                                                              refreshTariff:
                                                                  isEditing,
                                                              isGroup:
                                                                  typeQuote,
                                                              useCashSeason:
                                                                  useCashSeasonRoom,
                                                            );
                                                            Future.delayed(
                                                                Durations
                                                                    .medium1,
                                                                () => setState(() =>
                                                                    changedDate =
                                                                        false));
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Wrap(
                                              spacing: 15,
                                              runSpacing: 15,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                TextStyles.standardText(
                                                  text: "Número de huespedes:",
                                                  overClip: true,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                SizedBox(
                                                  width: screenWidth > 500
                                                      ? 500
                                                      : null,
                                                  child: Table(
                                                    children: [
                                                      TableRow(children: [
                                                        TextStyles.standardText(
                                                            text: "Adultos",
                                                            aling: TextAlign
                                                                .center,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        TextStyles.standardText(
                                                            text: "Menores 0-6",
                                                            aling: TextAlign
                                                                .center,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        TextStyles.standardText(
                                                            text:
                                                                "Menores 7-12",
                                                            aling: TextAlign
                                                                .center,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ]),
                                                      TableRow(children: [
                                                        NumberInputWithIncrementDecrement(
                                                          onChanged: (p0) => setState(() =>
                                                              habitacionProvider
                                                                      .adultos =
                                                                  int.tryParse(
                                                                      p0)),
                                                          initialValue:
                                                              habitacionProvider
                                                                  .adultos!
                                                                  .toString(),
                                                          minimalValue: 1,
                                                          maxValue: 4 -
                                                              habitacionProvider
                                                                  .menores0a6! -
                                                              habitacionProvider
                                                                  .menores7a12!,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: AbsorbPointer(
                                                            absorbing: revisedLimitPax(
                                                                habitacionProvider,
                                                                habitacionProvider
                                                                    .menores7a12!),
                                                            child: Opacity(
                                                              opacity: revisedLimitPax(
                                                                      habitacionProvider,
                                                                      habitacionProvider
                                                                          .menores7a12!)
                                                                  ? 0.5
                                                                  : 1,
                                                              child:
                                                                  NumberInputWithIncrementDecrement(
                                                                onChanged: (p0) => setState(() =>
                                                                    habitacionProvider
                                                                            .menores0a6 =
                                                                        int.tryParse(
                                                                            p0)),
                                                                initialValue:
                                                                    habitacionProvider
                                                                        .menores0a6!
                                                                        .toString(),
                                                                maxValue: 4 -
                                                                    habitacionProvider
                                                                        .adultos! -
                                                                    habitacionProvider
                                                                        .menores7a12!,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        AbsorbPointer(
                                                          absorbing: revisedLimitPax(
                                                              habitacionProvider,
                                                              habitacionProvider
                                                                  .menores0a6!),
                                                          child: Opacity(
                                                            opacity: revisedLimitPax(
                                                                    habitacionProvider,
                                                                    habitacionProvider
                                                                        .menores0a6!)
                                                                ? 0.5
                                                                : 1,
                                                            child:
                                                                NumberInputWithIncrementDecrement(
                                                              onChanged: (p0) => setState(() =>
                                                                  habitacionProvider
                                                                          .menores7a12 =
                                                                      int.tryParse(
                                                                          p0)),
                                                              initialValue:
                                                                  habitacionProvider
                                                                      .menores7a12!
                                                                      .toString(),
                                                              maxValue: 4 -
                                                                  habitacionProvider
                                                                      .menores0a6! -
                                                                  habitacionProvider
                                                                      .adultos!,
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                    ],
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
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextStyles.titleText(
                                        text: "Tarifas por dia",
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    if (typeQuote)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Buttons.commonButton(
                                          onPressed: () {
                                            List<TarifaXDia> tarifasFiltradas =
                                                Utility.getUniqueTariffs(
                                              (applyFreeTariff ||
                                                      habitacionProvider
                                                          .tarifaXDia!
                                                          .any((element) =>
                                                              element.code!
                                                                  .contains(
                                                                      "Unknow")))
                                                  ? habitacionProvider
                                                      .tarifaXDia!
                                                  : alternativeTariffInd.isEmpty
                                                      ? recoveryTariffs
                                                      : alternativeTariffInd,
                                            );

                                            int days = DateTime.parse(
                                                    _fechaSalida.text)
                                                .difference(DateTime.parse(
                                                    _fechaEntrada.text))
                                                .inDays;

                                            showDialogRateManager(
                                              tarifasFiltradas,
                                              habitacionProvider,
                                              days,
                                              withoutAction: true,
                                            );
                                          },
                                          color: Utility.darken(
                                              DesktopColors.cotGrupal, 0.15),
                                          text: "Gestionar tarifas",
                                        ),
                                      ),
                                    if ((usuario.rol != 'RECEPCION'))
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: SizedBox(
                                          child: FormWidgets.inputSwitch(
                                            name: "Tarifa Libre",
                                            value: applyFreeTariff,
                                            activeColor: DesktopColors.cerulean,
                                            context: context,
                                            compact: (screenWidth < 950 &&
                                                    widget.sideController
                                                        .extended) ||
                                                (screenWidth < 850 &&
                                                    !widget.sideController
                                                        .extended),
                                            onChanged: (p0) {
                                              setState(
                                                  () => applyFreeTariff = p0);
                                              if (applyFreeTariff) {
                                                tarifaLibre.categoria =
                                                    habitacionProvider
                                                        .categoria;
                                                tarifaLibre.tarifa = null;
                                                tarifaLibre
                                                    .descuentoProvisional = 0;

                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      ManagerTariffSingleDialog(
                                                    tarifaXDia: tarifaLibre,
                                                    isAppling: true,
                                                    numDays: DateTime.parse(
                                                            habitacionProvider
                                                                    .fechaCheckOut ??
                                                                '')
                                                        .difference(DateTime.parse(
                                                            habitacionProvider
                                                                    .fechaCheckIn ??
                                                                ''))
                                                        .inDays,
                                                  ),
                                                ).then(
                                                  (value) {
                                                    if (value != null) {
                                                      getTarifasSelect(
                                                        list,
                                                        habitacionProvider,
                                                        tarifasProvisionalesProvider,
                                                        descuentoProvider,
                                                        refreshTariff:
                                                            isEditing,
                                                        isGroup: typeQuote,
                                                        useCashSeason:
                                                            useCashSeasonRoom,
                                                      );
                                                    } else {
                                                      setState(() =>
                                                          applyFreeTariff =
                                                              false);
                                                    }
                                                  },
                                                );
                                              } else {
                                                getTarifasSelect(
                                                  list,
                                                  habitacionProvider,
                                                  tarifasProvisionalesProvider,
                                                  descuentoProvider,
                                                  refreshTariff: isEditing,
                                                  isGroup: typeQuote,
                                                  useCashSeason:
                                                      useCashSeasonRoom,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      height: 35,
                                      child: CustomWidgets.sectionButton(
                                        isCompact: (screenWidth < 925 &&
                                            widget.sideController.extended),
                                        listModes:
                                            (Utility.revisedLimitDateTime(
                                                      DateTime.parse(
                                                          _fechaEntrada.text),
                                                      DateTime.parse(
                                                          _fechaSalida.text),
                                                    ) &&
                                                    defineUseScreenWidth(
                                                        screenWidth))
                                                ? selectedMode
                                                : _selectedModeRange,
                                        modesVisual:
                                            (Utility.revisedLimitDateTime(
                                                      DateTime.parse(
                                                          _fechaEntrada.text),
                                                      DateTime.parse(
                                                          _fechaSalida.text),
                                                    ) &&
                                                    defineUseScreenWidth(
                                                        screenWidth))
                                                ? modesVisual
                                                : modesVisualRange,
                                        onChanged: (p0, p1) => setState(
                                            () => selectedMode[p0] = p0 == p1),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                if (!changedDate)
                                  SizedBox(
                                    child: DiasListView(
                                      initDay: _fechaEntrada.text,
                                      lastDay: _fechaSalida.text,
                                      isCalendary:
                                          (Utility.revisedLimitDateTime(
                                                    DateTime.parse(
                                                        _fechaEntrada.text),
                                                    DateTime.parse(
                                                        _fechaSalida.text),
                                                  ) &&
                                                  defineUseScreenWidth(
                                                      screenWidth))
                                              ? selectedMode.first
                                              : false,
                                      isTable: (Utility.revisedLimitDateTime(
                                                DateTime.parse(
                                                    _fechaEntrada.text),
                                                DateTime.parse(
                                                    _fechaSalida.text),
                                              ) &&
                                              defineUseScreenWidth(screenWidth))
                                          ? selectedMode[1]
                                          : _selectedModeRange[0],
                                      isCheckList:
                                          (Utility.revisedLimitDateTime(
                                                    DateTime.parse(
                                                        _fechaEntrada.text),
                                                    DateTime.parse(
                                                        _fechaSalida.text),
                                                  ) &&
                                                  defineUseScreenWidth(
                                                      screenWidth))
                                              ? selectedMode[2]
                                              : _selectedModeRange[1],
                                      sideController: widget.sideController,
                                    ),
                                  ),
                                const SizedBox(height: 15),
                              ],
                            ).animate(target: target).fadeIn(duration: 400.ms);
                          },
                          error: (error, stackTrace) => SizedBox(
                            height: 150,
                            child: CustomWidgets.messageNotResult(
                              context: context,
                              sizeImage: 100,
                              screenWidth: screenWidth,
                              extended: widget.sideController.extended,
                            ),
                          ),
                          loading: () => SizedBox(
                            height: screenHeight * 0.75,
                            child: dynamicWidget.loadingWidget(
                              screenWidth,
                              screenHeight * 0.2,
                              widget.sideController.extended,
                              isEstandar: true,
                              message: TextStyles.standardText(
                                  text: "Cargando tarifas",
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        );
                      },
                      error: (error, stackTrace) => SizedBox(
                        height: 150,
                        child: CustomWidgets.messageNotResult(
                          context: context,
                          sizeImage: 100,
                          screenWidth: screenWidth,
                          extended: widget.sideController.extended,
                          message:
                              "Error en la carga de componentes necesarios\npara generar cotizaciones.",
                        ),
                      ),
                      loading: () => SizedBox(
                        height: screenHeight * 0.75,
                        child: dynamicWidget.loadingWidget(
                          screenWidth,
                          screenHeight * 0.2,
                          widget.sideController.extended,
                          isEstandar: true,
                          message: TextStyles.standardText(
                              text: "Cargando politicas de cotización",
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            tarifaProvider.when(
              data: (list) {
                return SummaryControllerWidget(
                  calculateRoom: true,
                  numDays: DateTime.parse(_fechaSalida.text.isNotEmpty
                          ? _fechaSalida.text
                          : DateTime.now().toIso8601String())
                      .difference(DateTime.parse(_fechaEntrada.text.isNotEmpty
                          ? _fechaEntrada.text
                          : DateTime.now().add(1.days).toIso8601String()))
                      .inDays,
                  onSaveQuote: () {
                    final habitacionesProvider = HabitacionProvider.provider;

                    if (!isEditing) {
                      habitacionProvider.folioHabitacion = UniqueKey()
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '');
                    }

                    habitacionProvider.useCashSeason = useCashSeasonRoom;
                    if (isEditing) {
                      if (typeQuote) {
                        if (Utility.revisedIntegrityRoom(
                            habitacionProvider, habitaciones)) {
                          int days = DateTime.parse(_fechaSalida.text)
                              .difference(DateTime.parse(_fechaEntrada.text))
                              .inDays;

                          if (alternativeTariffInd.any(
                                  (element) => element.code == "tariffFree") &&
                              !applyFreeTariff) {
                            List<TarifaXDia> tarifasEncontradas = getTariffXDia(
                              list,
                              days,
                              habitacionProvider.categoria ??
                                  tipoHabitacion.first,
                              tarifasProvisionalesProvider,
                              descuentoProvider,
                              typeQuote,
                              useCashSeasonRoom,
                            );

                            alternativeTariffInd.clear();

                            for (var tarifaDiaria in tarifasEncontradas) {
                              alternativeTariffInd.add(tarifaDiaria.copyWith());
                            }
                          }
                          for (var element in alternativeTariffInd) {
                            element.temporadaSelect = Utility.getSeasonNow(
                              RegistroTarifa(temporadas: element.temporadas),
                              days,
                              useCashTariff: useCashSeasonRoom,
                            );
                          }

                          habitacionProvider.tarifaXDia = alternativeTariffInd;
                        } else {
                          habitacionProvider.tarifaXDia = recoveryTariffs;
                        }
                        if (alternativeGrupTariff != null) {
                          TarifaXDia? subAlternativeTariff =
                              alternativeGrupTariff?.copyWith();

                          if ((subAlternativeTariff?.tarifasBase ?? [])
                              .isNotEmpty) {
                            subAlternativeTariff?.tarifas =
                                subAlternativeTariff.tarifasBase;
                            subAlternativeTariff?.tarifa = subAlternativeTariff
                                .tarifasBase
                                ?.where((element) =>
                                    element.categoria ==
                                    habitacionProvider.categoria)
                                .toList()
                                .firstOrNull;
                          }

                          habitacionProvider.tarifaGrupal =
                              subAlternativeTariff;
                        } else if (applyFreeTariff) {
                          habitacionProvider.tarifaGrupal =
                              Utility.getUniqueTariffs(
                                      habitacionProvider.tarifaXDia!)
                                  .first;
                        }
                      }
                      ref.read(habitacionesProvider.notifier).editItem(
                          habitacionProvider.folioHabitacion,
                          habitacionProvider);
                    } else {
                      ref
                          .read(habitacionesProvider.notifier)
                          .addItem(habitacionProvider, typeQuote);

                      final politicaTarifaProvider =
                          ref.watch(tariffPolicyProvider(""));
                      final habitaciones = ref.watch(habitacionesProvider);

                      politicaTarifaProvider.when(
                        data: (data) {
                          if (data != null) {
                            int rooms = 0;
                            for (var element in habitaciones) {
                              if (!element.isFree) rooms += element.count;
                            }

                            if (!typeQuote &&
                                rooms >= data.limiteHabitacionCotizacion!) {
                              ref
                                  .watch(typeQuoteProvider.notifier)
                                  .update((ref) => true);
                            } else if (typeQuote &&
                                rooms < data.limiteHabitacionCotizacion!) {
                              ref
                                  .watch(typeQuoteProvider.notifier)
                                  .update((ref) => false);
                            }
                          }
                        },
                        error: (error, stackTrace) {
                          print("Politicas no encontradas");
                        },
                        loading: () {
                          print("Cargando politicas");
                        },
                      );
                    }

                    if (target == 1) {
                      setState(() => target = 0);

                      Future.delayed(
                          500.ms, () => widget.sideController.selectIndex(1));
                    }
                  },
                ).animate(target: target).fadeIn(duration: 800.ms);
              },
              error: (error, stackTrace) => const SizedBox(),
              loading: () => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  bool revisedLimitPax(Habitacion habitacionProvider, int cantidad) {
    if (habitacionProvider.adultos == 4) return true;
    if ((habitacionProvider.adultos! + cantidad) >= 4) return true;

    return false;
  }

  bool defineUseScreenWidth(double screenWidth) {
    bool enable = false;

    if (widget.sideController.extended) {
      enable = screenWidth > 1115;
    } else {
      enable = screenWidth > 950;
    }

    return enable;
  }

  void getTarifasSelect(
    List<RegistroTarifa> list,
    Habitacion habitacion,
    List<TarifaData> tarifasProvisionales,
    double descuentoProvisional, {
    bool onlyCategory = false,
    bool refreshTariff = false,
    required bool isGroup,
    required bool useCashSeason,
  }) {
    if (onlyCategory) {
      for (var tariffDay in habitacion.tarifaXDia!) {
        tariffDay.categoria = habitacion.categoria;
        if (tariffDay.tarifas != null) {
          if (tariffDay.tarifa != null) {
            tariffDay.tarifas!.removeWhere(
                (element) => element.categoria == tariffDay.tarifa!.categoria);
            tariffDay.tarifas!.add(tariffDay.tarifa!);
          }

          tariffDay.tarifa = tariffDay.tarifas!
              .where((element) => element.categoria == habitacion.categoria)
              .firstOrNull;
        } else {
          tariffDay.tarifas = [];
          if (tariffDay.tarifa != null) {
            tariffDay.tarifas!.add(tariffDay.tarifa!);
          }
          tariffDay.tarifa = null;
        }
      }
    } else {
      if (isEditing && !refreshTariff && !isGroup) return;

      if (isGroup || useCashSeason) {
        if (!alreadySaveTariff) {
          for (var element in habitacion.tarifaXDia!) {
            recoveryTariffs.add(element.copyWith());
          }
          alreadySaveTariff = true;
        }
      }

      habitacion.tarifaXDia!.clear();

      int days = DateTime.parse(_fechaSalida.text)
          .difference(DateTime.parse(_fechaEntrada.text))
          .inDays;

      if (isGroup) {
        if (habitacion.tarifaGrupal != null && !alreadyApply) {
          for (var ink = 0; ink < days; ink++) {
            DateTime dateNow =
                DateTime.parse(_fechaEntrada.text).add(Duration(days: ink));
            TarifaXDia newTariff = habitacion.tarifaGrupal!.copyWith();
            newTariff.fecha = dateNow;
            newTariff.dia = ink;
            newTariff.numDays = 1;
            habitacion.tarifaXDia!.add(
              newTariff.copyWith(),
            );
          }
          if (habitacion.tarifaGrupal?.code == "tariffFree") {
            tarifaLibre = habitacion.tarifaGrupal!;
            applyFreeTariff = true;
          } else {
            alternativeGrupTariff = habitacion.tarifaGrupal;
          }
          alreadyApply = true;
        } else {
          List<TarifaXDia> tarifasEncontradas = getTariffXDia(
            list,
            days,
            habitacion.categoria ?? tipoHabitacion.first,
            tarifasProvisionales,
            descuentoProvisional,
            isGroup,
            useCashSeason,
            saveCashTariff: true,
          );

          alternativeTariffInd.clear();

          for (var tarifaDiaria in tarifasEncontradas) {
            alternativeTariffInd.add(tarifaDiaria.copyWith());
          }

          List<TarifaXDia> tarifasFiltradas =
              Utility.getUniqueTariffs(tarifasEncontradas);

          if (tarifasFiltradas.length < 2) {
            TarifaXDia? tarifaGrupal = tarifasFiltradas.first;
            tarifaGrupal.numDays = 1;

            tarifaGrupal.temporadaSelect = Utility.getSeasonNow(
              RegistroTarifa(temporadas: tarifaGrupal.temporadas),
              DateTime.parse(habitacion.fechaCheckOut!)
                  .difference(DateTime.parse(habitacion.fechaCheckIn!))
                  .inDays,
              isGroup: true,
              useCashTariff: false,
            );

            Future.delayed(
              Durations.short2,
              () {
                for (var ink = 0; ink < days; ink++) {
                  TarifaXDia subTariff = tarifaGrupal.copyWith();
                  subTariff.dia = ink;
                  DateTime dateNow = DateTime.parse(_fechaEntrada.text)
                      .add(Duration(days: ink));
                  subTariff.fecha = dateNow;
                  habitacion.tarifaXDia!.add(subTariff.copyWith());
                }
                setState(() {});
              },
            );

            return;
          }

          Future.delayed(
            Durations.medium1,
            () => showDialogRateManager(tarifasFiltradas, habitacion, days),
          );
        }

        return;
      }

      habitacion.tarifaXDia!.addAll(
        getTariffXDia(list, days, habitacion.categoria ?? tipoHabitacion.first,
            tarifasProvisionales, descuentoProvisional, isGroup, useCashSeason),
      );
    }
  }

  void showDialogRateManager(
      List<TarifaXDia> tarifasFiltradas, Habitacion habitacion, int days,
      {bool withoutAction = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return ManagerTariffGroupDialog(tarifasHabitacion: tarifasFiltradas);
      },
    ).then(
      (value) {
        if (value == null) return;
        List<TarifaXDia?> list = value;
        if (list.isEmpty) {
          TarifaXDia? tarifaGrupal = tarifasFiltradas
              .reduce(((a, b) => a.numDays > b.numDays ? a : b));

          if (withoutAction &&
              tarifaGrupal.code == alternativeGrupTariff!.code) {
            return;
          }

          if (withoutAction) habitacion.tarifaXDia!.clear();

          tarifaGrupal.numDays = 1;

          tarifaGrupal.temporadaSelect = Utility.getSeasonNow(
            RegistroTarifa(temporadas: tarifaGrupal.temporadas),
            DateTime.parse(habitacion.fechaCheckOut!)
                .difference(DateTime.parse(habitacion.fechaCheckIn!))
                .inDays,
            isGroup: true,
          );

          Future.delayed(
            Durations.short2,
            () {
              TarifaXDia subTariff = tarifaGrupal.copyWith();
              alternativeGrupTariff = subTariff;
              for (var ink = 0; ink < days; ink++) {
                subTariff.dia = ink;
                DateTime dateNow =
                    DateTime.parse(_fechaEntrada.text).add(Duration(days: ink));
                subTariff.fecha = dateNow;
                habitacion.tarifaXDia!.add(subTariff.copyWith());
              }
              setState(() {});
            },
          );
        } else {
          if (!applyFreeTariff) {
            if (withoutAction &&
                list.first!.code == alternativeGrupTariff?.code) {
              if (list.first?.temporadas != null) {
                if (list.first?.temporadaSelect ==
                    alternativeGrupTariff?.temporadaSelect) {}
              } else {
                if (list.first?.descuentoProvisional ==
                    alternativeGrupTariff?.temporadaSelect) {
                  return;
                }
              }
            }
          }

          if (withoutAction) habitacion.tarifaXDia!.clear();

          TarifaXDia subTariff = list.first!.copyWith();
          subTariff.numDays = 1;
          alternativeGrupTariff = subTariff.copyWith();

          if ((subTariff.tarifasBase ?? []).isNotEmpty) {
            subTariff.tarifas = subTariff.tarifasBase;
            subTariff.tarifa = subTariff.tarifasBase
                ?.where((element) => element.categoria == subTariff.categoria)
                .toList()
                .firstOrNull;
          }

          for (var ink = 0; ink < days; ink++) {
            subTariff.dia = ink;

            DateTime dateNow =
                DateTime.parse(_fechaEntrada.text).add(Duration(days: ink));
            subTariff.fecha = dateNow;
            habitacion.tarifaXDia!.add(subTariff.copyWith());
          }
          setState(() {});
        }
      },
    );
  }

  List<TarifaXDia> getTariffXDia(
      List<RegistroTarifa> list,
      int days,
      String categoria,
      List<TarifaData> tarifasProvisionales,
      double descuentoProvisional,
      bool isGroup,
      bool useCashSeason,
      {bool saveCashTariff = false}) {
    List<TarifaXDia> tarifaXDiaList = [];

    for (var ink = 0; ink < days; ink++) {
      DateTime dateNow =
          DateTime.parse(_fechaEntrada.text).add(Duration(days: ink));

      RegistroTarifa? newTariff = Utility.revisedTariffDay(dateNow, list);

      if (applyFreeTariff) {
        TarifaXDia newTarifaLibre = TarifaXDia(
          code: tarifaLibre.code,
          color: tarifaLibre.color,
          descuentoProvisional: tarifaLibre.descuentoProvisional,
          modificado: tarifaLibre.modificado,
          nombreTariff: tarifaLibre.nombreTariff,
          numDays: tarifaLibre.numDays,
          periodo: tarifaLibre.periodo?.copyWith(),
          subCode: tarifaLibre.subCode,
          tarifa: tarifaLibre.tarifa?.copyWith(),
          tarifas: tarifaLibre.tarifas
              ?.map((element) => element.copyWith())
              .toList(),
          temporadaSelect: tarifaLibre.temporadaSelect?.copyWith(),
          temporadas: tarifaLibre.temporadas
            ?..map((element) => element.copyWith()).toList(),
        );
        newTarifaLibre.dia = ink;
        newTarifaLibre.fecha = dateNow;
        newTarifaLibre.categoria = categoria;
        tarifaXDiaList.add(newTarifaLibre);
        continue;
      }

      if (newTariff == null) {
        TarifaXDia tarifaNoDefinida = TarifaXDia();
        tarifaNoDefinida = TarifaXDia(
          dia: ink,
          fecha: dateNow,
          nombreTariff: "No definido",
          code: "Unknow",
          categoria: categoria,
          descuentoProvisional:
              (tarifasProvisionales.isEmpty) ? 0 : descuentoProvisional,
          tarifas: (tarifasProvisionales.isEmpty)
              ? null
              : tarifasProvisionales
                  .map((element) => element.copyWith())
                  .toList(),
          tarifa: (tarifasProvisionales.isEmpty)
              ? null
              : (tarifasProvisionales
                  .map((element) => element.copyWith())
                  .toList()
                  .where((element) => element.categoria == categoria)
                  .firstOrNull),
        );

        tarifaXDiaList.add(tarifaNoDefinida);
        continue;
      }

      Temporada? selectSeason = Utility.getSeasonNow(
        newTariff.copyWith(),
        days,
        isGroup: isGroup,
        useCashTariff: useCashSeason,
        saveCashTariff: saveCashTariff,
      );

      tarifaXDiaList.add(
        TarifaXDia(
          dia: ink,
          fecha: dateNow,
          color: newTariff.copyWith().color,
          nombreTariff: newTariff.copyWith().nombre,
          categoria: categoria,
          code: newTariff.copyWith().code,
          id: newTariff.copyWith().id,
          periodo: Utility.getPeriodNow(dateNow, newTariff.copyWith().periodos),
          tarifa: (selectSeason?.forCash ?? false)
              ? Utility.getTarifasData([
                  selectSeason?.tarifas
                      ?.where((element) => element.categoria == categoria)
                      .firstOrNull
                      ?.copyWith()
                ]).first
              : newTariff
                  .copyWith()
                  .tarifas!
                  .firstWhere((element) => element.categoria == categoria)
                  .copyWith(),
          temporadaSelect: selectSeason,
          temporadas: newTariff.copyWith().temporadas,
          tarifas: (selectSeason?.forCash ?? false)
              ? Utility.getTarifasData(
                  selectSeason?.tarifas ?? List<Tarifa?>.empty())
              : newTariff
                  .copyWith()
                  .tarifas
                  ?.map((element) => element.copyWith())
                  .toList(),
          tarifasBase: newTariff
              .copyWith()
              .tarifas
              ?.map((element) => element.copyWith())
              .toList(),
        ),
      );
    }

    return tarifaXDiaList;
  }
}
