import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuple/tuple.dart';

import '../../../models/categoria_model.dart';
import '../../../models/tipo_habitacion_model.dart';
import '../../../res/helpers/colors_helpers.dart';
import '../../../res/ui/buttons.dart';
import '../../../res/ui/message_error_scroll.dart';
import '../../../res/ui/progress_indicator.dart';
import '../../../res/ui/text_styles.dart';
import '../../../utils/widgets/item_rows.dart';
import '../../../view-models/providers/categoria_provider.dart';
import '../../../view-models/providers/tipo_hab_provider.dart';
import '../../../view-models/providers/ui_provider.dart';
import 'config_tar_dialog.dart';

class TipoHabitacionList extends ConsumerWidget {
  const TipoHabitacionList({super.key});

  DataColumn _dataColumn(String text) {
    return DataColumn(
      label: AppText.listTitleText(text: text),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tipoHabitacionList =
        ref.watch(tipoHabListProvider(const Tuple3("", 1, 5)));
    final sideController = ref.watch(sidebarControllerProvider);
    final screen = MediaQuery.of(context).size;
    double realWidth = screen.width - (sideController.extended ? 130 : 0);

    return Column(
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
                    return const TipoHabDialog();
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
                        source: TiposHabitaciones(
                          data,
                          realWidth,
                          context,
                        ),
                      ),
                    ),
                    if (data.isEmpty)
                      Center(
                        heightFactor: 2.h,
                        child: Container(
                          width: 750.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87.withValues(alpha: .25),
                                blurRadius: 24,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: const MessageErrorScroll(
                            icon: Iconsax.folder_open_outline,
                            title: 'No se encontraron tipos de habitaciones',
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
    );
  }
}

class TiposHabitaciones extends DataTableSource {
  final List<TipoHabitacion> data;
  final double screenWidth;
  final BuildContext context;
  TiposHabitaciones(this.data, this.screenWidth, this.context);

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
          ? WidgetStateProperty.all(Theme.of(context).scaffoldBackgroundColor)
          : WidgetStateProperty.all(Theme.of(context).cardColor),
      cells: [
        _dataCell('${row.idInt ?? row.id ?? '?'}'),
        _dataCell(row.codigo ?? 'unknown'),
        if (screenWidth > 750) _dataCell('${row.orden}'),
        _dataCell('${row.descripcion}'),
        DataCell(
          ItemRow.compactOptions(
            onPreseedEdit: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TipoHabDialog(tipoHabitacion: row);
                },
              );
            },
            onPreseedDelete: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TipoHabDeleteDialog(tipoHabitacion: row);
                },
              );
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

class CategoriasList extends ConsumerWidget {
  const CategoriasList({super.key});

  DataColumn _dataColumn(String text) {
    return DataColumn(
      label: AppText.listTitleText(text: text),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriaList = ref.watch(categoriaListProvider(""));
    final sideController = ref.watch(sidebarControllerProvider);
    final screen = MediaQuery.of(context).size;
    double realWidth = screen.width - (sideController.extended ? 130 : 0);

    return Column(
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
                  AppText.sectionTitleText(text: "Categorias de Habitaciones"),
                  AppText.listBodyText(
                    text:
                        "Establece las categorias de habitaciones para configuración de tarifas.",
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
                    return const CategoriaDialog();
                  },
                );
              },
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Card(
            child: categoriaList.when(
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
                          _dataColumn("Nombre"),
                          if (realWidth > 800) _dataColumn("Color"),
                          _dataColumn("Descripción"),
                          _dataColumn("Opciones"),
                        ],
                        source: Categorias(
                          data,
                          realWidth,
                          context,
                        ),
                      ),
                    ),
                    if (data.isEmpty)
                      Center(
                        heightFactor: 2.h,
                        child: Container(
                          width: 750.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87.withValues(alpha: .25),
                                blurRadius: 24,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: const MessageErrorScroll(
                            icon: Iconsax.folder_open_outline,
                            title: 'No se encontraron tipos de habitaciones',
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
    );
  }
}

class Categorias extends DataTableSource {
  final List<Categoria> data;
  final double screenWidth;
  final BuildContext context;
  Categorias(this.data, this.screenWidth, this.context);

  DataCell _dataCell(String text, {double? width}) {
    return DataCell(
      SizedBox(
        width: width,
        child: AppText.simpleText(text: text, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow(
      color: (index % 2 == 0)
          ? WidgetStateProperty.all(Theme.of(context).scaffoldBackgroundColor)
          : WidgetStateProperty.all(Theme.of(context).cardColor),
      cells: [
        _dataCell('${row.idInt ?? row.id ?? '?'}'),
        _dataCell(row.nombre ?? 'unknown'),
        if (screenWidth > 800)
          DataCell(Container(
            width: 135.w,
            height: 25,
            decoration: BoxDecoration(
              color: row.color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: AppText.simpleText(
                text: HexColor.colorToHex(row.color) ?? "unknown",
                overflow: TextOverflow.ellipsis,
                color: ColorsHelpers.getForegroundColor(row.color),
              ),
            ),
          )),
        _dataCell('${row.descripcion}', width: 450.w),
        DataCell(
          ItemRow.compactOptions(
            onPreseedEdit: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CategoriaDialog(categoria: row);
                },
              );
            },
            onPreseedDelete: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CategoriaDeleteDialog(categoria: row);
                },
              );
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
