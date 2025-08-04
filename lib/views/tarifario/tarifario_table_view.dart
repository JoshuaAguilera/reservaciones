import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/utils/widgets/table_rows.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../models/tarifa_rack_model.dart';
import '../../view-models/providers/tarifario_provider.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/progress_indicator.dart';
import '../../utils/shared_preferences/settings.dart';
import '../../res/ui/text_styles.dart';

class TarifarioTableView extends ConsumerStatefulWidget {
  const TarifarioTableView({
    super.key,
    required this.sideController,
    required this.onEdit,
    required this.onDelete,
  });
  final SidebarXController sideController;
  final void Function(TarifaRack)? onEdit;
  final void Function(TarifaRack)? onDelete;

  @override
  _TarifarioTableState createState() => _TarifarioTableState();
}

class _TarifarioTableState extends ConsumerState<TarifarioTableView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final listTarifasProvider = ref.watch(listTarifaProvider(""));
    final tarifaProvider = ref.watch(listTarifaProvider(""));
    final tarifasBase = ref.watch(tarifaBaseProvider(""));

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              verticalInside: BorderSide(
                color: Theme.of(context).primaryColorLight,
                width: 2,
              ),
            ),
            columnWidths: {
              0: const FractionColumnWidth(0.05),
              1: screenWidth > 1050
                  ? const FractionColumnWidth(.1)
                  : const FractionColumnWidth(0.28),
              2: screenWidth > 1050
                  ? const FractionColumnWidth(.18)
                  : screenWidth > 950
                      ? const FractionColumnWidth(.3)
                      : const FractionColumnWidth(.47),
              3: (screenWidth > 1525)
                  ? const FractionColumnWidth(0.1)
                  : screenWidth > 1150
                      ? const FractionColumnWidth(.23)
                      : screenWidth > 1050
                          ? const FractionColumnWidth(.3)
                          : const FractionColumnWidth(.2),
              4: (screenWidth > 1525)
                  ? const FractionColumnWidth(.18)
                  : screenWidth > 1150
                      ? const FractionColumnWidth(.18)
                      : screenWidth > 1050
                          ? const FractionColumnWidth(.22)
                          : const FractionColumnWidth(.17),
              5: (screenWidth > 1525)
                  ? const FractionColumnWidth(.14)
                  : const FractionColumnWidth(.15),
              6: (screenWidth > 1525)
                  ? const FractionColumnWidth(0.12)
                  : const FractionColumnWidth(0.11),
              if (screenWidth > 1675) 7: const FractionColumnWidth(0.1),
            },
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Checkbox(
                        //   value: false,
                        //   onChanged: (value) {},
                        // ),
                        TextStyles.standardText(
                          text: "ID",
                          isBold: true,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  if (screenWidth > 1050)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextStyles.standardText(
                            text: "Fecha de registro",
                            isBold: true,
                            color: Theme.of(context).primaryColor,
                            size: 14),
                      ),
                    ),
                  Center(
                    child: TextStyles.standardText(
                        text: "Nombre",
                        isBold: true,
                        color: Theme.of(context).primaryColor,
                        size: 14),
                  ),
                  if (screenWidth > 1525)
                    Center(
                      child: TextStyles.standardText(
                          text: "Estatus",
                          isBold: true,
                          color: Theme.of(context).primaryColor,
                          size: 14),
                    ),
                  Center(
                    child: TextStyles.standardText(
                        text: "Periodos",
                        isBold: true,
                        color: Theme.of(context).primaryColor,
                        size: 14),
                  ),
                  if (screenWidth > 1150)
                    Center(
                      child: TextStyles.standardText(
                          text: "Temporadas",
                          isBold: true,
                          color: Theme.of(context).primaryColor,
                          size: 14),
                    ),
                  if (screenWidth > 950)
                    Center(
                      child: TextStyles.standardText(
                          text: "Tarifa Base",
                          isBold: true,
                          color: Theme.of(context).primaryColor,
                          size: 14),
                    ),
                  Center(
                    child: TextStyles.standardText(
                      text: "Opciones",
                      isBold: true,
                      color: Theme.of(context).primaryColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: Theme.of(context).primaryColorLight),
          tarifaProvider.when(
            data: (list) {
              if (list.isNotEmpty) {
                return listTarifasProvider.when(
                  data: (list) {
                    if (list.isNotEmpty) {
                      return tarifasBase.when(
                        data: (data) {
                          return Column(
                            children: [
                              for (var element in list)
                                Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  elevation: 3,
                                  child: Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      0: const FractionColumnWidth(0.05),
                                      1: screenWidth > 1050
                                          ? const FractionColumnWidth(.1)
                                          : const FractionColumnWidth(0.28),
                                      2: screenWidth > 1050
                                          ? const FractionColumnWidth(.18)
                                          : screenWidth > 950
                                              ? const FractionColumnWidth(.3)
                                              : const FractionColumnWidth(.47),
                                      3: (screenWidth > 1525)
                                          ? const FractionColumnWidth(0.1)
                                          : screenWidth > 1150
                                              ? const FractionColumnWidth(.23)
                                              : screenWidth > 1050
                                                  ? const FractionColumnWidth(
                                                      .3)
                                                  : const FractionColumnWidth(
                                                      .2),
                                      4: (screenWidth > 1525)
                                          ? const FractionColumnWidth(.18)
                                          : screenWidth > 1150
                                              ? const FractionColumnWidth(.18)
                                              : screenWidth > 1050
                                                  ? const FractionColumnWidth(
                                                      .22)
                                                  : const FractionColumnWidth(
                                                      .17),
                                      5: (screenWidth > 1525)
                                          ? const FractionColumnWidth(.14)
                                          : const FractionColumnWidth(.15),
                                      6: (screenWidth > 1525)
                                          ? const FractionColumnWidth(0.12)
                                          : const FractionColumnWidth(0.11),
                                      if (screenWidth > 1675)
                                        7: const FractionColumnWidth(0.1),
                                    },
                                    children: [
                                      TableRows.tableRowTarifario(
                                        element: element,
                                        context: context,
                                        screenWidth: screenWidth,
                                        onEdit: (p0) =>
                                            widget.onEdit!.call(element),
                                        onDelete: (p0) =>
                                            widget.onDelete!.call(element),
                                        tarifasBase: data,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                        error: (error, stackTrace) => const SizedBox(),
                        loading: () => ProgressIndicatorCustom(
                          screenHeight: screenHeight,
                          type: IndicatorType.progressiveDots,
                          message: TextStyles.standardText(
                            text: "Cargando Tarifas Base",
                            align: TextAlign.center,
                            size: 11,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const SizedBox(),
                );
              }
              return SizedBox(
                  height: 200,
                  child: CustomWidgets.messageNotResult(
                    sizeImage: 120,
                    screenWidth: screenWidth,
                    extended: widget.sideController.extended,
                    sizeMessage: 12,
                  ));
            },
            error: (error, stackTrace) => SizedBox(
                height: 150,
                child: CustomWidgets.messageNotResult(
                    sizeImage: 100,
                    screenWidth: screenWidth,
                    extended: widget.sideController.extended)),
            loading: () => ProgressIndicatorCustom(
              screenHeight: screenHeight,
              type: IndicatorType.progressiveDots,
              message: TextStyles.standardText(
                text: "Buscando Tarifario",
                align: TextAlign.center,
                size: 11,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
          duration: Settings.applyAnimations ? 750.ms : 0.ms,
        );
  }
}
