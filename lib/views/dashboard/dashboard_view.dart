import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/cotizacion_model.dart';
import '../../models/estadistica_model.dart';
import '../../models/filter_model.dart';
import '../../models/statistic_model.dart';
import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/utility.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/graphics_elements.dart';
import '../../res/ui/message_error_scroll.dart';
import '../../res/ui/page_base.dart';
import '../../res/ui/progress_indicator.dart';
import '../../utils/widgets/form_widgets.dart';
import '../../utils/widgets/item_rows.dart';
import '../../utils/widgets/notification_widget.dart';
import '../../utils/widgets/select_buttons_widget.dart';
import '../../view-models/providers/cotizacion_provider.dart';
import '../../view-models/providers/dashboard_provider.dart';
import '../../view-models/providers/notificacion_provider.dart';
import '../../view-models/providers/ui_provider.dart';
import '../../view-models/providers/usuario_provider.dart';
import '../../utils/widgets/cotizacion_item_row.dart';
import '../../res/ui/text_styles.dart';
import 'dashboard_quote_graphic.dart';

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
    final brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final sizeScreen = MediaQuery.of(context).size;
    final notificaciones = ref.watch(NotificacionProvider.provider);
    final cotizacionesDiariasSync = ref.watch(cotizacionesDiariasProvider(''));
    final keyList = ref.watch(keyQuoteListProvider);
    final updateList = ref.watch(updateViewQuoteListProvider);
    final countQuotes = ref.watch(statisticsQuoteProvider(statistics));
    final usuario = ref.watch(userProvider);
    final filtro = ref.watch(filtroDashboardProvider);
    final filterList = ref.watch(filterQuoteDashProvider);
    final viewNotification = ref.watch(userViewProvider);
    final sideController = ref.watch(sidebarControllerProvider);
    final realWidth = sizeScreen.width - (sideController.extended ? 130 : 0);

    double sizeTitles = realWidth > 1050
        ? 16
        : realWidth > 750
            ? 15
            : 13;

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
        sizeScreen.width > (1290 - (sideController.extended ? 0 : 115));

    Widget textTitle(String text) {
      return TextStyles.standardText(
        isBold: true,
        text: text,
        size: sizeTitles,
      );
    }

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
                          TextStyles.titlePagText(text: "Dashboard"),
                          TextStyles.standardText(
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
                          onPressed: () {},
                        ),
                        Buttons.buttonSecundary(
                          text: "Crear tarifa",
                          icon: Iconsax.wallet_add_1_outline,
                          foregroundColor: DesktopColors.primary1,
                          onPressed: () {
                            navigateToRoute(ref, "/tarifario");
                          },
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
                          child: textTitle(filtro == "Individual"
                              ? "Tus Cotizaciones"
                              : "Cotizaciones del equipo"),
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
                const SizedBox(
                  height: 550,
                  child: DashboardQuoteGraphic(),
                ),
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
                                              tooltipBehavior:
                                                  !Utility.foundQuotes(list)
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
                                              ],
                                              legend: Legend(
                                                isVisible:
                                                    Utility.foundQuotes(list),
                                                textStyle:
                                                    TextStyles.styleStandar(
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
                                            child: TextStyles.standardText(
                                              text: "Sin nuevas\nCotizaciones",
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: textTitle(!(usuario
                                                            ?.rol?.nombre !=
                                                        "SUPERADMIN" &&
                                                    usuario?.rol?.nombre !=
                                                        "ADMIN")
                                                ? "Ultimas cotizaciones del equipo"
                                                : "Ultimas cotizaciones"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              sideController.selectIndex(2);
                                            },
                                            child: TextStyles.buttonText(
                                              text: "Mostrar todos",
                                              size: 12,
                                              color: brightness ==
                                                      Brightness.light
                                                  ? DesktopColors.cerulean
                                                  : DesktopColors.azulUltClaro,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedEntry(
                                      delay: const Duration(milliseconds: 1250),
                                      child: SizedBox(
                                        width: realWidth,
                                        height: 310,
                                        child:
                                            RiverPagedBuilder<int, Cotizacion>(
                                          key: ValueKey(keyList + updateList),
                                          firstPageKey: 1,
                                          provider: cotizacionesProvider(""),
                                          itemBuilder: (context, item, index) =>
                                              CotizacionItem(cotizacion: item),
                                          pagedBuilder: (controller, builder) {
                                            if (filterList.layout ==
                                                Layout.mosaico) {
                                              return PagedGridView<int,
                                                  Cotizacion>(
                                                pagingController: controller,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 4,
                                                  crossAxisSpacing: 4,
                                                  childAspectRatio: 1.5,
                                                ),
                                                builderDelegate: builder,
                                              );
                                              // } else if (filterList.layout ==
                                              //     Layout.table) {
                                              //   return Card(
                                              //     child: Padding(
                                              //       padding:
                                              //           const EdgeInsets.all(
                                              //               14.0),
                                              //       child: Column(
                                              //         children: [
                                              //           Padding(
                                              //             padding:
                                              //                 const EdgeInsets
                                              //                     .all(8.0),
                                              //             child: Table(
                                              //               columnWidths:
                                              //                   showSelectFunction
                                              //                       ? {
                                              //                           0: FractionColumnWidth(
                                              //                               0.12),
                                              //                           1: FractionColumnWidth(
                                              //                               0.3),
                                              //                           2: FractionColumnWidth(
                                              //                               0.43),
                                              //                           3: FractionColumnWidth(
                                              //                               0.15),
                                              //                         }
                                              //                       : {
                                              //                           0: FractionColumnWidth(
                                              //                               0.3),
                                              //                           1: FractionColumnWidth(
                                              //                               0.45),
                                              //                           2: FractionColumnWidth(
                                              //                               0.15),
                                              //                           3: FractionColumnWidth(
                                              //                               0.1),
                                              //                         },
                                              //               children: [
                                              //                 TableRow(
                                              //                   children: [
                                              //                     if (showSelectFunction)
                                              //                       SizedBox(),
                                              //                     _textW(
                                              //                         "Nombre",
                                              //                         size:
                                              //                             14,
                                              //                         isBold:
                                              //                             true),
                                              //                     _textW(
                                              //                         "Descripcion",
                                              //                         size:
                                              //                             14,
                                              //                         isBold:
                                              //                             true),
                                              //                     _textW(
                                              //                         "Perm.",
                                              //                         size:
                                              //                             14,
                                              //                         isBold:
                                              //                             true),
                                              //                     if (!showSelectFunction)
                                              //                       SizedBox(),
                                              //                   ],
                                              //                 )
                                              //               ],
                                              //             ),
                                              //           ),
                                              //           Expanded(
                                              //             child:
                                              //                 PagedListView(
                                              //               pagingController:
                                              //                   controller,
                                              //               builderDelegate:
                                              //                   builder,
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   );
                                            } else {
                                              return PagedListView(
                                                pagingController: controller,
                                                builderDelegate: builder,
                                              );
                                            }
                                          },
                                          firstPageErrorIndicatorBuilder:
                                              (_, __) {
                                            return SizedBox(
                                              height: 280,
                                              child: CustomWidgets
                                                  .messageNotResult(
                                                delay: const Duration(
                                                    milliseconds: 1250),
                                              ),
                                            );
                                          },
                                          limit: 20,
                                          noMoreItemsIndicatorBuilder:
                                              (context, controller) {
                                            return MessageErrorScroll
                                                .messageNotFound();
                                          },
                                          noItemsFoundIndicatorBuilder:
                                              (_, __) {
                                            return const MessageErrorScroll(
                                              icon: HeroIcons.folder_open,
                                              title:
                                                  'No se encontraron cotizaciones',
                                              message:
                                                  'No hay cotizaciones registradas en el sistema.',
                                            );
                                          },
                                        ),
                                      ),
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

class CotizacionItem extends ConsumerWidget {
  final Cotizacion cotizacion;
  final bool inDashboard;

  const CotizacionItem({
    super.key,
    required this.cotizacion,
    this.inDashboard = false,
  });

  void onPressedEdit(BuildContext context) {
    // pushScreen(
    //   context,
    //   screen: RolForm(role: cotizacion),
    //   withNavBar: true,
    //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
    // );
  }

  void onPreseedDelete(BuildContext context) {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return RolDeleteDialog(rol: cotizacion);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeViewDashboard = ref.watch(filterQuoteDashProvider);
    final typeView = ref.watch(filterQuoteProvider);
    final selectItem = ref.watch(selectQuoteProvider);
    final layout = inDashboard ? typeViewDashboard.layout : typeView.layout;

    return Stack(
      children: [
        if (layout == Layout.checkList) itemList(selectItem),
        if (layout == Layout.mosaico) itemContent(selectItem),
        // if (layout == Layout.table) itemRow(selectItem),
      ],
    );
  }

  // Widget itemRow(bool selectItem) {
  //   return StatefulBuilder(
  //     builder: (context, snapshot) {
  //       return ItemRow.basicRowList(
  //         showTrailing: false,
  //         showleanding: false,
  //         leftPadding: 0,
  //         padHor: 5,
  //         margin: 2,
  //         titleWidget: Table(
  //           columnWidths: selectItem
  //               ? {
  //                   0: FractionColumnWidth(0.12),
  //                   1: FractionColumnWidth(0.3),
  //                   2: FractionColumnWidth(0.43),
  //                   3: FractionColumnWidth(0.15),
  //                 }
  //               : {
  //                   0: FractionColumnWidth(0.3),
  //                   1: FractionColumnWidth(0.45),
  //                   2: FractionColumnWidth(0.15),
  //                   3: FractionColumnWidth(0.1),
  //                 },
  //           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  //           children: [
  //             TableRow(
  //               children: [
  //                 if (selectItem)
  //                   Checkbox(
  //                     value: cotizacion.select,
  //                     activeColor: AppColors.linkPrimary,
  //                     onChanged: (p0) {
  //                       cotizacion.select = p0!;
  //                       snapshot(() {});
  //                     },
  //                   ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 5),
  //                   child: _textW(
  //                     cotizacion.nombre ?? '',
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ),
  //                 _textW(cotizacion.descripcion ?? '', maxLines: 2),
  //                 _textW((cotizacion.permisos?.length ?? 0).toString()),
  //                 if (!selectItem)
  //                   SizedBox(
  //                     height: 20,
  //                     child: ItemRow.compactOptions(
  //                       diseablePad: true,
  //                       onPreseedEdit: () => onPressedEdit(context),
  //                       onPreseedDelete: () => onPreseedDelete(context),
  //                     ),
  //                   ),
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget itemContent(bool selectItem) {
    return StatefulBuilder(builder: (context, snapshot) {
      return GraphicsElements.containerElement(
        context,
        sizeTitle: 14,
        statistic: Statistic(
          title: cotizacion.cliente?.nombres ?? '',
          icon: Iconsax.security_outline,
          metrics: "23",
          color: ColorsHelpers.darken(DesktopColors.primary2, -0.08),
        ),
        amountColorMetrics: -0.05,
        trailingWidget: selectItem
            ? Checkbox(
                value: cotizacion.select,
                activeColor: DesktopColors.buttonPrimary,
                onChanged: (p0) {
                  cotizacion.select = p0!;
                  snapshot(() {});
                },
              )
            : ItemRow.compactOptions(
                onPreseedEdit: () => onPressedEdit(context),
                onPreseedDelete: () => onPreseedDelete(context),
              ),
        metricsWidget: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tipo: ${cotizacion.esGrupo == true ? "Grupal" : "Individual"}",
            ),
            TextStyles.standardText(
                text: "Fecha: ${cotizacion.createdAt?.toString() ?? ''}",
                size: 11,
                maxLines: 2),
          ],
        ),
      );
    });
  }

  Widget itemList(bool selectItem) {
    return StatefulBuilder(
      builder: (context, snapshot) {
        final realWidth = MediaQuery.of(context).size.width;
        // - (widget.sideController.extended ? 130 : 0);

        return ComprobanteItemRow(
          key: UniqueKey(),
          cotizacion: cotizacion,
          index: cotizacion.idInt ?? 0,
          screenWidth: realWidth,
          isQuery: true,
        );
        // return ItemRow.itemRowCheckList(
        //   context,
        //   showCheckBox: selectItem,
        //   hideTrailing: selectItem,
        //   valueCheckBox: cotizacion.select,
        //   onChangedCheckBox: (p0) {
        //     cotizacion.select = p0!;
        //     snapshot(() {});
        //   },
        //   icon: Iconsax.security_outline,
        //   title: cotizacion.nombre ?? '',
        //   description: "Permisos: ${(cotizacion.permisos ?? []).length}",
        //   details: "Descripción: ${cotizacion.descripcion ?? ''}",
        //   color: ColorsHelpers.darken(AppColors.section2Primary, -0.08),
        //   radius: 12,
        //   onPressedEdit: () => onPressedEdit(context),
        //   onPressedDelete: () => onPreseedDelete(context),
        // );
      },
    );
  }
}
