import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/estadistica_model.dart';
import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/utility.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/page_base.dart';
import '../../res/ui/progress_indicator.dart';
import '../../utils/widgets/form_widgets.dart';
import '../../utils/widgets/item_rows.dart';
import '../../utils/widgets/notification_widget.dart';
import '../../utils/widgets/select_buttons_widget.dart';
import '../../view-models/providers/dashboard_provider.dart';
import '../../view-models/providers/notificacion_provider.dart';
import '../../view-models/providers/ui_provider.dart';
import '../../res/ui/text_styles.dart';
import 'dashboard_quote_graphic.dart';
import 'dashboard_quote_list.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final GlobalKey<TooltipState> messageKey = GlobalKey<TooltipState>();
  bool starflow = false;
  Widget? statisticsWidget;
  List<Estadistica> statistics = [];

  @override
  void initState() {
    statistics = Utility.getDailyQuotesReport(respIndToday: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final notificaciones = ref.watch(NotificacionProvider.provider);
    final cotizacionesDiariasSync = ref.watch(cotizacionesDiariasProvider(''));
    final countQuotes = ref.watch(statisticsQuoteProvider(statistics));
    final filtro = ref.watch(filtroDashboardProvider);
    final viewNotification = ref.watch(userViewProvider);
    final sideController = ref.watch(sidebarControllerProvider);
    final realWidth = sizeScreen.width - (sideController.extended ? 130 : 0);

    Widget textTitle(String text) => AppText.sectionTitleText(text: text);

    Widget _countQuotes(bool isCompact) {
      return AnimatedEntry(
        child: countQuotes.when(
          data: (list) {
            return ItemRow.statisticsRow(list);
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
        sizeScreen.width > (1290 - (sideController.extended ? 0 : 115));

    return PageBase(
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
                        toolTip: "Configuración",
                        tag: "settings",
                        icon: Iconsax.setting_2_outline,
                        onPressed: () {
                          navigateToRoute(ref, "/configuracion");
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                          AppText.cardTitleText(text: "Dashboard"),
                          AppText.simpleText(
                            text:
                                "Planifica, prioriza y realiza tus tareas con facilidad.",
                          ),
                        ],
                      ),
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Buttons.buttonPrimary(
                          text: "Crear cotización",
                          icon: Iconsax.card_add_outline,
                          backgroundColor: DesktopColors.primary1,
                          onPressed: () =>
                              navigateToRoute(ref, "/generar_cotizacion"),
                        ),
                        Buttons.buttonSecundary(
                          text: "Crear tarifa",
                          icon: Iconsax.wallet_add_1_outline,
                          foregroundColor: DesktopColors.primary1,
                          onPressed: () => navigateToRoute(ref, "/tarifario"),
                        ),
                      ],
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
                          child: textTitle(
                            filtro == "Individual"
                                ? "Tus Cotizaciones"
                                : "Cotizaciones del equipo",
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: SelectButtonsWidget(
                            selectButton: filtro,
                            buttons: [
                              {"Individual": DesktopColors.primary3},
                              {"Equipo": DesktopColors.primary5},
                            ],
                            onPressed: (p0) {
                              ref.read(filtroDashboardProvider.notifier).update(
                                  (state) => p0 == 0 ? "Individual" : "Equipo");
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
                const SizedBox(height: 550, child: DashboardQuoteGraphic()),
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
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: textTitle(
                                            "Cotizaciones de hoy",
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
                                                          AppText.simpleStyle(
                                                        size: 11,
                                                      ),
                                                    ),
                                              palette: [
                                                (Utility.foundQuotes(list))
                                                    ? DesktopColors.cotGrupal
                                                    : DesktopColors.azulClaro,
                                                DesktopColors.cotIndiv,
                                                DesktopColors.resGrupal,
                                                DesktopColors.resIndiv,
                                              ],
                                              legend: Legend(
                                                isVisible:
                                                    Utility.foundQuotes(list),
                                                textStyle: AppText.simpleStyle(
                                                  size: 11,
                                                ),
                                                overflowMode:
                                                    LegendItemOverflowMode.wrap,
                                                position: LegendPosition.bottom,
                                              ),
                                              series: [
                                                if (Utility.foundQuotes(list))
                                                  DoughnutSeries<Estadistica,
                                                      String>(
                                                    dataSource: list,
                                                    xValueMapper:
                                                        (datum, index) =>
                                                            datum.title,
                                                    yValueMapper:
                                                        (datum, index) =>
                                                            datum.numNow,
                                                    enableTooltip: true,
                                                    dataLabelSettings:
                                                        DataLabelSettings(
                                                      isVisible: true,
                                                      showZeroValue: false,
                                                      textStyle:
                                                          AppText.simpleStyle(
                                                        size: 11,
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  DoughnutSeries<Estadistica,
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
                                                    yValueMapper:
                                                        (datum, index) =>
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
                                              const EdgeInsets.only(top: 10),
                                          child: AnimatedEntry(
                                            delay: const Duration(
                                                milliseconds: 350),
                                            child: AppText.styledText(
                                              text: "Sin nuevas\nCotizaciones",
                                              align: TextAlign.center,
                                              size: 10,
                                              maxSize: 11,
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
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: realWidth < 1090 ? 32 : 20,
                                          ),
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
                                                compact: realWidth < 1090,
                                              ),
                                              itemTodayData(
                                                "Cotizaciones individuales",
                                                DesktopColors.cotIndiv,
                                                compact: realWidth < 1090,
                                              ),
                                              itemTodayData(
                                                "Reservaciones individuales",
                                                DesktopColors.resIndiv,
                                                compact: realWidth < 1090,
                                              ),
                                              itemTodayData(
                                                "Reservaciones grupales",
                                                DesktopColors.resGrupal,
                                                compact: realWidth < 1090,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                  error: (error, stackTrace) => Container(),
                                  loading: () => const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(flex: 3, child: DashboardQuoteList()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
              child: AppText.styledText(
                text: name,
                size: 10,
                maxSize: 11,
              ),
            ),
        ],
      ),
    );
  }
}
