import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/dahsboard_provider.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/models/cotizacion_diaria_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:generador_formato/providers/notificacion_provider.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/widgets/notification_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuple/tuple.dart';

import '../widgets/comprobante_item_row.dart';
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
  late TooltipBehavior _tooltipBehavior;
  String dropdownValue = filtrosRegistro.first;
  final GlobalKey<TooltipState> messageKey = GlobalKey<TooltipState>();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        duration: 1000,
        textStyle: TextStyles.styleStandar(color: Colors.white, size: 11));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final notificaciones = ref.watch(NotificacionProvider.provider);
    final reportesSync = ref.watch(
        reporteCotizacionesProvider(const Tuple2<String, dynamic>('', '')));
    final cotizacionesDiariasSync = ref.watch(
        cotizacionesDiariasProvider(const Tuple2<String, dynamic>('', '')));
    final ultimasCotizacionesSync = ref.watch(
        ultimaCotizacionesProvider(const Tuple2<String, dynamic>('', '')));

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
                  TextStyles.titlePagText(text: "Dashboard"),
                  Row(
                    children: [
                      NotificationWidget.notificationsWidget(
                          key: messageKey,
                          screenWidth: screenWidth,
                          notifications: notificaciones),
                      IconButton(
                        onPressed: () {
                          widget.sideController.selectIndex(3);
                        },
                        icon: Icon(
                          Icons.settings,
                          color: DesktopColors.cerulean,
                          size: 26,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 5),
              if (!isLoading)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextStyles.standardText(
                                          isBold: true,
                                          text: "Reporte de cotizaciones",
                                          overClip: true,
                                          size: 16),
                                      CustomDropdown.dropdownMenuCustom(
                                          fontSize: 12,
                                          initialSelection:
                                              filtrosRegistro.first,
                                          onSelected: (String? value) {
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                          },
                                          elements: filtrosRegistro,
                                          screenWidth: null),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 7),
                                reportesSync.when(
                                  data: (list) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RotatedBox(
                                          quarterTurns: 3,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: TextStyles.standardText(
                                                text: "Cotizaciones", size: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 450,
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              tooltipBehavior: _tooltipBehavior,
                                              palette: [
                                                DesktopColors.cotGroupColor,
                                                DesktopColors.cotIndColor,
                                                DesktopColors.cotGroupPreColor,
                                                DesktopColors.cotIndPreColor
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
                                                          size: 11),
                                                  overflowMode:
                                                      LegendItemOverflowMode
                                                          .wrap),
                                              series: [
                                                StackedColumnSeries<
                                                    ReporteCotizacion, String>(
                                                  dataSource: list,
                                                  xValueMapper: (datum, _) =>
                                                      datum.dia,
                                                  yValueMapper: (datum, _) => datum
                                                      .numCotizacionesGrupales,
                                                  name: "Cotizaciones grupales",
                                                ),
                                                StackedColumnSeries<
                                                    ReporteCotizacion, String>(
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
                                                          .numCotizacionesGrupalesPreventa,
                                                  name:
                                                      "Cotizaciones grupales oferta",
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
                                                          .numCotizacionesIndividualPreventa,
                                                  name:
                                                      "Cotizaciones individuales oferta",
                                                ),
                                              ],
                                              primaryXAxis: CategoryAxis(
                                                labelStyle:
                                                    TextStyles.styleStandar(
                                                        size: 12),
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
                                    return const Text(
                                        'No se encontraron resultados');
                                  },
                                  loading: () {
                                    return SizedBox(
                                        height: 450,
                                        child: ProgressIndicatorCustom(250));
                                  },
                                )
                              ],
                            ),
                          ),
                        ).animate().fadeIn(),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 500,
                          child: const Card(
                            elevation: 5,
                            child: SizedBox(),
                          )
                              .animate()
                              .fadeIn(delay: const Duration(milliseconds: 500)),
                        ),
                      )
                    ],
                  ),
                ),
              if (isLoading)
                ProgressIndicatorCustom(screenHight)
              else
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 400,
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, left: 20),
                                        child: TextStyles.standardText(
                                          isBold: true,
                                          text: "Reporte de hoy",
                                          size: 16,
                                        ),
                                      ),
                                      cotizacionesDiariasSync.when(
                                        data: (list) {
                                          return SfCircularChart(
                                            tooltipBehavior:
                                                !Utility.foundQuotes(list)
                                                    ? null
                                                    : _tooltipBehavior,
                                            palette: [
                                              DesktopColors.cotGroupColor,
                                              DesktopColors.cotIndColor,
                                              DesktopColors.cotGroupPreColor,
                                              DesktopColors.cotIndPreColor
                                            ],
                                            legend: Legend(
                                              isVisible: true,
                                              textStyle:
                                                  TextStyles.styleStandar(
                                                      size: 11),
                                              overflowMode:
                                                  LegendItemOverflowMode.wrap,
                                              position: LegendPosition.bottom,
                                            ),
                                            series: [
                                              DoughnutSeries<CotizacionDiaria,
                                                  String>(
                                                dataSource: list,
                                                xValueMapper: (datum, index) =>
                                                    datum.tipoCotizacion,
                                                yValueMapper: (datum, index) =>
                                                    datum.numCotizaciones,
                                                enableTooltip: true,
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                        isVisible: true,
                                                        showZeroValue: false,
                                                        textStyle: TextStyle(
                                                            fontFamily:
                                                                "poppins_regular",
                                                            fontSize: 11)),
                                              ),
                                              if (!Utility.foundQuotes(list))
                                                DoughnutSeries<CotizacionDiaria,
                                                    String>(
                                                  dataSource: [
                                                    CotizacionDiaria(
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
                                              screenHight * 0.4);
                                        },
                                      )
                                    ],
                                  ),
                                ).animate().fadeIn(
                                    delay: const Duration(milliseconds: 750)),
                                cotizacionesDiariasSync.when(
                                  data: (list) {
                                    if (!Utility.foundQuotes(list)) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 85.0),
                                        child: Center(
                                            child: TextStyles.standardText(
                                                text: "Sin resultados",
                                                size: 11)),
                                      ).animate().fadeIn(
                                          delay: const Duration(
                                              milliseconds: 850));
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                  error: (error, stackTrace) {
                                    return Container();
                                  },
                                  loading: () {
                                    return SizedBox();
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                              height: 400,
                              child: Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, top: 12, bottom: 10, left: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextStyles.standardText(
                                                isBold: true,
                                                text: "Ultimas cotizaciones",
                                                size: 16),
                                            TextButton(
                                              onPressed: () {
                                                widget.sideController
                                                    .selectIndex(2);
                                              },
                                              child: TextStyles.buttonText(
                                                  text: "Mostrar todos",
                                                  size: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ultimasCotizacionesSync.when(
                                        data: (list) {
                                          if (list.isEmpty) {
                                            return Center(
                                                child: TextStyles.standardText(
                                                    text:
                                                        "No se encontraron cotizaciones"));
                                          } else {
                                            return SizedBox(
                                              width: screenWidth,
                                              height: 330,
                                              child: ListView.builder(
                                                itemCount: list.length,
                                                shrinkWrap: false,
                                                itemBuilder: (context, index) {
                                                  return ComprobanteItemRow(
                                                    delay: index,
                                                    key: UniqueKey(),
                                                    comprobante: list[index],
                                                    index: index,
                                                    screenWidth: screenWidth,
                                                    isQuery: true,
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        error: (error, stackTrace) {
                                          return Center(
                                              child: TextStyles.standardText(
                                                  text:
                                                      "No se encontraron cotizaciones"));
                                        },
                                        loading: () {
                                          return ProgressIndicatorCustom(
                                              screenHight * 0.4);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ).animate().fadeIn(
                                  delay: const Duration(milliseconds: 1050))),
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
}
