import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/notificacion_model.dart';
import 'package:generador_formato/providers/dahsboard_provider.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:generador_formato/providers/notificacion_provider.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/widgets/item_rows.dart';
import 'package:generador_formato/widgets/notification_widget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../providers/usuario_provider.dart';
import '../utils/shared_preferences/settings.dart';
import '../widgets/cotizacion_item_row.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/text_styles.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key, required this.sideController});

  final SidebarXController sideController;

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  bool isLoading = false;
  final GlobalKey<TooltipState> messageKey = GlobalKey<TooltipState>();
  bool starflow = false;
  List<NumeroCotizacion> countQuote = [];

  @override
  void initState() {
    super.initState(); // Iniciar el scroll automático fluido
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final notificaciones = ref.watch(NotificacionProvider.provider);
    final typePeriod = ref.watch(filterReport);
    final selectTime = ref.watch(dateReport);
    final reportesSync = ref.watch(reporteCotizacionesIndProvider(''));
    final cotizacionesDiariasSync = ref.watch(cotizacionesDiariasProvider(''));
    final ultimasCotizacionesSync = ref.watch(ultimaCotizacionesProvider(''));
    final allQuotesSync = ref.watch(allQuotesProvider(''));
    final usuario = ref.watch(userProvider);
    final viewNotification = ref.watch(userViewProvider);

    double sizeTitles = screenWidth > 1050
        ? 16
        : screenWidth > 750
            ? 14
            : 12;

    DateTime _getStartOfWeek() {
      return selectTime.subtract(Duration(days: selectTime.weekday - 1));
    }

    DateTime _getEndOfWeek() {
      return _getStartOfWeek().add(const Duration(days: 6));
    }

    String _getPeriodReportSelect() {
      String period = '';

      switch (typePeriod) {
        case "Semanal":
          period = Utility.getRangeDate(
            _getStartOfWeek(),
            _getEndOfWeek(),
          );
        case "Mensual":
          period = "${monthNames[selectTime.month - 1]} ${selectTime.year}";
        case "Anual":
          period = selectTime.year.toString();
        default:
          period = "Unknow";
      }

      return period;
    }

    void _changeDateView({bool isAfter = false}) {
      switch (typePeriod) {
        case "Semanal":
          if (!isAfter) {
            ref.read(dateReport.notifier).update(
                (state) => selectTime.subtract(const Duration(days: 7)));
          } else {
            ref
                .read(dateReport.notifier)
                .update((state) => selectTime.add(const Duration(days: 7)));
          }
        case "Mensual":
          if (!isAfter) {
            ref.read(dateReport.notifier).update((state) => DateTime(
                selectTime.year, (selectTime.month - 1), selectTime.day));
          } else {
            ref.read(dateReport.notifier).update((state) => DateTime(
                selectTime.year, (selectTime.month + 1), selectTime.day));
          }
        case "Anual":
          if (!isAfter) {
            ref.read(dateReport.notifier).update((state) => DateTime(
                (selectTime.year - 1), selectTime.month, selectTime.day));
          } else {
            ref.read(dateReport.notifier).update((state) => DateTime(
                (selectTime.year + 1), selectTime.month, selectTime.day));
          }
        default:
      }
    }

    Widget _countQuotes(bool isCompact, {bool modeHorizontal = false}) {
      return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.standardText(
                      isBold: true,
                      text: !(usuario.rol != "SUPERADMIN" &&
                              usuario.rol != "ADMIN")
                          ? "Contador actual del equipo"
                          : "Tu contador actual",
                      overClip: false,
                      color: Theme.of(context).primaryColor,
                      size: sizeTitles,
                    ),
                    Divider(color: Theme.of(context).primaryColor),
                  ],
                ),
                allQuotesSync.when(
                  data: (list) {
                    if (!starflow) {
                      countQuote =
                          Utility.getDailyQuotesReport(respIndToday: list);

                      List<CotizacionData> quotesAboutExpire =
                          list.where((element) {
                        if (element.fechaLimite == null) return false;

                        int difference = element.fechaLimite!
                            .difference(DateTime.now())
                            .inDays;

                        if (difference <= 2 &&
                            difference > 0 &&
                            (element.esConcretado ?? false)) {
                          return true;
                        }

                        return false;
                      }).toList();

                      Future.delayed(
                        Durations.medium1,
                        () {
                          if (mounted) {
                            ref.read(dateReport.notifier).update(
                                  (state) => DateTime.now().subtract(Duration(
                                      days: DateTime.now().weekday - 1)),
                                );

                            int count = quotesAboutExpire.length;

                            if (count > 0) {
                              Notificacion newNotification = Notificacion(
                                id: 0,
                                level: "alert",
                                icon: HeroIcons.calendar,
                                content:
                                    "Tiene${count > 1 ? "s" : ""} ${count > 1 ? count : "una"} cotizacion${count > 1 ? "es" : ""} que esta${count > 1 ? "n" : ""} a punto de dejar de ser vigentes.",
                                title: "Cotizaciones por Vencer",
                              );

                              if (!notificaciones
                                  .any((element) => element.id == 0)) {
                                ref
                                    .read(userViewProvider.notifier)
                                    .update((state) => false);
                                ref
                                    .watch(
                                        NotificacionProvider.provider.notifier)
                                    .addItem(newNotification);
                              } else {
                                ref
                                    .watch(
                                        NotificacionProvider.provider.notifier)
                                    .editItem(newNotification);
                              }
                            } else {
                              ref
                                  .read(userViewProvider.notifier)
                                  .update((state) => false);
                              if (notificaciones
                                  .any((element) => element.id == 0)) {
                                ref
                                    .watch(
                                        NotificacionProvider.provider.notifier)
                                    .remove(0);
                              }
                            }
                          }
                        },
                      );

                      starflow = true;
                    }

                    List<Widget> cards = [];

                    for (var element in countQuote) {
                      cards.add(
                        Padding(
                          padding:
                              EdgeInsets.only(right: modeHorizontal ? 10 : 0),
                          child: SizedBox(
                            width: modeHorizontal ? 185 : null,
                            child: ItemRows.statusQuoteRow(element,
                                sizeText: isCompact ? 13 : 11),
                          ),
                        ),
                      );
                    }

                    return modeHorizontal
                        ? SizedBox(
                            height: 95,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: cards,
                            ),
                          )
                        : Wrap(children: cards);
                  },
                  error: (error, stackTrace) {
                    return const SizedBox();
                  },
                  loading: () {
                    return ProgressIndicatorCustom(
                      screenHight: 450,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(
            delay: Duration(
              milliseconds: !Settings.applyAnimations
                  ? 0
                  : isCompact
                      ? 250
                      : 500,
            ),
          );
    }

    bool isCompact =
        screenWidth > (1290 - (widget.sideController.extended ? 0 : 115));
    bool isSmallDash =
        screenWidth > (905 - (widget.sideController.extended ? 0 : 115));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStyles.titlePagText(
                      text: "Dashboard", color: Theme.of(context).primaryColor),
                  Row(
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
                      IconButton(
                        onPressed: () {
                          widget.sideController.selectIndex(3);
                        },
                        icon: Icon(
                          Icons.settings,
                          color: brightness == Brightness.light
                              ? DesktopColors.cerulean
                              : DesktopColors.azulUltClaro,
                          size: 26,
                        ),
                      ),
                    ],
                  )
                ],
              ).animate().fadeIn(
                    duration: Settings.applyAnimations
                        ? null
                        : const Duration(milliseconds: 0),
                  ),
              const SizedBox(height: 5),
              if (!isLoading)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: isCompact ? 3 : 2,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextStyles.standardText(
                                          isBold: true,
                                          text: (usuario.rol == "SUPERADMIN" ||
                                                  usuario.rol == "ADMIN")
                                              ? "Reporte de cotizaciones del equipo"
                                              : "Reporte de cotizaciones",
                                          color: Theme.of(context).primaryColor,
                                          size: sizeTitles,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 10,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Iconsax.arrow_left_1_outline,
                                                ),
                                                onPressed: () =>
                                                    _changeDateView(),
                                              ),
                                              TextStyles.standardText(
                                                text: _getPeriodReportSelect(),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Iconsax.arrow_right_4_outline,
                                                ),
                                                onPressed: () =>
                                                    _changeDateView(
                                                        isAfter: true),
                                              ),
                                            ],
                                          ),
                                          CustomDropdown.dropdownMenuCustom(
                                            fontSize: 12,
                                            initialSelection: typePeriod,
                                            onSelected: (String? value) => ref
                                                .read(filterReport.notifier)
                                                .update((state) => value!),
                                            elements: filtrosRegistro,
                                            screenWidth: null,
                                            compact: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  child: Divider(
                                      color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(height: 10),
                                reportesSync.when(
                                  data: (list) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RotatedBox(
                                          quarterTurns: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 110),
                                            child: TextStyles.standardText(
                                              text: "Cotizaciones",
                                              size: 12,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 450,
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              tooltipBehavior: TooltipBehavior(
                                                enable: true,
                                                duration: 1000,
                                                textStyle:
                                                    TextStyles.styleStandar(
                                                  size: 11,
                                                  color: brightness ==
                                                          Brightness.light
                                                      ? Colors.white
                                                      : DesktopColors
                                                          .prussianBlue,
                                                ),
                                              ),
                                              palette: [
                                                DesktopColors.cotGrupal,
                                                DesktopColors.cotIndiv,
                                                DesktopColors.resGrupal,
                                                DesktopColors.resIndiv,
                                              ],
                                              legend: Legend(
                                                  isVisible: true,
                                                  orientation:
                                                      LegendItemOrientation
                                                          .horizontal,
                                                  isResponsive: true,
                                                  position:
                                                      LegendPosition.bottom,
                                                  textStyle:
                                                      TextStyles.styleStandar(
                                                    size: 11,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  overflowMode:
                                                      LegendItemOverflowMode
                                                          .wrap),
                                              series: [
                                                ColumnSeries(
                                                  dataSource: list,
                                                  xValueMapper: (datum, _) =>
                                                      datum.dia,
                                                  yValueMapper: (datum, _) => datum
                                                      .numCotizacionesGrupales,
                                                  name: "Cotizaciones grupales",
                                                ),
                                                ColumnSeries(
                                                  dataSource: list,
                                                  xValueMapper:
                                                      (datum, index) =>
                                                          datum.dia,
                                                  yValueMapper:
                                                      (datum, index) => datum
                                                          .numCotizacionesIndividual,
                                                  name:
                                                      "Cotizaciones Individuales",
                                                ),
                                                SplineSeries<ReporteCotizacion,
                                                    String>(
                                                  splineType:
                                                      SplineType.monotonic,
                                                  dataSource: list,
                                                  xValueMapper:
                                                      (datum, index) =>
                                                          datum.dia,
                                                  yValueMapper:
                                                      (datum, index) => datum
                                                          .numReservacionesGrupales,
                                                  name:
                                                      "Reservaciones grupales",
                                                ),
                                                SplineSeries<ReporteCotizacion,
                                                    String>(
                                                  splineType:
                                                      SplineType.monotonic,
                                                  dataSource: list,
                                                  xValueMapper:
                                                      (datum, index) =>
                                                          datum.dia,
                                                  yValueMapper:
                                                      (datum, index) => datum
                                                          .numReservacionesIndividual,
                                                  name:
                                                      "Reservaciones individuales",
                                                ),
                                              ],
                                              primaryXAxis: CategoryAxis(
                                                labelRotation: 45, //Opcional
                                                labelStyle:
                                                    TextStyles.styleStandar(
                                                  size: 12,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                axisLine:
                                                    const AxisLine(width: 2),
                                                majorGridLines:
                                                    const MajorGridLines(
                                                        width: 0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  error: (error, stackTrace) {
                                    return SizedBox(
                                      height: 450,
                                      child: TextStyles.standardText(
                                        text: "No se han encontrado resultados",
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    );
                                  },
                                  loading: () {
                                    return SizedBox(
                                      height: 450,
                                      child: ProgressIndicatorCustom(
                                        screenHight: 450,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ).animate().fadeIn(
                              delay: !Settings.applyAnimations ? null : 100.ms,
                              duration: Settings.applyAnimations
                                  ? null
                                  : const Duration(milliseconds: 0),
                            ),
                      ),
                      if (isSmallDash) const SizedBox(width: 10),
                      if (isSmallDash)
                        Expanded(
                          child: SizedBox(
                            height: 524,
                            child: _countQuotes(isCompact),
                          ),
                        )
                    ],
                  ),
                ),
              if (!isSmallDash)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SizedBox(
                    height: 180,
                    child: _countQuotes(isCompact, modeHorizontal: true),
                  ),
                ),
              if (isLoading)
                ProgressIndicatorCustom(screenHight: screenHight)
              else
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 390,
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 12, 20, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextStyles.standardText(
                                              isBold: true,
                                              text: "Cotizaciones de hoy",
                                              size: sizeTitles,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Divider(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ],
                                        ),
                                      ),
                                      cotizacionesDiariasSync.when(
                                        data: (list) {
                                          return SfCircularChart(
                                            margin: const EdgeInsets.all(0),
                                            tooltipBehavior: !Utility
                                                    .foundQuotes(list)
                                                ? null
                                                : TooltipBehavior(
                                                    enable: true,
                                                    duration: 1000,
                                                    textStyle:
                                                        TextStyles.styleStandar(
                                                      size: 11,
                                                      color: brightness ==
                                                              Brightness.light
                                                          ? Colors.white
                                                          : DesktopColors
                                                              .prussianBlue,
                                                    ),
                                                  ),
                                            palette: [
                                              (Utility.foundQuotes(list))
                                                  ? DesktopColors.cotGrupal
                                                  : DesktopColors.azulClaro,
                                              DesktopColors.cotIndiv,
                                              DesktopColors.resGrupal,
                                              DesktopColors.resIndiv,
                                              DesktopColors.cotNoConcr,
                                            ],
                                            legend: Legend(
                                              isVisible:
                                                  Utility.foundQuotes(list),
                                              textStyle:
                                                  TextStyles.styleStandar(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 11,
                                              ),
                                              overflowMode:
                                                  LegendItemOverflowMode.wrap,
                                              position: LegendPosition.bottom,
                                            ),
                                            series: [
                                              if (Utility.foundQuotes(list))
                                                DoughnutSeries<NumeroCotizacion,
                                                    String>(
                                                  dataSource: list,
                                                  xValueMapper:
                                                      (datum, index) =>
                                                          datum.tipoCotizacion,
                                                  yValueMapper:
                                                      (datum, index) =>
                                                          datum.numCotizaciones,
                                                  enableTooltip: true,
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                    isVisible: true,
                                                    showZeroValue: false,
                                                    textStyle: TextStyle(
                                                      fontFamily:
                                                          "poppins_regular",
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                )
                                              else
                                                DoughnutSeries<NumeroCotizacion,
                                                    String>(
                                                  dataSource: [
                                                    NumeroCotizacion(
                                                        tipoCotizacion:
                                                            "Sin resultados",
                                                        numCotizaciones: 1)
                                                  ],
                                                  xValueMapper:
                                                      (datum, index) =>
                                                          datum.tipoCotizacion,
                                                  yValueMapper:
                                                      (datum, index) =>
                                                          datum.numCotizaciones,
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
                                cotizacionesDiariasSync.when(
                                  data: (list) {
                                    if (!Utility.foundQuotes(list)) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: Center(
                                          child: TextStyles.standardText(
                                            text: "Sin nuevas\nCotizaciones",
                                            size: 11,
                                            color:
                                                Theme.of(context).primaryColor,
                                            aling: TextAlign.center,
                                          ),
                                        ).animate().fadeIn(
                                              delay: !Settings.applyAnimations
                                                  ? null
                                                  : 350.ms,
                                              duration: Settings.applyAnimations
                                                  ? null
                                                  : const Duration(
                                                      milliseconds: 0),
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
                                cotizacionesDiariasSync.when(
                                  data: (list) {
                                    if (!Utility.foundQuotes(list)) {
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  screenWidth < 1090 ? 32 : 20,
                                              left: 10,
                                              right: 10),
                                          child: Wrap(
                                            runAlignment: WrapAlignment.center,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            alignment: WrapAlignment.center,
                                            spacing: 7,
                                            runSpacing: 4,
                                            children: [
                                              itemTodayData(
                                                "Cotizaciones grupales",
                                                DesktopColors.cotGrupal,
                                                compact: screenWidth < 1090,
                                              ),
                                              itemTodayData(
                                                "Cotizaciones individuales",
                                                DesktopColors.cotIndiv,
                                                compact: screenWidth < 1090,
                                              ),
                                              itemTodayData(
                                                "Reservaciones individuales",
                                                DesktopColors.resIndiv,
                                                compact: screenWidth < 1090,
                                              ),
                                              itemTodayData(
                                                "Reservaciones grupales",
                                                DesktopColors.resGrupal,
                                                compact: screenWidth < 1090,
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
                          ).animate().fadeIn(
                                delay:
                                    !Settings.applyAnimations ? null : 550.ms,
                                duration: Settings.applyAnimations
                                    ? null
                                    : const Duration(milliseconds: 0),
                              ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 390,
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 12, top: 9, bottom: 10, left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextStyles.standardText(
                                                  isBold: true,
                                                  text: !(usuario.rol !=
                                                              "SUPERADMIN" &&
                                                          usuario.rol !=
                                                              "ADMIN")
                                                      ? "Ultimas cotizaciones del equipo"
                                                      : "Ultimas cotizaciones",
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: sizeTitles,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  widget.sideController
                                                      .selectIndex(2);
                                                },
                                                child: TextStyles.buttonText(
                                                  text: "Mostrar todos",
                                                  size: 12,
                                                  color: brightness ==
                                                          Brightness.light
                                                      ? DesktopColors.cerulean
                                                      : DesktopColors
                                                          .azulUltClaro,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ],
                                      ),
                                    ),
                                    ultimasCotizacionesSync.when(
                                      data: (list) {
                                        if (list.isEmpty) {
                                          return SizedBox(
                                            height: 280,
                                            child:
                                                CustomWidgets.messageNotResult(
                                                    context: context),
                                          )
                                              .animate(
                                                delay: !Settings.applyAnimations
                                                    ? null
                                                    : 1250.ms,
                                              )
                                              .slide(
                                                begin: const Offset(0, 0.05),
                                                duration:
                                                    Settings.applyAnimations
                                                        ? null
                                                        : 0.ms,
                                              )
                                              .fadeIn(
                                                duration:
                                                    Settings.applyAnimations
                                                        ? null
                                                        : 0.ms,
                                              );
                                        } else {
                                          return SizedBox(
                                            width: screenWidth,
                                            height: 310,
                                            child: ListView.builder(
                                              itemCount: list.length,
                                              shrinkWrap: false,
                                              itemBuilder: (context, index) {
                                                return ComprobanteItemRow(
                                                  delay: index,
                                                  key: UniqueKey(),
                                                  cotizacion: list[index],
                                                  index: index,
                                                  screenWidth: screenWidth,
                                                  isQuery: true,
                                                );
                                              },
                                            ),
                                          ).animate().fadeIn(
                                                delay: !Settings.applyAnimations
                                                    ? null
                                                    : 1250.ms,
                                                duration:
                                                    Settings.applyAnimations
                                                        ? null
                                                        : 0.ms,
                                              );
                                        }
                                      },
                                      error: (error, stackTrace) {
                                        return SizedBox(
                                          height: 280,
                                          child: CustomWidgets.messageNotResult(
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
                            ).animate().fadeIn(
                                  delay: !Settings.applyAnimations
                                      ? null
                                      : 1050.ms,
                                  duration:
                                      Settings.applyAnimations ? null : 0.ms,
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
}
