import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../providers/tarifario_provider.dart';
import '../../ui/buttons.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/dynamic_widget.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/item_row.dart';
import '../../widgets/text_styles.dart';

class TarifarioTableView extends ConsumerStatefulWidget {
  const TarifarioTableView({super.key, required this.sideController});
  final SidebarXController sideController;

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
              0: FractionColumnWidth(0.05),
              1: FractionColumnWidth(0.15),
              2: FractionColumnWidth(.18),
              3: (screenWidth > 1505)
                  ? FractionColumnWidth(0.12)
                  : FractionColumnWidth(.35),
              4: (screenWidth > 1505)
                  ? FractionColumnWidth(.35)
                  : FractionColumnWidth(.15),
              if (screenWidth > 1505) 5: FractionColumnWidth(0.15),
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
                    child: TextStyles.standardText(
                        text: "Fecha de registro",
                        isBold: true,
                        color: Theme.of(context).primaryColor,
                        size: 14),
                  ),
                  Center(
                    child: TextStyles.standardText(
                        text: "Nombre",
                        isBold: true,
                        color: Theme.of(context).primaryColor,
                        size: 14),
                  ),
                  if (screenWidth > 1505)
                    Center(
                      child: TextStyles.standardText(
                          text: "Color ident.",
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
                          0: FractionColumnWidth(0.05),
                          1: FractionColumnWidth(0.15),
                          2: FractionColumnWidth(.18),
                          3: (screenWidth > 1505)
                              ? FractionColumnWidth(0.12)
                              : FractionColumnWidth(.35),
                          4: (screenWidth > 1505)
                              ? FractionColumnWidth(.35)
                              : FractionColumnWidth(.15),
                          if (screenWidth > 1505) 5: FractionColumnWidth(0.15),
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
                                if (screenWidth > 1505)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: AbsorbPointer(
                                        absorbing: true,
                                        child: FormWidgets.inputColor(
                                          nameInput: "",
                                          primaryColor: element.color!,
                                          colorText:
                                              Theme.of(context).primaryColor,
                                          onChangedColor: (p0) {},
                                        ),
                                      ),
                                    ),
                                  ),
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: SizedBox(
                                      child: Wrap(
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
                                      if (screenWidth > 1400)
                                        Expanded(
                                          child: Buttons.commonButton(
                                            onPressed: () {},
                                            text: "Editar",
                                            color: DesktopColors.turquezaOscure,
                                          ),
                                        )
                                      else
                                        IconButton(
                                          onPressed: () {},
                                          tooltip: "Editar",
                                          icon: Icon(
                                            CupertinoIcons.pencil,
                                            size: 30,
                                            color: DesktopColors.turquezaOscure,
                                          ),
                                        ),
                                      const SizedBox(width: 10),
                                      if (screenWidth > 1400)
                                        Expanded(
                                          child: Buttons.commonButton(
                                            onPressed: () {},
                                            text: "Eliminar",
                                            color: Colors.red[900],
                                          ),
                                        )
                                      else
                                        IconButton(
                                          onPressed: () {},
                                          tooltip: "Eliminar",
                                          icon: Icon(
                                            CupertinoIcons.delete,
                                            size: 30,
                                            color: Colors.red[900],
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
    );
  }
}
