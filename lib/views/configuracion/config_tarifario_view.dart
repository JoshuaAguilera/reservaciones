import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/tipo_habitacion_model.dart';
import '../../res/helpers/animation_helpers.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/custom_dialog.dart';
import '../../res/ui/message_error_scroll.dart';
import '../../res/ui/progress_indicator.dart';
import '../../res/ui/section_container.dart';
import '../../res/ui/text_styles.dart';
import '../../utils/widgets/form_widgets.dart';
import '../../utils/widgets/item_rows.dart';
import '../../view-models/providers/tipo_hab_provider.dart';
import '../../view-models/providers/ui_provider.dart';

class ConfigTarifarioView extends ConsumerStatefulWidget {
  const ConfigTarifarioView({super.key});

  @override
  ConsumerState<ConfigTarifarioView> createState() =>
      _ConfigTarifarioViewState();
}

class _ConfigTarifarioViewState extends ConsumerState<ConfigTarifarioView> {
  DataColumn _dataColumn(String text) {
    return DataColumn(
      label: AppText.listTitleText(text: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tipoHabitacionList = ref.watch(tipoHabListProvider(""));
    final sideController = ref.watch(sidebarControllerProvider);
    final screen = MediaQuery.of(context).size;
    double realWidth = screen.width - (sideController.extended ? 130 : 0);

    return AnimatedEntry(
      child: SectionContainer(
        padH: 18,
        title: "Tarifario",
        subtitle:
            "Configura los tipos y categorias de habitaciones del Tarifario.",
        isModule: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        children: [
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.sectionTitleText(text: "Tipos de Habitaciones"),
                        AppText.listBodyText(
                          text:
                              "Establece los tipos de habitaciones para generacion de categoria para una tarifa.",
                        ),
                      ],
                    ),
                  ),
                  Buttons.buttonSecundary(
                    text: "Agregar",
                    icon: Iconsax.add_square_outline,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            withIcon: true,
                            icon: Iconsax.lamp_1_outline,
                            title: "Agregar Tipo de Habitación",
                            content: Wrap(
                              children: [
                                FormWidgets.textFormField(name: "Código"),
                                FormWidgets.textFormField(name: "Orden*"),
                                FormWidgets.textFormField(name: "Camas"),
                              ],
                            ),
                            withButtonSecondary: true,
                            nameButton2: "Cancelar",
                            funtion1: () {},
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: tipoHabitacionList.when(
                    data: (data) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: PaginatedDataTable(
                              rowsPerPage: 5,
                              columnSpacing: 35,
                              columns: <DataColumn>[
                                _dataColumn("ID"),
                                _dataColumn("Codigo"),
                                if (realWidth > 750) _dataColumn("Orden"),
                                _dataColumn("Descripción"),
                                _dataColumn("Opciones"),
                              ],
                              source: TiposHabitaciones(data, realWidth),
                            ),
                          ),
                          Center(
                            heightFactor: 2.h,
                            child: Container(
                              width: 750.w,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black87.withValues(
                                        alpha: .25), // color del "borde"
                                    blurRadius: 24, // qué tan difuso
                                    spreadRadius: 8, // tamaño del halo
                                  ),
                                ],
                              ),
                              child: const MessageErrorScroll(
                                icon: Iconsax.folder_open_outline,
                                title:
                                    'No se encontraron tipos de habitaciones',
                                message:
                                    'No hay tipos de habitaciones registradas en el sistema.',
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    error: (error, _) => const MessageErrorScroll(),
                    loading: () {
                      return ProgressIndicatorCustom(screenHight: 450);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TiposHabitaciones extends DataTableSource {
  final List<TipoHabitacion> data;
  final double screenWidth;
  TiposHabitaciones(this.data, this.screenWidth);

  DataCell _dataCell(String text) {
    return DataCell(
      AppText.simpleText(text: text, overflow: TextOverflow.ellipsis),
    );
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow(
      color: (index % 2 == 0)
          ? WidgetStateProperty.all(Colors.white)
          : WidgetStateProperty.all(Colors.grey.shade200),
      cells: [
        _dataCell('${row.idInt ?? row.id ?? '?'}'),
        _dataCell(row.codigo ?? 'unknown'),
        if (screenWidth > 750) _dataCell('${row.orden}'),
        _dataCell('${row.descripcion}'),
        DataCell(
          ItemRow.compactOptions(
            onPreseedEdit: () {
              // Action to edit the room type
            },
            onPreseedDelete: () {
              // Action to delete the room type
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;
}
