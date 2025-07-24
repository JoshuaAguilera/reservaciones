import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:generador_formato/res/ui/message_error_scroll.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/estadistica_model.dart';
import '../../models/reporte_cotizacion_model.dart';
import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/constants.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/general_helpers.dart';
import '../../res/helpers/utility.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/ui/text_styles.dart';
import '../../utils/widgets/custom_dropdown.dart';
import '../../utils/widgets/item_rows.dart';
import '../../view-models/providers/dashboard_provider.dart';
import '../../view-models/providers/ui_provider.dart';

class DashboardQuoteGraphic extends ConsumerStatefulWidget {
  const DashboardQuoteGraphic({super.key});

  @override
  ConsumerState<DashboardQuoteGraphic> createState() =>
      _DashboardQuoteGraphicState();
}

class _DashboardQuoteGraphicState extends ConsumerState<DashboardQuoteGraphic> {
  final sampleMetric = ItemRow.metricWidget(1, isLoading: true);
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
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final typePeriod = ref.watch(filterReport);
    final selectTime = ref.watch(dateReportProvider);
    final filtro = ref.watch(filtroDashboardProvider);
    final reportesSync = ref.watch(reporteCotizacionesIndProvider(''));
    final sideController = ref.watch(sidebarControllerProvider);
    final realWidth = sizeScreen.width - (sideController.extended ? 130 : 0);
    final cotizaciones24h = ref.watch(cotizaciones24hProvider(''));
    final cotizaciones7d = ref.watch(cotizaciones7dProvider(''));
    final cotizaciones30d = ref.watch(cotizaciones30dProvider(''));
    final cotizaciones90d = ref.watch(cotizaciones90dProvider(''));

    void changeDateView({bool isAfter = false}) {
      ref.read(dateReportProvider.notifier).changeDateView(
            typePeriod: typePeriod,
            isAfter: isAfter,
          );
    }

    Widget textTitle(String text) {
      return AppText.sectionTitleText(text: text);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: AnimatedEntry(
            delay: const Duration(milliseconds: 150),
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: textTitle("Reporte de cotizaciones"),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minHeight: 28,
                                        minWidth: 28,
                                      ),
                                      icon: const Icon(
                                        Iconsax.arrow_left_1_outline,
                                        size: 18,
                                      ),
                                      onPressed: () => changeDateView(),
                                    ),
                                    AppText.simpleText(
                                      text: DateHelpers.getPeriodSelect(
                                        typePeriod,
                                        selectTime,
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minHeight: 28,
                                        minWidth: 28,
                                      ),
                                      icon: const Icon(
                                        Iconsax.arrow_right_4_outline,
                                        size: 18,
                                      ),
                                      onPressed: () =>
                                          changeDateView(isAfter: true),
                                    ),
                                  ],
                                ),
                              ),
                              CustomDropdown.dropdownMenuCustom(
                                initialSelection: typePeriod,
                                onSelected: (String? value) {
                                  ref
                                      .read(filterReport.notifier)
                                      .update((state) => value!);
                                },
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
                          Map<String, List<ReporteCotizacion>> map =
                              Utility.getReportByUser(list);

                          List<CartesianSeries<dynamic, dynamic>> seriesGrup =
                              [];

                          for (var element in map.entries) {
                            final serie = columnSeries(
                              dataSource: element.value,
                              esGrupal: true,
                              filtro: filtro,
                            );

                            seriesGrup.add(serie);
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 110),
                                  child: AppText.simpleText(
                                    text: "Num. Cotizaciones",
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    duration: 1000,
                                  ),
                                  palette: filtro == "Equipo"
                                      ? DesktopColors.getPrimaryColors()
                                      : DesktopColors.getQuotesColors(),
                                  legend: Legend(
                                    isVisible: true,
                                    orientation:
                                        LegendItemOrientation.horizontal,
                                    isResponsive: true,
                                    position: LegendPosition.bottom,
                                    textStyle: AppText.simpleStyle(
                                      size: 10,
                                      maxSize: 11,
                                    ),
                                    overflowMode: LegendItemOverflowMode.wrap,
                                  ),
                                  series: filtro == "Equipo"
                                      ? seriesGrup
                                      : [
                                          columnSeries(
                                              dataSource: list,
                                              esGrupal: true,
                                              filtro: filtro),
                                          columnSeries(
                                              dataSource: list, filtro: filtro),
                                          splineSeries(
                                            dataSource: list,
                                            esGrupal: true,
                                            filtro: filtro,
                                          ),
                                          splineSeries(
                                            dataSource: list,
                                            filtro: filtro,
                                          ),
                                        ],
                                  primaryXAxis: CategoryAxis(
                                    labelRotation:
                                        filtro == "Equipo" ? 0 : 45, //Opcional
                                    labelStyle:
                                        AppText.simpleStyle(maxSize: 12),
                                    axisLine: const AxisLine(width: 2),
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        error: (error, _) => const MessageErrorScroll(),
                        loading: () {
                          return ProgressIndicatorCustom(screenHight: 450);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: GeneralHelpers.clampSize(380.w, min: 135, max: 320),
          child: AnimatedEntry(
            delay: const Duration(milliseconds: 250),
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textTitle("Metricas"),
                        if (realWidth > 980)
                          Flexible(
                            child: AppText.simpleText(
                              text: DateHelpers.getStringDate(
                                data: DateTime.now(),
                                compact: true,
                              ),
                              align: TextAlign.end,
                            ),
                          )
                      ],
                    ),
                    AnimatedEntry(
                      child: Column(
                        children: [
                          cotizaciones24h.when(
                            data: (metric) {
                              return ItemRow.metricWidget(0, metrica: metric);
                            },
                            error: (error, _) => Container(),
                            loading: () => sampleMetric,
                          ),
                          cotizaciones7d.when(
                            data: (metric) {
                              return ItemRow.metricWidget(1, metrica: metric);
                            },
                            error: (error, _) => Container(),
                            loading: () => sampleMetric,
                          ),
                          cotizaciones30d.when(
                            data: (metric) {
                              return ItemRow.metricWidget(2, metrica: metric);
                            },
                            error: (error, _) => Container(),
                            loading: () => sampleMetric,
                          ),
                          cotizaciones90d.when(
                            data: (metric) {
                              return ItemRow.metricWidget(3, metrica: metric);
                            },
                            error: (error, _) => Container(),
                            loading: () => sampleMetric,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  splineSeries({
    List<ReporteCotizacion>? dataSource,
    bool esGrupal = false,
    String filtro = "Individual",
  }) {
    return SplineSeries<ReporteCotizacion, String>(
      splineType: SplineType.monotonic,
      dataSource: dataSource ?? [],
      xValueMapper: (datum, index) {
        return filtro == "Equipo"
            ? datum.usuario?.nombre ?? "Sin actividad."
            : datum.dia;
      },
      yValueMapper: (datum, index) {
        if (esGrupal) return datum.numReservacionesGrupales;
        return datum.numReservacionesIndividual;
      },
      name: "Reservaciones ${esGrupal ? "grupales" : "individuales"}",
    );
  }

  columnSeries({
    List<ReporteCotizacion>? dataSource,
    bool esGrupal = false,
    String filtro = "Individual",
  }) {
    return ColumnSeries<ReporteCotizacion, String>(
      dataSource: dataSource ?? [],
      xValueMapper: (datum, index) {
        return filtro == "Equipo"
            ? datum.usuario?.username ?? "Sin actividad."
            : datum.dia;
      },
      yValueMapper: (datum, index) {
        if (filtro == "Equipo") return datum.totalCotizaciones;
        if (esGrupal) return datum.numCotizacionesGrupales;
        return datum.numCotizacionesIndividual;
      },
      name:
          "Cotizaciones ${filtro == "Equipo" ? "" : esGrupal ? "grupales" : "individuales"}",
    );
  }
}
