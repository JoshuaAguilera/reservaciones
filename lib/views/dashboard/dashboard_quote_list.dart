import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:tuple/tuple.dart';

import '../../models/cotizacion_model.dart';
import '../../models/filter_model.dart';
import '../../models/statistic_model.dart';
import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/graphics_elements.dart';
import '../../res/ui/message_error_scroll.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/ui/text_styles.dart';
import '../../utils/widgets/item_rows.dart';
import '../../view-models/providers/cotizacion_provider.dart';
import '../../view-models/providers/dashboard_provider.dart';
import '../../view-models/providers/ui_provider.dart';
import 'dashboard_quote_table.dart';

class DashboardQuoteList extends ConsumerStatefulWidget {
  const DashboardQuoteList({super.key});

  @override
  ConsumerState<DashboardQuoteList> createState() => _DashboardQuoteListState();
}

class _DashboardQuoteListState extends ConsumerState<DashboardQuoteList> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final keyList = ref.watch(keyQuoteListProvider);
    final filterList = ref.watch(filterQuoteDashProvider);
    final updateList = ref.watch(updateViewQuoteListProvider);
    final sideController = ref.watch(sidebarControllerProvider);
    final realWidth = sizeScreen.width - (sideController.extended ? 130 : 0);

    Widget textTitle(String text) =>
        AppText.styledText(text: text, fontWeight: FontWeight.bold);

    return AnimatedEntry(
      delay: const Duration(milliseconds: 650),
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: textTitle("Ultimas cotizaciones"),
                  ),
                  TextButton(
                    onPressed: () => navigateToRoute(ref, "/historial"),
                    child: AppText.styledText(
                      text: "Mostrar todos",
                      fontFamily: AppText.fontMedium,
                    ),
                  ),
                ],
              ),
              AnimatedEntry(
                delay: const Duration(milliseconds: 1050),
                child: SizedBox(
                  width: realWidth,
                  height: 310,
                  child: RiverPagedBuilder<int, Cotizacion>(
                    key: ValueKey(keyList + updateList),
                    firstPageKey: 1,
                    provider: cotizacionesProvider(""),
                    itemBuilder: (context, item, index) => CotizacionItem(
                      cotizacion: item,
                      inDashboard: true,
                    ),
                    pagedBuilder: (controller, builder) {
                      if (filterList.layout == Layout.mosaico) {
                        return PagedGridView<int, Cotizacion>(
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
                      }
                      if (filterList.layout == Layout.table) {
                        return const CotizacionesPaginatedTable();
                      } else {
                        return PagedListView(
                          pagingController: controller,
                          builderDelegate: builder,
                        );
                      }
                    },
                    firstPageErrorIndicatorBuilder: (_, __) {
                      return SizedBox(
                        height: 280,
                        child: CustomWidgets.messageNotResult(
                          delay: const Duration(milliseconds: 1250),
                        ),
                      );
                    },
                    limit: 20,
                    noMoreItemsIndicatorBuilder: (context, controller) {
                      return MessageErrorScroll.messageNotFound();
                    },
                    noItemsFoundIndicatorBuilder: (_, __) {
                      return const MessageErrorScroll(
                        icon: HeroIcons.folder_open,
                        title: 'No se encontraron cotizaciones',
                        message:
                            'No hay cotizaciones registradas en el sistema.',
                      );
                    },
                    newPageProgressIndicatorBuilder: (context, controller) {
                      return ProgressIndicatorCustom(screenHight: 310);
                    },
                    firstPageProgressIndicatorBuilder: (context, controller) {
                      return ProgressIndicatorCustom(screenHight: 310);
                    },
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

class CotizacionItem extends ConsumerWidget {
  final Cotizacion cotizacion;
  final bool inDashboard;

  const CotizacionItem({
    super.key,
    required this.cotizacion,
    this.inDashboard = false,
  });

  void onPressedEdit(WidgetRef ref) {
    navigateToRoute(
      ref,
      "/historial",
      subRoute: "/detalle",
      ids: Tuple2(cotizacion.id, cotizacion.idInt),
    );
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
        if (layout == Layout.checkList) itemList(selectItem, ref),
        if (layout == Layout.mosaico) itemContent(selectItem, ref),
      ],
    );
  }

  Widget itemContent(bool selectItem, WidgetRef ref) {
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
                onPreseedEdit: () => onPressedEdit(ref),
                onPreseedDelete:
                    inDashboard ? null : () => onPreseedDelete(context),
              ),
        metricsWidget: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tipo: ${cotizacion.esGrupo == true ? "Grupal" : "Individual"}",
            ),
            AppText.listBodyText(
              text: "Fecha: ${cotizacion.createdAt?.toString() ?? ''}",
              maxLines: 2,
            ),
          ],
        ),
      );
    });
  }

  Widget itemList(bool selectItem, WidgetRef ref) {
    return StatefulBuilder(
      builder: (context, snapshot) {
        String limiteDate =
            "Fecha Limite: ${DateHelpers.getStringDate(data: cotizacion.fechaLimite, compact: true)}";

        String createdDate =
            "Fecha: ${DateHelpers.getStringDate(data: cotizacion.createdAt, compact: true)}";

        return ItemRow.itemRowCheckList(
          context,
          showCheckBox: selectItem,
          hideTrailing: selectItem,
          valueCheckBox: cotizacion.select,
          onChangedCheckBox: (p0) {
            cotizacion.select = p0!;
            snapshot(() {});
          },
          icon: Iconsax.archive_book_outline,
          title: cotizacion.cliente?.fullName ?? '',
          description: "Folio: ${cotizacion.folio ?? 'unknown'}",
          details: "$createdDate     $limiteDate",
          color: ColorsHelpers.getColorQuote(cotizacion),
          radius: 12,
          onPressedEdit: () => onPressedEdit(ref),
          onPressedDelete: inDashboard ? null : () => onPreseedDelete(context),
        );
      },
    );
  }
}
