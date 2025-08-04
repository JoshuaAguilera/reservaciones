import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuple/tuple.dart';

import '../../models/list_helper_model.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/section_content.dart';
import '../../res/ui/text_styles.dart';
import '../../res/ui/tools_ui.dart';
import '../../view-models/providers/gestion_usuario_provider.dart';
import '../../view-models/providers/notificacion_provider.dart';
import '../../view-models/providers/rol_provider.dart';
import '../../view-models/providers/usuario_provider.dart';

class FilterModal extends ConsumerStatefulWidget {
  const FilterModal({
    super.key,
    required this.route,
    this.showLayout = true,
    this.showTags = false,
    this.showFates = false,
  });

  final String route;
  final bool showLayout;
  final bool showTags;
  final bool showFates;

  @override
  _FilterModal createState() => _FilterModal();
}

class _FilterModal extends ConsumerState<FilterModal> {
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
      DesktopColors.primary1,
      Iconsax.category_outline,
      "",
    ),
    "No leidas": Tuple4(
      false,
      DesktopColors.primary2,
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
    "Registrado": Tuple4(
      false,
      DesktopColors.primary1,
      Iconsax.book_saved_outline,
      "Toallas",
    ),
  };

  @override
  void initState() {
    _initializeLayoutFromProvider();

    super.initState();
  }

  void _initializeLayoutFromProvider() {
    //Drawer_Views
    final sectionManager = ref.read(sectionManagerProvider);
    final managerFilter = ref.read(filterUMProvider);
    final notificationFilter = ref.read(filterNotProvider);

    String? layout = Layout.checkList;
    String? order = OrderBy.antiguo;
    String? estado = "";

    switch (widget.route) {
      case "USER_MANAGER":
        layout = managerFilter.layout;
        if (sectionManager[0]) order = managerFilter.orderByUser;
        if (sectionManager[1]) order = managerFilter.orderByRole;
      case "NOTIFICATIONS":
        order = notificationFilter.orderBy;
        estado = notificationFilter.status;

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
      default:
        tags.update("Todas", (value) {
          return Tuple4(true, value.item2, value.item3, value.item4);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userFilter = ref.read(filterUMProvider);
    final notificationFilter = ref.read(filterNotProvider);
    final sectionManager = ref.read(sectionManagerProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.94),
          child: ToolsUi.contentModalStandar(
            context,
            isExcluced: true,
            title: "Visualización y filtros",
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
                          Buttons.filterButton1(
                            icon: element.key,
                            isActive: element.value,
                            onPressed: () {
                              Map<IconData, bool> newFilter = Map.from(layouts);
                              newFilter.updateAll((key, value) => false);
                              newFilter.update(element.key, (value) => true);
                              layouts = Map.from(newFilter);
                              setState(() {});
                            },
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
                                Map<String,
                                        Tuple4<bool, Color, IconData, String>>
                                    newFilter = Map.from(tags);
                                newFilter.updateAll((key, value) => Tuple4(
                                    false,
                                    value.item2,
                                    value.item3,
                                    value.item4));
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
              SectionContent.containerBorder(
                context,
                title: "Ordenar por",
                spacing: 10,
                children: [
                  Column(
                    children: [
                      for (var element in sorts.entries)
                        ListTile(
                          onTap: () {
                            Map<String, bool> newFilter = sorts;
                            newFilter.updateAll((key, value) => false);
                            newFilter.update(element.key, (value) => true);

                            sorts = newFilter;
                            setState(() {});
                          },
                          title: TextStyles.standardText(text: element.key),
                          trailing: element.value
                              ? const Icon(Icons.check_rounded)
                              : null,
                        ),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: Buttons.buttonSecundary(
                      text: "Limpiar",
                      onPressed: () {
                        String newCode = UniqueKey().hashCode.toString();

                        switch (widget.route) {
                          case "USER_MANAGER":
                            ref.watch(filterUMProvider.notifier).update(
                              (state) {
                                FilterUserManager newFilter = state.copyWith();
                                newFilter.layout = Layout.checkList;
                                if (sectionManager[0]) {
                                  newFilter.orderByUser = OrderBy.antiguo;
                                }
                                if (sectionManager[1]) {
                                  newFilter.orderByRole = OrderBy.antiguo;
                                }
                                if (sectionManager[2]) {
                                  newFilter.orderByPermission = OrderBy.antiguo;
                                }
                                return newFilter;
                              },
                            );

                            if (sectionManager[0]) {
                              ref.invalidate(usuariosProvider);

                              ref
                                  .read(keyUserListProvider.notifier)
                                  .update((state) => newCode);
                            }

                            if (sectionManager[1]) {
                              ref.invalidate(rolesProvider);

                              ref
                                  .read(keyRoleListProvider.notifier)
                                  .update((state) => newCode);
                            }

                          // if (sectionManager[2]) {
                          //   ref.invalidate(permisosProvider);

                          //   ref
                          //       .read(keyPermisoListProvider.notifier)
                          //       .update((state) => newCode);
                          // }
                          case "NOTIFICATIONS":
                            ref.watch(filterNotProvider.notifier).update(
                              (state) {
                                return Filter(
                                  orderBy: OrderBy.recientes,
                                  status: "",
                                );
                              },
                            );

                            ref.invalidate(notificacionesProvider);
                            ref
                                .read(keyNotListProvider.notifier)
                                .update((state) => newCode);
                          // case "NOTIFICATION_RULES":
                          //   ref.watch(filterNotRuleProvider.notifier).update(
                          //     (state) {
                          //       return Filter(
                          //         layout: Layout.checkList,
                          //         orderBy: OrderBy.recientes,
                          //         status: "",
                          //       );
                          //     },
                          //   );

                          //   ref.invalidate(notificationRulesProvider);
                          //   ref
                          //       .read(keyNotRuleListProvider.notifier)
                          //       .update((state) => newCode);
                          default:
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: Buttons.buttonPrimary(
                      text: "Aplicar",
                      padVer: 4,
                      onPressed: () {
                        String typeLayout = Layout.checkList;
                        String orderBy = OrderBy.alfabetico;
                        String? oldOrder = OrderBy.alfabetico;
                        String tag = "";
                        String? oldTag = "";
                        String fate = "";
                        String? oldFate = "";

                        switch (widget.route) {
                          case "USER_MANAGER":
                            if (sectionManager[0]) {
                              oldOrder = userFilter.orderByUser;
                            }

                            if (sectionManager[1]) {
                              oldOrder = userFilter.orderByRole;
                            }

                            if (sectionManager[2]) {
                              oldOrder = userFilter.orderByPermission;
                            }
                          case "NOTIFICATIONS":
                            oldOrder = notificationFilter.orderBy;
                            oldTag = notificationFilter.status;
                          // case "NOTIFICATION_RULES":
                          //   oldOrder = notificationRuleFilter.orderBy;
                          //   oldTag = notificationRuleFilter.status;
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

                        switch (widget.route) {
                          case "USER_MANAGER":
                            ref.watch(filterUMProvider.notifier).update(
                              (state) {
                                FilterUserManager newFilter = state.copyWith();
                                newFilter.layout = typeLayout;
                                if (sectionManager[0]) {
                                  newFilter.orderByUser = orderBy;
                                }
                                if (sectionManager[1]) {
                                  newFilter.orderByRole = orderBy;
                                }
                                if (sectionManager[2]) {
                                  newFilter.orderByPermission = orderBy;
                                }
                                return newFilter;
                              },
                            );

                          case "NOTIFICATIONS":
                            ref.watch(filterNotProvider.notifier).update(
                              (state) {
                                return Filter(orderBy: orderBy, status: tag);
                              },
                            );
                          // case "NOTIFICATION_RULES":
                          //   ref.watch(filterNotRuleProvider.notifier).update(
                          //     (state) {
                          //       return Filter(
                          //         layout: typeLayout,
                          //         orderBy: orderBy,
                          //         status: tag,
                          //       );
                          //     },
                          //   );
                          default:
                        }

                        String newCode = UniqueKey().hashCode.toString();

                        bool updateTag = widget.showTags ? oldTag == tag : true;

                        bool updateFate =
                            widget.showFates ? oldFate == fate : true;

                        if (oldOrder == orderBy && updateTag && updateFate) {
                          switch (widget.route) {
                            case "USER_MANAGER":
                              ref
                                  .read(updateViewUserListProvider.notifier)
                                  .update((state) => newCode);

                              ref
                                  .read(updateViewRoleListProvider.notifier)
                                  .update((state) => newCode);

                            case "NOTIFICATIONS":
                              ref
                                  .read(updateViewNotificationListProvider
                                      .notifier)
                                  .update((state) => newCode);
                            // case "NOTIFICATION_RULES":
                            //   ref
                            //       .read(updateViewNotRuleListProvider.notifier)
                            //       .update((state) => newCode);
                            default:
                          }
                        } else {
                          switch (widget.route) {
                            case "USER_MANAGER":
                              if (sectionManager[0]) {
                                ref
                                    .read(keyUserListProvider.notifier)
                                    .update((state) => newCode);
                              }

                              if (sectionManager[1]) {
                                ref
                                    .read(keyRoleListProvider.notifier)
                                    .update((state) => newCode);
                              }

                            case "NOTIFICATIONS":
                              ref
                                  .read(keyNotListProvider.notifier)
                                  .update((state) => newCode);
                            // case "NOTIFICATION_RULES":
                            //   ref
                            //       .read(keyNotRuleListProvider.notifier)
                            //       .update((state) => newCode);
                            default:
                          }
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
