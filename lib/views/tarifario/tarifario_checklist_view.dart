import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/utils/widgets/item_rows.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../models/registro_tarifa_model.dart';
import '../../providers/tarifario_provider.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/progress_indicator.dart';
import '../../utils/shared_preferences/settings.dart';
import '../../utils/widgets/dynamic_widget.dart';
import '../../res/ui/text_styles.dart';

class TarifarioChecklistView extends ConsumerStatefulWidget {
  const TarifarioChecklistView({
    super.key,
    required this.sideController,
    required this.onEdit,
    required this.onDelete,
  });

  final SidebarXController sideController;
  final void Function(RegistroTarifa)? onEdit;
  final void Function(RegistroTarifa)? onDelete;

  @override
  _TarifarioChecklistViewState createState() => _TarifarioChecklistViewState();
}

class _TarifarioChecklistViewState
    extends ConsumerState<TarifarioChecklistView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final listTarifasProvider = ref.watch(listTarifaProvider(""));
    final tarifaProvider = ref.watch(allTarifaProvider(""));
    final tarifasBase = ref.watch(tarifaBaseProvider(""));

    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tarifaProvider.when(
            data: (list) {
              if (list.isNotEmpty) {
                return listTarifasProvider.when(
                  data: (list) {
                    if (list.isNotEmpty) {
                      return tarifasBase.when(
                        data: (tarifasB) {
                          return SizedBox(
                            height: screenHeight - 160,
                            child: ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: false,
                              itemBuilder: (context, index) {
                                return ItemRows.tarifaCheckListItemRow(
                                  registro: list[index],
                                  tarifaBase: tarifasB
                                          .where((elementInt) =>
                                              elementInt.id ==
                                              list[index]
                                                  .tarifas!
                                                  .first
                                                  .tarifaPadreId)
                                          .firstOrNull
                                          ?.nombre ??
                                      '',
                                  screenWidth: screenWidth,
                                  onEdit: (register) =>
                                      widget.onEdit!.call(register),
                                  onDelete: (register) =>
                                      widget.onDelete!.call(register),
                                );
                              },
                            ),
                          );
                        },
                        error: (error, stackTrace) => const SizedBox(),
                        loading: () => ProgressIndicatorCustom(
                          screenHight: screenHeight,
                          typeLoading: "progressiveDots",
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
              return Center(
                child: SizedBox(
                  height: 150,
                  child: CustomWidgets.messageNotResult(
                    context: context,
                    sizeImage: 100,
                    screenWidth: screenWidth,
                    extended: widget.sideController.extended,
                  ),
                ),
              );
            },
            error: (error, stackTrace) => SizedBox(
              height: 150,
              child: CustomWidgets.messageNotResult(
                  context: context,
                  sizeImage: 100,
                  screenWidth: screenWidth,
                  extended: widget.sideController.extended),
            ),
            loading: () => dynamicWidget.loadingWidget(screenWidth * 2,
                screenHeight / 2, widget.sideController.extended,
                isEstandar: true),
          ),
        ],
      ),
    ).animate().fadeIn(
          duration: Settings.applyAnimations ? 750.ms : 0.ms,
        );
  }
}
