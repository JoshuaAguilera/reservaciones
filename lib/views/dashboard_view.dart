import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:generador_formato/models/cotizacion_diarias_model.dart';
import 'package:generador_formato/services/cotizacion_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../database/database.dart';
import '../widgets/text_styles.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<QuoteData> cotizaciones = [];
  List<CotizacionDiaria> stadistics = [];
  bool isLoading = false;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    fetchData();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        duration: 2000,
        textStyle: TextStyles.styleStandar(color: Colors.white, size: 11));
    super.initState();
  }

  void fetchData() async {
    isLoading = true;
    setState(() {});
    List<QuoteData> resp = await CotizacionService().getCotizacionesTimePeriod(
        DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
    if (!mounted) return;
    setState(() {
      cotizaciones = resp;
      stadistics = Utility.getStatics(cotizaciones);
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
                          color: WebColors.cerulean,
                          size: 26,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings,
                            color: WebColors.cerulean,
                            size: 26,
                          )),
                    ],
                  )
                ],
              ),
              const Divider(color: Colors.black54),
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
                                    children: [
                                      TextStyles.titleText(
                                          text: "Reporte de cotizaciones",
                                          size: 16)
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: TextStyles.standardText(text: "Cotizaciones", size: 12),
                                      ),
                                    ),
                                    Expanded(
                                      child: SfCartesianChart(
                                        plotAreaBorderWidth: 0,
                                        tooltipBehavior: _tooltipBehavior,
                                        palette: [
                                          WebColors.prussianBlue,
                                          WebColors.cerulean,
                                          WebColors.canvasColor,
                                          WebColors.primaryColor
                                        ],
                                        legend: Legend(
                                          isVisible: true,
                                          orientation:
                                              LegendItemOrientation.horizontal,
                                          isResponsive: true,
                                          position: LegendPosition.bottom,
                                          textStyle:
                                              TextStyles.styleStandar(size: 11),
                                        ),
                                        series: [
                                          StackedColumnSeries<CotizacionDiaria,
                                              String>(
                                            dataSource: stadistics,
                                            xValueMapper: (datum, _) =>
                                                datum.dia,
                                            yValueMapper: (datum, _) =>
                                                datum.numCotizacionesGrupales,
                                            name: "Cotizaciones grupales",
                                          ),
                                          StackedColumnSeries<CotizacionDiaria,
                                              String>(
                                            dataSource: stadistics,
                                            xValueMapper: (datum, index) =>
                                                datum.dia,
                                            yValueMapper: (datum, index) =>
                                                datum.numCotizacionesIndividual,
                                            name: "Cotizaciones Individuales",
                                          ),
                                          SplineSeries<CotizacionDiaria,
                                              String>(
                                            splineType: SplineType.monotonic,
                                            dataSource: stadistics,
                                            xValueMapper: (datum, index) =>
                                                datum.dia,
                                            yValueMapper: (datum, index) => datum
                                                .numCotizacionesGrupalesPreventa,
                                            name:
                                                "Cotizaciones grupales oferta",
                                          ),
                                          SplineSeries<CotizacionDiaria,
                                              String>(
                                            splineType: SplineType.monotonic,
                                            dataSource: stadistics,
                                            xValueMapper: (datum, index) =>
                                                datum.dia,
                                            yValueMapper: (datum, index) => datum
                                                .numCotizacionesIndividualPreventa,
                                            name:
                                                "Cotizaciones individuales oferta",
                                          ),
                                        ],
                                        primaryXAxis: CategoryAxis(
                                          labelStyle:
                                              TextStyles.styleStandar(size: 12),
                                          axisLine: const AxisLine(width: 2),
                                          majorGridLines:
                                              const MajorGridLines(width: 0),
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
                          height: 340,
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
                Center(
                  child: Row(
                    children: [],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
