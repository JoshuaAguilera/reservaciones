import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/estadistica_model.dart';
import '../models/reporte_cotizacion_model.dart';
import '../res/helpers/animation_helpers.dart';
import '../res/helpers/constants.dart';
import '../res/helpers/date_helpers.dart';
import '../res/helpers/desktop_colors.dart';
import '../res/helpers/utility.dart';
import '../res/ui/buttons.dart';
import '../res/ui/custom_widgets.dart';
import '../res/ui/progress_indicator.dart';
import '../utils/widgets/form_widgets.dart';
import '../utils/widgets/item_rows.dart';
import '../utils/widgets/notification_widget.dart';
import '../utils/widgets/select_buttons_widget.dart';
import '../view-models/providers/dahsboard_provider.dart';
import '../view-models/providers/notificacion_provider.dart';
import '../view-models/providers/usuario_provider.dart';
import '../utils/shared_preferences/settings.dart';
import '../utils/widgets/cotizacion_item_row.dart';
import '../utils/widgets/custom_dropdown.dart';
import '../res/ui/text_styles.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key, required this.sideController});
  final SidebarXController sideController;

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  bool isLoading = false;
  final GlobalKey<TooltipState> messageKey = GlobalKey<TooltipState>();
  bool starflow = false;
  Widget? statisticsWidget;
  List<Estadistica> statistics = [];

  List<Metrica> metricas = [
    Metrica(
      title: "Disponibilidad",
      value: 65,
      isPorcentage: true,
      description: "En las ultimas 24 horas",
    ),
    Metrica(
      title: "Ocupacion",
      value: 35,
      isPorcentage: true,
      description: "En las ultimas 24 horas",
    ),
    Metrica(
      title: "Cotizaciones Hoy",
      value: 3,
      initValue: 4,
      description: "Cotizaciones ayer:",
    ),
    Metrica(
      title: "Cotizaciones Semanal",
      value: 10,
      initValue: 25,
      description: "Periodo anterior:",
    ),
    Metrica(
      title: "Cotizaciones 30 Dias",
      value: 240,
      initValue: 370,
      description: "Periodo anterior:",
    ),
    Metrica(
      title: "Cotizaciones 90 Dias",
      value: 750,
      initValue: 635,
      description: "Periodo anterior:",
    ),
  ];

  @override
  void initState() {
    statistics = Utility.getDailyQuotesReport(respIndToday: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final sizeScreen = MediaQuery.of(context).size;
    final notificaciones = ref.watch(NotificacionProvider.provider);
    final typePeriod = ref.watch(filterReport);
    final selectTime = ref.watch(dateReportProvider);
    final reportesSync = ref.watch(reporteCotizacionesIndProvider(''));
    final cotizacionesDiariasSync = ref.watch(cotizacionesDiariasProvider(''));
    final ultimasCotizacionesSync = ref.watch(ultimaCotizacionesProvider(''));
    final countQuotes = ref.watch(statisticsQuoteProvider(statistics));
    final usuario = ref.watch(userProvider);
    final filtro = ref.watch(filtroDashboardProvider);
    final viewNotification = ref.watch(userViewProvider);
    final realWidth =
        sizeScreen.width - (widget.sideController.extended ? 130 : 0);

    double sizeTitles = realWidth > 1050
        ? 16
        : realWidth > 750
            ? 15
            : 13;

    void changeDateView({bool isAfter = false}) {
      ref.read(dateReportProvider.notifier).changeDateView(
            typePeriod: typePeriod,
            isAfter: isAfter,
          );
    }

    Widget _countQuotes(bool isCompact) {
      return AnimatedEntry(
        delay: Duration(milliseconds: isCompact ? 250 : 500),
        child: countQuotes.when(
          data: (list) {
            if (!starflow) {
              statisticsWidget = ItemRow.statisticsRow(list);
              starflow = true;
            }
            return statisticsWidget!;
          },
          error: (error, _) => const SizedBox(),
          loading: () {
            statisticsWidget ??= ItemRow.statisticsRow(statistics);
            return statisticsWidget!;
          },
        ),
      );
    }

    bool isCompact =
        sizeScreen.width > (1290 - (widget.sideController.extended ? 0 : 115));

    Widget textTitle(String text) {
      return TextStyles.standardText(
        isBold: true,
        text: text,
        size: sizeTitles,
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedEntry(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 40,
                          child: FormWidgets.textFormField(
                            name: "Buscar",
                            suffixIcon: const Icon(
                              Iconsax.search_normal_1_outline,
                              size: 20,
                            ),
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            NotificationWidget(
                              keyTool: messageKey,
                              notifications: notificaciones,
                              viewNotification: viewNotification,
                              onPressed: () {
                                if (!viewNotification) {
                                  ref
                                      .read(userViewProvider.notifier)
                                      .update((state) => true);
                                }
                              },
                            ),
                            Buttons.floatingButton(
                              context,
                              tag: "settings",
                              icon: Iconsax.setting_2_outline,
                              onPressed: () {
                                if (!viewNotification) {
                                  ref
                                      .read(userViewProvider.notifier)
                                      .update((state) => true);
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextStyles.titlePagText(text: "Dashboard"),
                                TextStyles.standardText(
                                  text:
                                      "Planifica, prioriza y realiza tus tareas con facilidad.",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: Row(
                              spacing: 10,
                              children: [
                                Buttons.buttonPrimary(
                                  text: "Crear cotización",
                                  icon: Iconsax.card_add_outline,
                                  backgroundColor: DesktopColors.primary1,
                                  onPressed: () {},
                                ),
                                Buttons.buttonSecundary(
                                  text: "Crear tarifa",
                                  icon: Iconsax.wallet_add_1_outline,
                                  foregroundColor: DesktopColors.primary1,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: textTitle(filtro == "Individual"
                                    ? "Tus Cotizaciones"
                                    : "Cotizaciones del equipo"),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: SelectButtonsWidget(
                                  selectButton: filtro,
                                  buttons: [
                                    {"Individual": DesktopColors.primary3},
                                    {"Equipo": DesktopColors.primary5},
                                  ],
                                  onPressed: (p0) {
                                    ref
                                        .read(filtroDashboardProvider.notifier)
                                        .update((state) =>
                                            p0 == 0 ? "Individual" : "Equipo");
                                    starflow = false;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          _countQuotes(isCompact),
                        ],
                      ),
                      if (!isLoading)
                        SizedBox(
                          height: 550,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: AnimatedEntry(
                                  delay: const Duration(milliseconds: 100),
                                  child: Card(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        top: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: textTitle(
                                                    "Reporte de cotizaciones",
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  spacing: 10,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 28,
                                                              minWidth: 28,
                                                            ),
                                                            icon: const Icon(
                                                              Iconsax
                                                                  .arrow_left_1_outline,
                                                              size: 18,
                                                            ),
                                                            onPressed: () =>
                                                                changeDateView(),
                                                          ),
                                                          TextStyles
                                                              .standardText(
                                                            text: DateHelpers
                                                                .getPeriodSelect(
                                                              typePeriod,
                                                              selectTime,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            constraints:
                                                                const BoxConstraints(
                                                              minHeight: 28,
                                                              minWidth: 28,
                                                            ),
                                                            icon: const Icon(
                                                              Iconsax
                                                                  .arrow_right_4_outline,
                                                              size: 18,
                                                            ),
                                                            onPressed: () =>
                                                                changeDateView(
                                                                    isAfter:
                                                                        true),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    CustomDropdown
                                                        .dropdownMenuCustom(
                                                      fontSize: 12,
                                                      initialSelection:
                                                          typePeriod,
                                                      onSelected:
                                                          (String? value) => ref
                                                              .read(filterReport
                                                                  .notifier)
                                                              .update((state) =>
                                                                  value!),
                                                      elements: filtrosRegistro,
                                                      screenWidth: null,
                                                      compact: true,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          SizedBox(
                                            height: 470,
                                            child: reportesSync.when(
                                              data: (list) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    RotatedBox(
                                                      quarterTurns: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8.0,
                                                                left: 110),
                                                        child: TextStyles
                                                            .standardText(
                                                          text:
                                                              "Num. Cotizaciones",
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SfCartesianChart(
                                                        plotAreaBorderWidth: 0,
                                                        tooltipBehavior:
                                                            TooltipBehavior(
                                                          enable: true,
                                                          duration: 1000,
                                                          textStyle: TextStyles
                                                              .styleStandar(
                                                                  size: 11),
                                                        ),
                                                        palette: [
                                                          DesktopColors
                                                              .cotGrupal,
                                                          DesktopColors
                                                              .cotIndiv,
                                                          DesktopColors
                                                              .resGrupal,
                                                          DesktopColors
                                                              .resIndiv,
                                                        ],
                                                        legend: Legend(
                                                          isVisible: true,
                                                          orientation:
                                                              LegendItemOrientation
                                                                  .horizontal,
                                                          isResponsive: true,
                                                          position:
                                                              LegendPosition
                                                                  .bottom,
                                                          textStyle: TextStyles
                                                              .styleStandar(
                                                            size: 11,
                                                          ),
                                                          overflowMode:
                                                              LegendItemOverflowMode
                                                                  .wrap,
                                                        ),
                                                        series: [
                                                          columnSeries(
                                                            dataSource: list,
                                                            esGrupal: true,
                                                          ),
                                                          columnSeries(
                                                            dataSource: list,
                                                          ),
                                                          splineSeries(
                                                            dataSource: list,
                                                            esGrupal: true,
                                                          ),
                                                          splineSeries(
                                                            dataSource: list,
                                                          ),
                                                        ],
                                                        primaryXAxis:
                                                            CategoryAxis(
                                                          labelRotation:
                                                              45, //Opcional
                                                          labelStyle: TextStyles
                                                              .styleStandar(
                                                            size: 12,
                                                          ),
                                                          axisLine:
                                                              const AxisLine(
                                                                  width: 2),
                                                          majorGridLines:
                                                              const MajorGridLines(
                                                                  width: 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              error: (error, stackTrace) {
                                                return TextStyles.standardText(
                                                  text:
                                                      "No se han encontrado resultados",
                                                );
                                              },
                                              loading: () {
                                                return ProgressIndicatorCustom(
                                                  screenHight: 450,
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: realWidth > 980 ? 1 : 0,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: realWidth > 980 ? 240 : 120,
                                  ),
                                  child: Card(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 16, 10, 10),
                                      child: Column(
                                        spacing: 10,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              textTitle("Metricas"),
                                              if (realWidth > 980)
                                                Flexible(
                                                  child:
                                                      TextStyles.standardText(
                                                    text: DateHelpers
                                                        .getStringDate(
                                                      data: DateTime.now(),
                                                      compact: true,
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                          ListView.builder(
                                            itemCount: metricas.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              Metrica estadistica =
                                                  metricas[index];
                                              return ItemRow.metricWidget(
                                                index,
                                                estadistica: estadistica,
                                                sideController:
                                                    widget.sideController,
                                              );
                                            },
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
                      if (isLoading)
                        ProgressIndicatorCustom(screenHight: sizeScreen.height)
                      else
                        Center(
                          child: SizedBox(
                            height: 390,
                            child: Row(
                              spacing: 10,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: AnimatedEntry(
                                    delay: const Duration(milliseconds: 550),
                                    child: Stack(
                                      children: [
                                        Card(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: textTitle(
                                                      "Cotizaciones de hoy"),
                                                ),
                                                cotizacionesDiariasSync.when(
                                                  data: (list) {
                                                    return SfCircularChart(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              0),
                                                      tooltipBehavior: !Utility
                                                              .foundQuotes(list)
                                                          ? null
                                                          : TooltipBehavior(
                                                              enable: true,
                                                              duration: 1000,
                                                              textStyle: TextStyles
                                                                  .styleStandar(
                                                                size: 11,
                                                                color: brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? Colors
                                                                        .white
                                                                    : DesktopColors
                                                                        .prussianBlue,
                                                              ),
                                                            ),
                                                      palette: [
                                                        (Utility.foundQuotes(
                                                                list))
                                                            ? DesktopColors
                                                                .cotGrupal
                                                            : DesktopColors
                                                                .azulClaro,
                                                        DesktopColors.cotIndiv,
                                                        DesktopColors.resGrupal,
                                                        DesktopColors.resIndiv,
                                                      ],
                                                      legend: Legend(
                                                        isVisible:
                                                            Utility.foundQuotes(
                                                                list),
                                                        textStyle: TextStyles
                                                            .styleStandar(
                                                          size: 11,
                                                        ),
                                                        overflowMode:
                                                            LegendItemOverflowMode
                                                                .wrap,
                                                        position: LegendPosition
                                                            .bottom,
                                                      ),
                                                      series: [
                                                        if (Utility.foundQuotes(
                                                            list))
                                                          DoughnutSeries<
                                                              Estadistica,
                                                              String>(
                                                            dataSource: list,
                                                            xValueMapper:
                                                                (datum, index) =>
                                                                    datum.title,
                                                            yValueMapper: (datum,
                                                                    index) =>
                                                                datum.numNow,
                                                            enableTooltip: true,
                                                            dataLabelSettings:
                                                                const DataLabelSettings(
                                                              isVisible: true,
                                                              showZeroValue:
                                                                  false,
                                                              textStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    "poppins_regular",
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                          )
                                                        else
                                                          DoughnutSeries<
                                                              Estadistica,
                                                              String>(
                                                            dataSource: [
                                                              Estadistica(
                                                                  title:
                                                                      "Sin resultados",
                                                                  numNow: 1)
                                                            ],
                                                            xValueMapper:
                                                                (datum, index) =>
                                                                    datum.title,
                                                            yValueMapper: (datum,
                                                                    index) =>
                                                                datum.numNow,
                                                          )
                                                      ],
                                                    );
                                                  },
                                                  error: (error, stackTrace) {
                                                    return const SizedBox();
                                                  },
                                                  loading: () {
                                                    return ProgressIndicatorCustom(
                                                        screenHight: 350);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: cotizacionesDiariasSync.when(
                                            data: (list) {
                                              if (!Utility.foundQuotes(list)) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: AnimatedEntry(
                                                    delay: const Duration(
                                                        milliseconds: 350),
                                                    child:
                                                        TextStyles.standardText(
                                                      text:
                                                          "Sin nuevas\nCotizaciones",
                                                      size: 11,
                                                      align: TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            },
                                            error: (error, _) => Container(),
                                            loading: () => const SizedBox(),
                                          ),
                                        ),
                                        cotizacionesDiariasSync.when(
                                          data: (list) {
                                            if (!Utility.foundQuotes(list)) {
                                              return Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: realWidth < 1090
                                                        ? 32
                                                        : 20,
                                                  ),
                                                  child: Wrap(
                                                    runAlignment:
                                                        WrapAlignment.center,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    alignment:
                                                        WrapAlignment.center,
                                                    spacing: 7,
                                                    runSpacing: 4,
                                                    children: [
                                                      itemTodayData(
                                                        "Cotizaciones grupales",
                                                        DesktopColors.cotGrupal,
                                                        compact:
                                                            realWidth < 1090,
                                                      ),
                                                      itemTodayData(
                                                        "Cotizaciones individuales",
                                                        DesktopColors.cotIndiv,
                                                        compact:
                                                            realWidth < 1090,
                                                      ),
                                                      itemTodayData(
                                                        "Reservaciones individuales",
                                                        DesktopColors.resIndiv,
                                                        compact:
                                                            realWidth < 1090,
                                                      ),
                                                      itemTodayData(
                                                        "Reservaciones grupales",
                                                        DesktopColors.resGrupal,
                                                        compact:
                                                            realWidth < 1090,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          },
                                          error: (error, stackTrace) {
                                            return Container();
                                          },
                                          loading: () {
                                            return const SizedBox();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: AnimatedEntry(
                                    delay: const Duration(milliseconds: 1050),
                                    child: Card(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: textTitle(!(usuario
                                                                    ?.rol
                                                                    ?.nombre !=
                                                                "SUPERADMIN" &&
                                                            usuario?.rol
                                                                    ?.nombre !=
                                                                "ADMIN")
                                                        ? "Ultimas cotizaciones del equipo"
                                                        : "Ultimas cotizaciones"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      widget.sideController
                                                          .selectIndex(2);
                                                    },
                                                    child:
                                                        TextStyles.buttonText(
                                                      text: "Mostrar todos",
                                                      size: 12,
                                                      color: brightness ==
                                                              Brightness.light
                                                          ? DesktopColors
                                                              .cerulean
                                                          : DesktopColors
                                                              .azulUltClaro,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ultimasCotizacionesSync.when(
                                              data: (list) {
                                                if (list.isEmpty) {
                                                  return SizedBox(
                                                    height: 280,
                                                    child: CustomWidgets
                                                        .messageNotResult(
                                                            context: context),
                                                  )
                                                      .animate(
                                                        delay: !Settings
                                                                .applyAnimations
                                                            ? null
                                                            : 1250.ms,
                                                      )
                                                      .slide(
                                                        begin: const Offset(
                                                            0, 0.05),
                                                        duration: Settings
                                                                .applyAnimations
                                                            ? null
                                                            : 0.ms,
                                                      )
                                                      .fadeIn(
                                                        duration: Settings
                                                                .applyAnimations
                                                            ? null
                                                            : 0.ms,
                                                      );
                                                } else {
                                                  return AnimatedEntry(
                                                    delay: const Duration(
                                                        milliseconds: 1250),
                                                    child: SizedBox(
                                                      width: realWidth,
                                                      height: 310,
                                                      child: ListView.builder(
                                                        itemCount: list.length,
                                                        shrinkWrap: false,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ComprobanteItemRow(
                                                            delay: index,
                                                            key: UniqueKey(),
                                                            cotizacion:
                                                                list[index],
                                                            index: index,
                                                            screenWidth:
                                                                realWidth,
                                                            isQuery: true,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              error: (error, stackTrace) {
                                                return SizedBox(
                                                  height: 280,
                                                  child: CustomWidgets
                                                      .messageNotResult(
                                                          context: context),
                                                );
                                              },
                                              loading: () {
                                                return ProgressIndicatorCustom(
                                                    screenHight: 320);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget itemTodayData(String name, Color? colorIcon, {bool compact = false}) {
    return SizedBox(
      width: compact ? 25 : 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Tooltip(
            message: compact ? name : "",
            child: Icon(EvaIcons.pie_chart_outline, color: colorIcon, size: 15),
          ),
          if (!compact) const SizedBox(width: 5),
          if (!compact)
            Expanded(
              child: TextStyles.standardText(
                text: name,
                color: Theme.of(context).primaryColor,
                size: 11,
              ),
            ),
        ],
      ),
    );
  }

  splineSeries({List<ReporteCotizacion>? dataSource, bool esGrupal = false}) {
    return SplineSeries<ReporteCotizacion, String>(
      splineType: SplineType.monotonic,
      dataSource: dataSource ?? [],
      xValueMapper: (datum, index) => datum.dia,
      yValueMapper: (datum, index) {
        if (esGrupal) return datum.numReservacionesGrupales;
        return datum.numReservacionesIndividual;
      },
      name: "Reservaciones ${esGrupal ? "grupales" : "individuales"}",
    );
  }

  columnSeries({List<ReporteCotizacion>? dataSource, bool esGrupal = false}) {
    return ColumnSeries<ReporteCotizacion, String>(
      dataSource: dataSource ?? [],
      xValueMapper: (datum, index) => datum.dia,
      yValueMapper: (datum, index) {
        if (esGrupal) return datum.numCotizacionesGrupales;
        return datum.numCotizacionesIndividual;
      },
      name: "Cotizaciones ${esGrupal ? "grupales" : "individuales"}",
    );
  }
}
