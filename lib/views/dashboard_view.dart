import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/helpers/constants.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:generador_formato/models/cotizacion_diaria_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:generador_formato/services/comprobante_service.dart';
import 'package:generador_formato/services/cotizacion_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../database/database.dart';
import '../widgets/comprobante_item_row.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/text_styles.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key, required this.sideController});

  final SidebarXController sideController;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<QuoteData> cotizaciones = [];
  List<ReporteCotizacion> reportQuotes = [];
  List<CotizacionDiaria> todayQuotes = [];
  List<ReceiptQuoteData> ultimasCotizaciones = [];
  bool isLoading = false;
  late TooltipBehavior _tooltipBehavior;
  String dropdownValue = filtrosRegistro.first;

  @override
  void initState() {
    fetchData();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        duration: 1000,
        textStyle: TextStyles.styleStandar(color: Colors.white, size: 11));
    super.initState();
  }

  void fetchData() async {
    isLoading = true;
    setState(() {});
    List<QuoteData> resp = await CotizacionService().getCotizacionesTimePeriod(
        DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
    List<QuoteData> respToday =
        await CotizacionService().getCotizacionesActuales();
    List<ReceiptQuoteData> respLatest =
        await ComprobanteService().getComprobantesActuales();
    if (!mounted) return;
    setState(() {
      cotizaciones = resp;
      reportQuotes = Utility.getReportQuotes(cotizaciones);
      todayQuotes = Utility.getDailyQuotesReport(respToday);
      ultimasCotizaciones = respLatest;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.bell_solid,
                          color: DesktopColors.cerulean,
                          size: 26,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            widget.sideController.selectIndex(3);
                          },
                          icon: Icon(
                            Icons.settings,
                            color: DesktopColors.cerulean,
                            size: 26,
                          )),
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
                                      CustomWidgets.dropdownMenuCustom(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                              orientation: LegendItemOrientation
                                                  .horizontal,
                                              isResponsive: true,
                                              position: LegendPosition.bottom,
                                              textStyle:
                                                  TextStyles.styleStandar(
                                                      size: 11),
                                              overflowMode:
                                                  LegendItemOverflowMode.wrap),
                                          series: [
                                            StackedColumnSeries<
                                                ReporteCotizacion, String>(
                                              dataSource: reportQuotes,
                                              xValueMapper: (datum, _) =>
                                                  datum.dia,
                                              yValueMapper: (datum, _) =>
                                                  datum.numCotizacionesGrupales,
                                              name: "Cotizaciones grupales",
                                            ),
                                            StackedColumnSeries<
                                                ReporteCotizacion, String>(
                                              dataSource: reportQuotes,
                                              xValueMapper: (datum, index) =>
                                                  datum.dia,
                                              yValueMapper: (datum, index) =>
                                                  datum
                                                      .numCotizacionesIndividual,
                                              name: "Cotizaciones Individuales",
                                            ),
                                            SplineSeries<ReporteCotizacion,
                                                String>(
                                              splineType: SplineType.monotonic,
                                              dataSource: reportQuotes,
                                              xValueMapper: (datum, index) =>
                                                  datum.dia,
                                              yValueMapper: (datum, index) => datum
                                                  .numCotizacionesGrupalesPreventa,
                                              name:
                                                  "Cotizaciones grupales oferta",
                                            ),
                                            SplineSeries<ReporteCotizacion,
                                                String>(
                                              splineType: SplineType.monotonic,
                                              dataSource: reportQuotes,
                                              xValueMapper: (datum, index) =>
                                                  datum.dia,
                                              yValueMapper: (datum, index) => datum
                                                  .numCotizacionesIndividualPreventa,
                                              name:
                                                  "Cotizaciones individuales oferta",
                                            ),
                                          ],
                                          primaryXAxis: CategoryAxis(
                                            labelStyle: TextStyles.styleStandar(
                                                size: 12),
                                            axisLine: const AxisLine(width: 2),
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 500,
                          child: Card(
                            elevation: 5,
                            child: const SizedBox(),
                          ),
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
                            child: Card(
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SfCircularChart(
                                    tooltipBehavior: _tooltipBehavior,
                                    palette: [
                                      DesktopColors.cotGroupColor,
                                      DesktopColors.cotIndColor,
                                      DesktopColors.cotGroupPreColor,
                                      DesktopColors.cotIndPreColor
                                    ],
                                    legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          TextStyles.styleStandar(size: 11),
                                      overflowMode: LegendItemOverflowMode.wrap,
                                      position: LegendPosition.bottom,
                                    ),
                                    series: [
                                      DoughnutSeries<CotizacionDiaria, String>(
                                        dataSource: todayQuotes,
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
                                      )
                                    ],
                                  ),
                                ],
                              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(
                                      width: screenWidth,
                                      height: 330,
                                      child: ListView.builder(
                                        itemCount: ultimasCotizaciones.length,
                                        shrinkWrap: false,
                                        itemBuilder: (context, index) {
                                          return ComprobanteItemRow(
                                            key: UniqueKey(),
                                            comprobante:
                                                ultimasCotizaciones[index],
                                            index: index,
                                            screenWidth: screenWidth,
                                            isQuery: true,
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
