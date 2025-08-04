import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../models/categoria_model.dart';
import '../../../models/list_helper_model.dart';
import '../../../models/tipo_habitacion_model.dart';
import '../../../res/helpers/colors_helpers.dart';
import '../../../res/helpers/general_helpers.dart';
import '../../../res/ui/buttons.dart';
import '../../../res/ui/message_error_scroll.dart';
import '../../../res/ui/progress_indicator.dart';
import '../../../res/ui/section_container.dart';
import '../../../res/ui/text_styles.dart';
import '../../../utils/widgets/custom_dropdown.dart';
import '../../../utils/widgets/filter_manager.dart';
import '../../../utils/widgets/form_widgets.dart';
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
    final tipoHabitacionList = ref.watch(tipoHabListProvider(null));
    final searchController = ref.watch(tipoHabSearchProvider);
    final tipoHabPagination = ref.watch(tipoHabPaginationProvider);
    final sideController = ref.watch(sidebarControllerProvider);
    final screen = MediaQuery.of(context).size;
    double realWidth = screen.width - (sideController.extended ? 130 : 0);

    Widget _sampleTable(List<TipoHabitacion> data, int totalItems) {
      return Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: PaginatedDataTable(
              rowsPerPage: tipoHabPagination.pageSize,
              columnSpacing: 15,
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
          Positioned(
            bottom: 10,
            child: Container(
              width: 1920.w,
              height: 40,
              color: Theme.of(context).cardColor,
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Row(
              spacing: 8,
              children: [
                AppText.simpleText(
                  text: GeneralHelpers.buildPaginationText(
                    totalItems: totalItems,
                    pageIndex: tipoHabPagination.pageIndex,
                    pageSize: tipoHabPagination.pageSize,
                    currentPageItemCount: data.length,
                  ),
                ),
                const SizedBox(width: 20),
                Buttons.iconButtonCard(
                  size: 30,
                  icon: Iconsax.arrow_square_left_outline,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    (tipoHabPagination.pageIndex > 1)
                        ? ref.watch(tipoHabPaginationProvider.notifier).update(
                              (state) => PaginatedList(
                                pageIndex: state.pageIndex - 1,
                                pageSize: state.pageSize,
                              ),
                            )
                        : null;
                  },
                ),
                Buttons.iconButtonCard(
                  size: 30,
                  icon: Iconsax.arrow_right_outline,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    (tipoHabPagination.pageIndex <
                            tipoHabPagination.totalPages(totalItems))
                        ? ref.watch(tipoHabPaginationProvider.notifier).update(
                              (state) => PaginatedList(
                                pageIndex: state.pageIndex + 1,
                                pageSize: state.pageSize,
                              ),
                            )
                        : null;
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: CustomDropdown.dropdownMenuCustom(
              initialSelection: tipoHabPagination.pageSize.toString(),
              onSelected: (String? value) {
                ref.watch(tipoHabPaginationProvider.notifier).update(
                  (state) {
                    return PaginatedList(
                      pageIndex: 1,
                      pageSize: int.tryParse(value ?? "5") ?? 5,
                    );
                  },
                );
                ref.invalidate(tipoHabListProvider(null));
              },
              elements: ["5", "10", "20", "50"],
              screenWidth: null,
              compact: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      );
    }

    return Column(
      spacing: 10,
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
        Column(
          children: [
            SectionContainer(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 700.w,
                      height: 34,
                      child: FormWidgets.textFormField(
                        name: "Buscar",
                        controller: searchController,
                        onFieldSubmitted: (p0) {
                          ref.read(tipoHabSearchProvider.notifier).update(
                              (state) => TextEditingController(text: p0));
                        },
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Iconsax.search_normal_1_outline,
                            size: 20,
                          ),
                          onPressed: () {
                            ref.read(tipoHabSearchProvider.notifier).update(
                                  (state) => TextEditingController(
                                    text: searchController.text.trim(),
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 34,
                      child: Row(
                        spacing: 3,
                        children: [
                          Buttons.floatingButton(
                            context,
                            iconSize: 22,
                            toolTip: "Filtros",
                            tag: "filter_type_room",
                            icon: Iconsax.filter_search_outline,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const FilterManager(
                                    route: "TIPO_HAB",
                                    showLayout: false,
                                  );
                                },
                              );
                            },
                          ),
                          Buttons.floatingButton(
                            context,
                            iconSize: 22,
                            toolTip: "Limpiar",
                            tag: "clean_type_room",
                            icon: Iconsax.rotate_left_outline,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
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
                        _sampleTable(data.item1, data.item2),
                        if (data.item1.isEmpty)
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
                                    color:
                                        Colors.black87.withValues(alpha: .25),
                                    blurRadius: 24,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                              child: MessageErrorScroll(
                                icon: data.item2 > 0
                                    ? Iconsax.box_search_outline
                                    : Iconsax.folder_open_outline,
                                title: data.item2 > 0
                                    ? 'Sin resultados'
                                    : 'No se encontraron tipos de habitaciones',
                                message: data.item2 > 0
                                    ? 'No se encontraron tipos de habitaciones que coincidan con la búsqueda.'
                                    : 'No hay tipos de habitaciones registradas en el sistema.',
                              ),
                            ),
                          )
                      ],
                    );
                  },
                  error: (error, _) => const MessageErrorScroll(),
                  loading: () {
                    return Stack(
                      children: [
                        _sampleTable([], 0),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: ProgressIndicatorCustom(screenHeight: 450),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
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
        _dataCell(row.codigo ?? 'unknown', width: 150.w),
        if (screenWidth > 750)
          _dataCell(
            '${row.orden}',
            width: 70.w,
          ),
        _dataCell('${row.descripcion}', width: 550.w),
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

    Widget _sampleTable(List<Categoria> data) {
      return SizedBox(
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
      );
    }

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
                    _sampleTable(data),
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
                return Stack(
                  children: [
                    _sampleTable([]),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: ProgressIndicatorCustom(screenHeight: 450),
                      ),
                    ),
                  ],
                );
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
        _dataCell(row.nombre ?? 'unknown', width: 280.w),
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
