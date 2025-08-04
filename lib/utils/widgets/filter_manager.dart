import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuple/tuple.dart';

import '../../models/list_helper_model.dart';
import '../../models/tipo_habitacion_model.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/custom_dialog.dart';
import '../../res/ui/section_content.dart';
import '../../res/ui/text_styles.dart';
import '../../res/ui/tools_ui.dart';
import '../../view-models/providers/tipo_hab_provider.dart';

class FilterManager extends ConsumerStatefulWidget {
  const FilterManager({
    super.key,
    required this.route,
    this.showLayout = true,
    this.showTags = false,
    this.showTypes = false,
  });

  final String route;
  final bool showLayout;
  final bool showTags;
  final bool showTypes;

  @override
  _FilterModal createState() => _FilterModal();
}

class _FilterModal extends ConsumerState<FilterManager> {
  List<TipoHabitacion> types = [];
  bool startflow = false;
  Map<IconData, bool> layouts = {
    Iconsax.row_vertical_outline: true,
    Iconsax.element_4_outline: false,
    Iconsax.grid_1_outline: false,
  };
  Map<String, bool> sorts = {
    "Alfabeticamente": true,
    "Mas recientes": false,
    "Mas antiguo": false,
  };
  Map<String, Tuple4<bool, Color, IconData, String>> tags = {
    "Todas": Tuple4(
      true,
      DesktopColors.primary2,
      Iconsax.category_outline,
      "",
    ),
    "No leidas": Tuple4(
      false,
      DesktopColors.primary1,
      Iconsax.notification_1_outline,
      "NOTIFICATIONS",
    ),
    "Leidas": Tuple4(
      false,
      DesktopColors.primary3,
      Iconsax.eye_outline,
      "NOTIFICATIONS",
    ),
    "Activas": Tuple4(
      false,
      DesktopColors.primary4,
      Iconsax.record_circle_outline,
      "NOTIFICATION_RULES",
    ),
    "Desactivadas": Tuple4(
      false,
      DesktopColors.primary5,
      Iconsax.close_circle_outline,
      "NOTIFICATION_RULES",
    ),
  };

  @override
  void initState() {
    _initializeLayoutFromProvider();

    super.initState();
  }

  void _initializeLayoutFromProvider() {
    //Drawer_Views
    // final sectionManager = ref.read(tipoHabFilterProvider);

    //Views
    final typeFilter = ref.read(tipoHabFilterProvider);

    String? layout = Layout.checkList;
    String? order = OrderBy.antiguo;
    String? estado = "";

    switch (widget.route) {
      // case "USER_MANAGER":
      //   layout = managerFilter.layout;
      //   if (sectionManager[0]) order = managerFilter.orderByUser;
      //   if (sectionManager[1]) order = managerFilter.orderByRole;
      case "TIPO_HAB":
        layout = typeFilter.layout;
        order = typeFilter.orderBy;
      // case "Toallas":
      //   layout = typeFilter.layout;
      //   order = typeFilter.orderBy;
      //   estado = typeFilter.status;
      default:
    }

    layouts.updateAll((key, value) => false);
    switch (layout) {
      case "C":
        layouts.update(Iconsax.row_vertical_outline, (value) => true);
      case "M":
        layouts.update(Iconsax.element_4_outline, (value) => true);
      case "T":
        layouts.update(Iconsax.grid_1_outline, (value) => true);
      default:
        layouts.update(Iconsax.row_vertical_outline, (value) => true);
    }

    sorts.updateAll((key, value) => false);
    switch (order) {
      case "A":
        sorts.update("Alfabeticamente", (value) => true);
      case "MR":
        sorts.update("Mas recientes", (value) => true);
      case "MA":
        sorts.update("Mas antiguo", (value) => true);
      default:
        sorts.update("Alfabeticamente", (value) => true);
    }

    tags.updateAll(
      (key, value) => Tuple4(false, value.item2, value.item3, value.item4),
    );

    tags.removeWhere((key, value) =>
        value.item4.isNotEmpty && (value.item4 != widget.route));

    switch (estado) {
      case "":
        tags.update("Todas", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Leido":
        tags.update("Leidas", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Enviado":
        tags.update("No leidas", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Activo":
        tags.update("Activas", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Desactivado":
        tags.update("Desactivadas", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Registrado":
        tags.update("Registrado", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "En uso":
        tags.update("En uso", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Perdida":
        tags.update("Perdida", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Limpia":
        tags.update("Limpia", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Sucia":
        tags.update("Sucia", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      case "Expirada":
        tags.update("Expirada", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
      default:
        tags.update("Todas", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userFilter = ref.read(filterUMProvider);
    final tipoHabFilter = ref.read(tipoHabFilterProvider);

    // final destinosAsync = ref.watch(destinosReqProvider(""));

    return CustomDialog(
      title: "Visualización y filtros",
      withButtonSecondary: true,
      notCloseInstant: true,
      nameButton1: "Aplicar",
      nameButton2: "Limpiar",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 18,
        children: [
          if (widget.showLayout)
            SectionContent.containerBorder(
              context,
              title: "Layout",
              children: [
                Row(
                  spacing: 10,
                  children: [
                    for (var element in layouts.entries)
                      Expanded(
                        child: Buttons.filterButton1(
                          icon: element.key,
                          isActive: element.value,
                          onPressed: () {
                            Map<IconData, bool> newFilter = Map.from(layouts);
                            newFilter.updateAll((key, value) => false);
                            newFilter.update(element.key, (value) => true);
                            layouts = Map.from(newFilter);
                            setState(() {});
                          },
                        ),
                      )
                  ],
                ),
              ],
            ),
          if (widget.showTags)
            SectionContent.containerBorder(
              context,
              title: "Filtrar por etiquetas",
              children: [
                Wrap(
                  spacing: 7,
                  runSpacing: 5,
                  children: [
                    for (var element in tags.entries)
                      SizedBox(
                        height: 40,
                        child: ToolsUi.itemMedal(
                          element.key,
                          colorApply: element.value.item2,
                          icon: element.value.item3,
                          enable: element.value.item1,
                          onTap: () {
                            Map<String, Tuple4<bool, Color, IconData, String>>
                                newFilter = Map.from(tags);
                            newFilter.updateAll((key, value) => Tuple4(
                                false, value.item2, value.item3, value.item4));
                            newFilter.update(
                                element.key,
                                (value) => Tuple4(true, value.item2,
                                    value.item3, value.item4));
                            tags = Map.from(newFilter);
                            setState(() {});
                          },
                        ),
                      ),
                  ],
                )
              ],
            ),
          // if (widget.showFates)
          //   SectionContent.containerBorder(
          //     context,
          //     title: "Filtrar por destino",
          //     children: [
          //       destinosAsync.when(
          //         data: (data) {
          //           if (!startflow) {
          //             types = data.map((e) => e.copyWith()).toList();
          //             String? selectFilter;
          //             switch (widget.route) {
          //               case "Toallas":
          //                 selectFilter = towelFilter.fate;
          //               default:
          //             }

          //             if (selectFilter != null) {
          //               _resetFates(selectFilter, true);
          //             }
          //             startflow = true;
          //           }

          //           return Wrap(
          //             spacing: 7,
          //             runSpacing: 5,
          //             children: [
          //               SizedBox(
          //                 height: 40,
          //                 child: ToolsUi.itemMedal(
          //                   "Todas",
          //                   colorApply: AppColors.section2Primary,
          //                   enable: !types.any(
          //                     (element) => element.select,
          //                   ),
          //                   onTap: () {
          //                     _resetFates();
          //                   },
          //                 ),
          //               ),
          //               for (var element in types)
          //                 SizedBox(
          //                   height: 40,
          //                   child: ToolsUi.itemMedal(
          //                     element.nombre ?? 'Idefinido',
          //                     colorApply: element.colorToalla,
          //                     enable: element.select,
          //                     onTap: () {
          //                       _resetFates(element.id);
          //                     },
          //                   ),
          //                 ),
          //             ],
          //           );
          //         },
          //         error: (error, stackTrace) =>
          //             TextStyles.textEstandarRegular(
          //           text: "Error al consultar destinos",
          //         ),
          //         loading: () {
          //           return const Align(
          //             alignment: Alignment.center,
          //             child: SizedBox(
          //               height: 32,
          //               width: 32,
          //               child: CircularProgressIndicator(),
          //             ),
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          SectionContent.containerBorder(
            context,
            title: "Ordenar por",
            spacing: 10,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var element in sorts.entries)
                    SizedBox(
                      height: 50,
                      child: ListTile(
                        onTap: () {
                          Map<String, bool> newFilter = sorts;
                          newFilter.updateAll((key, value) => false);
                          newFilter.update(element.key, (value) => true);

                          sorts = newFilter;
                          setState(() {});
                        },
                        title: AppText.simpleText(text: element.key),
                        trailing: element.value
                            ? const Icon(Icons.check_rounded)
                            : null,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      funtion2: () {
        String newCode = UniqueKey().hashCode.toString();

        switch (widget.route) {
          // case "USER_MANAGER":
          //   ref.watch(filterUMProvider.notifier).update(
          //     (state) {
          //       FilterUserManager newFilter = state.copyWith();
          //       newFilter.layout = Layout.checkList;
          //       if (sectionManager[0]) {
          //         newFilter.orderByUser = OrderBy.antiguo;
          //       }
          //       if (sectionManager[1]) {
          //         newFilter.orderByRole = OrderBy.antiguo;
          //       }
          //       if (sectionManager[2]) {
          //         newFilter.orderByPermission = OrderBy.antiguo;
          //       }
          //       return newFilter;
          //     },
          //   );

          //   if (sectionManager[0]) {
          //     ref.invalidate(usuariosProvider);

          //     ref
          //         .read(keyUserListProvider.notifier)
          //         .update((state) => newCode);
          //   }

          //   if (sectionManager[1]) {
          //     ref.invalidate(rolesProvider);

          //     ref
          //         .read(keyRoleListProvider.notifier)
          //         .update((state) => newCode);
          //   }

          //   if (sectionManager[2]) {
          //     ref.invalidate(permisosProvider);

          //     ref
          //         .read(keyPermisoListProvider.notifier)
          //         .update((state) => newCode);
          //   }
          case "DESTINOS":
            ref.watch(tipoHabFilterProvider.notifier).update(
              (state) {
                return Filter(
                  layout: Layout.checkList,
                  orderBy: OrderBy.antiguo,
                );
              },
            );

            ref.invalidate(tipoHabListProvider(""));

          default:
        }

        Navigator.pop(context);
      },
      funtion1: () {
        String typeLayout = Layout.checkList;
        String orderBy = OrderBy.alfabetico;
        String? oldOrder = OrderBy.alfabetico;
        String tag = "";
        String? oldTag = "";
        String fate = "";
        String? oldFate = "";

        switch (widget.route) {
          // case "USER_MANAGER":
          //   if (sectionManager[0]) {
          //     oldOrder = userFilter.orderByUser;
          //   }

          //   if (sectionManager[1]) {
          //     oldOrder = userFilter.orderByRole;
          //   }

          //   if (sectionManager[2]) {
          //     oldOrder = userFilter.orderByPermission;
          //   }
          case "TIPO_HAB":
            oldOrder = tipoHabFilter.orderBy;
          default:
        }

        for (var element in layouts.entries) {
          if (element.value) {
            switch (element.key) {
              case Iconsax.row_vertical_outline:
                typeLayout = Layout.checkList;
              case Iconsax.element_4_outline:
                typeLayout = Layout.mosaico;
              case Iconsax.grid_1_outline:
                typeLayout = Layout.table;
              default:
                typeLayout = Layout.checkList;
            }
          }
        }

        for (var element in sorts.entries) {
          if (element.value) {
            switch (element.key) {
              case "Alfabeticamente":
                orderBy = OrderBy.alfabetico;
              case "Mas recientes":
                orderBy = OrderBy.recientes;
              case "Mas antiguo":
                orderBy = OrderBy.antiguo;
              default:
                orderBy = OrderBy.alfabetico;
            }
          }
        }

        for (var element in tags.entries) {
          if (element.value.item1) {
            switch (element.key) {
              case "Todas":
                tag = "";
              case "Leidas":
                tag = "Leido";
              case "No leidas":
                tag = "Enviado";
              case "Activas":
                tag = "Activo";
              case "Desactivadas":
                tag = "Desactivado";
              case "Registrado":
                tag = "Registrado";
              case "En uso":
                tag = "En uso";
              case "Perdida":
                tag = "Perdida";
              case "Limpia":
                tag = "Limpia";
              case "Sucia":
                tag = "Sucia";
              case "Expirada":
                tag = "Expirada";
              default:
                tag = '';
            }
          }
        }

        fate = types
                .where((element) {
                  return element.select;
                })
                .firstOrNull
                ?.id ??
            '';

        switch (widget.route) {
          // case "USER_MANAGER":
          //   ref.watch(filterUMProvider.notifier).update(
          //     (state) {
          //       FilterUserManager newFilter = state.copyWith();
          //       newFilter.layout = typeLayout;
          //       if (sectionManager[0]) {
          //         newFilter.orderByUser = orderBy;
          //       }
          //       if (sectionManager[1]) {
          //         newFilter.orderByRole = orderBy;
          //       }
          //       if (sectionManager[2]) {
          //         newFilter.orderByPermission = orderBy;
          //       }
          //       return newFilter;
          //     },
          //   );
          case "TIPO_HAB":
            ref.watch(tipoHabFilterProvider.notifier).update(
              (state) {
                return Filter(
                  layout: typeLayout,
                  orderBy: orderBy,
                );
              },
            );
          default:
        }

        String newCode = UniqueKey().hashCode.toString();

        bool updateTag = widget.showTags ? oldTag == tag : true;

        bool updateFate = widget.showTypes ? oldFate == fate : true;

        if (oldOrder == orderBy && updateTag && updateFate) {
          switch (widget.route) {
            // case "USER_MANAGER":
            //   ref
            //       .read(updateViewUserListProvider.notifier)
            //       .update((state) => newCode);

            //   ref
            //       .read(updateViewRoleListProvider.notifier)
            //       .update((state) => newCode);

            //   ref
            //       .read(updateViewPermisoListProvider.notifier)
            //       .update((state) => newCode);
            case "TIPO_HAB":
            // ref
            //     .read(updateViewFateListProvider.notifier)
            //     .update((state) => newCode);
            default:
          }
        } else {
          switch (widget.route) {
            // case "USER_MANAGER":
            //   if (sectionManager[0]) {
            //     ref
            //         .read(keyUserListProvider.notifier)
            //         .update((state) => newCode);
            //   }

            //   if (sectionManager[1]) {
            //     ref
            //         .read(keyRoleListProvider.notifier)
            //         .update((state) => newCode);
            //   }

            //   if (sectionManager[2]) {
            //     ref
            //         .read(keyPermisoListProvider.notifier)
            //         .update((state) => newCode);
            //   }

            case "TIPO_HAB":
            // ref
            //     .read(keyFateListProvider.notifier)
            //     .update((state) => newCode);

            default:
          }
        }

        Navigator.pop(context);
      },
    );
  }

  void _resetTypes([String? id, bool notUpdate = false]) {
    for (var element in types) {
      element.select = false;

      if (element.id == id) {
        element.select = true;
      }
    }
    if (!notUpdate) setState(() {});
  }
}
