import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/dahsboard_provider.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:generador_formato/providers/notificacion_provider.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:generador_formato/widgets/notification_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tuple/tuple.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final notificaciones = ref.watch(NotificacionProvider.provider);
    final typePeriod = ref.watch(filterReport);
    final reportesSync = ref.watch(
        reporteCotizacionesIndProvider(const Tuple2<String, dynamic>('', '')));
    final cotizacionesDiariasSync = ref.watch(
        cotizacionesDiariasProvider(const Tuple2<String, dynamic>('', '')));
    final ultimasCotizacionesSync = ref.watch(
        ultimaCotizacionesProvider(const Tuple2<String, dynamic>('', '')));
    final allQuotesSync =
        ref.watch(allQuotesProvider(const Tuple2<String, dynamic>('', '')));

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
                                          color: Theme.of(context).primaryColor,
                                          size: 16),
                                      CustomDropdown.dropdownMenuCustom(
                                          fontSize: 12,
                                          initialSelection: typePeriod,
                                          onSelected: (String? value) {
                                            setState(() {
                                              ref
                                                  .read(filterReport.notifier)
                                                  .update((state) => value!);
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
                                                DesktopColors.cotGroupColor,
                                                DesktopColors.cotIndColor,
                                                // DesktopColors.cotGroupPreColor,
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
                                                    size: 11,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
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
                                                // SplineSeries<ReporteCotizacion,
                                                //     String>(
                                                //   splineType:
                                                //       SplineType.monotonic,
                                                //   dataSource: list,
                                                //   xValueMapper:
                                                //       (datum, index) =>
                                                //           datum.dia,
                                                //   yValueMapper:
                                                //       (datum, index) => datum
                                                //           .numCotizacionesGrupalesPreventa,
                                                //   name:
                                                //       "Cotizaciones grupales oferta",
                                                // ),
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
                                    return TextStyles.standardText(
                                      text: "No se han encontrado resultados",
                                      color: Theme.of(context).primaryColor,
                                    );
                                  },
                                  loading: () {
                                    return SizedBox(
                                      height: 450,
                                      child: ProgressIndicatorCustom(0),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ).animate().fadeIn(),
                      ),
                      SizedBox(
                        height: 524,
                        width: screenWidth > 1000 ? screenWidth * 0.2 : 200,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: allQuotesSync.when(
                              data: (list) {
                                List<Widget> cards = [];
                                for (var element in list) {
                                  cards.add(ItemRow.statusQuoteRow(element));
                                }

                                return Wrap(children: cards);
                              },
                              error: (error, stackTrace) {
                                return const SizedBox();
                              },
                              loading: () {
                                return ProgressIndicatorCustom(80);
                              },
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 500)),
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
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      cotizacionesDiariasSync.when(
                                        data: (list) {
                                          return SfCircularChart(
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
                                              DesktopColors.cotGroupColor,
                                              DesktopColors.cotIndColor,
                                              // DesktopColors.cotGroupPreColor,
                                              DesktopColors.cotIndPreColor
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
                                                              fontSize: 11)),
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
                                          return ProgressIndicatorCustom(350);
                                        },
                                      )
                                    ],
                                  ),
                                ).animate().fadeIn(
                                    delay: const Duration(milliseconds: 750)),
                                cotizacionesDiariasSync.when(
                                  data: (list) {
                                    if (!Utility.foundQuotes(list)) {
                                      return Center(
                                          child: TextStyles.standardText(
                                        text: "Sin resultados",
                                        size: 11,
                                        color: Theme.of(context).primaryColor,
                                      )).animate().fadeIn(
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
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                            return SizedBox(
                                              height: 280,
                                              child: CustomWidgets
                                                  .messageNotResult(
                                                      context: context),
                                            );
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
                                                    cotizacion: list[index],
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
                                          return SizedBox(
                                            height: 280,
                                            child:
                                                CustomWidgets.messageNotResult(
                                                    context: context),
                                          );
                                        },
                                        loading: () {
                                          return ProgressIndicatorCustom(320);
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
