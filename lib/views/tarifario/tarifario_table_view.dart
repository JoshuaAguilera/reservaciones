import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../providers/tarifario_provider.dart';
import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/dynamic_widget.dart';
import '../../widgets/item_row.dart';
import '../../widgets/text_styles.dart';

class TarifarioTableView extends ConsumerStatefulWidget {
  const TarifarioTableView({
    super.key,
    required this.sideController,
    required this.onEdit,
    required this.onDelete,
  });
  final SidebarXController sideController;
  final void Function(RegistroTarifa)? onEdit;
  final void Function(RegistroTarifa)? onDelete;

  @override
  _TarifarioTableState createState() => _TarifarioTableState();
}

class _TarifarioTableState extends ConsumerState<TarifarioTableView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final listTarifasProvider = ref.watch(listTarifaProvider(""));
    final tarifaProvider = ref.watch(allTarifaProvider(""));

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
              1: const FractionColumnWidth(0.1),
              2: const FractionColumnWidth(.18),
              3: (screenWidth > 1525)
                  ? const FractionColumnWidth(0.1)
                  : const FractionColumnWidth(.47),
              4: (screenWidth > 1525)
                  ? const FractionColumnWidth(.41)
                  : const FractionColumnWidth(.2),
              if (screenWidth > 1525) 5: const FractionColumnWidth(0.15),
            },
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Center(
                      child: TextStyles.standardText(
                          text: "#",
                          isBold: true,
                          color: Theme.of(context).primaryColor,
                          size: 14),
                    ),
                  ),
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
                  Center(
                    child: TextStyles.standardText(
                        text: "Opciones",
                        isBold: true,
                        color: Theme.of(context).primaryColor,
                        size: 14),
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
                      return Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Theme.of(context).primaryColorLight,
                            width: 2,
                          ),
                        ),
                        columnWidths: {
                          0: const FractionColumnWidth(0.05),
                          1: const FractionColumnWidth(0.1),
                          2: const FractionColumnWidth(.18),
                          3: (screenWidth > 1525)
                              ? const FractionColumnWidth(0.1)
                              : const FractionColumnWidth(.47),
                          4: (screenWidth > 1525)
                              ? const FractionColumnWidth(.41)
                              : const FractionColumnWidth(.2),
                          if (screenWidth > 1525)
                            5: const FractionColumnWidth(0.15),
                        },
                        children: [
                          for (var element in list)
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Center(
                                    child: TextStyles.standardText(
                                        text: element.id?.toString() ?? "",
                                        color: Theme.of(context).primaryColor,
                                        size: 14),
                                  ),
                                ),
                                Center(
                                  child: TextStyles.standardText(
                                      text: element.fechaRegistro!
                                          .toIso8601String()
                                          .substring(0, 10)
                                          .replaceAll('-', '/'),
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                ),
                                Center(
                                  child: TextStyles.standardText(
                                      text: element.nombre ?? '',
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                ),
                                if (screenWidth > 1525)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: TextStyles.standardText(
                                          text: Utility.defineStatusTariff(
                                              element.periodos),
                                          color: Theme.of(context).primaryColor,
                                          size: 14),
                                    ),
                                  ),
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: SizedBox(
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          for (var elementInt
                                              in element.periodos ?? [])
                                            ItemRow.filterItemRow(
                                              withDeleteButton: false,
                                              colorCard: element.color!,
                                              initDate:
                                                  elementInt.fechaInicial!,
                                              lastDate: elementInt.fechaFinal!,
                                              onRemove: () {
                                                element.periodos!
                                                    .remove(elementInt);
                                                setState(() {});
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (screenWidth > 1300)
                                        Expanded(
                                          child: Buttons.commonButton(
                                            onPressed: () =>
                                                widget.onEdit!.call(element),
                                            text: "Editar",
                                            color: DesktopColors.turquezaOscure,
                                          ),
                                        )
                                      else
                                        IconButton(
                                          onPressed: () =>
                                              widget.onEdit!.call(element),
                                          tooltip: "Editar",
                                          icon: Icon(
                                            CupertinoIcons.pencil,
                                            size: 30,
                                            color: DesktopColors.turquezaOscure,
                                          ),
                                        ),
                                      const SizedBox(width: 10),
                                      if (screenWidth > 1300)
                                        Expanded(
                                          child: Buttons.commonButton(
                                            onPressed: () =>
                                                widget.onDelete!.call(element),
                                            text: "Eliminar",
                                            color: DesktopColors.ceruleanOscure,
                                          ),
                                        )
                                      else
                                        IconButton(
                                          onPressed: () =>
                                              widget.onDelete!.call(element),
                                          tooltip: "Eliminar",
                                          icon: Icon(
                                            CupertinoIcons.delete,
                                            size: 30,
                                            color: DesktopColors.ceruleanOscure,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const SizedBox(),
                );
              }
              return SizedBox(
                  height: 150,
                  child: CustomWidgets.messageNotResult(
                      context: context,
                      sizeImage: 100,
                      screenWidth: screenWidth,
                      extended: widget.sideController.extended));
            },
            error: (error, stackTrace) => SizedBox(
                height: 150,
                child: CustomWidgets.messageNotResult(
                    context: context,
                    sizeImage: 100,
                    screenWidth: screenWidth,
                    extended: widget.sideController.extended)),
            loading: () => dynamicWidget.loadingWidget(
                screenWidth, screenHeight, widget.sideController.extended),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 750.ms);
  }
}
