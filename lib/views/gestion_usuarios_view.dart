// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:generador_formato/view-models/providers/usuario_provider.dart';
// import 'package:generador_formato/view-models/services/auth_service.dart';
// import 'package:generador_formato/res/ui/buttons.dart';
// import 'package:generador_formato/res/ui/show_snackbar.dart';
// import 'package:generador_formato/views/usuarios/dialogs/edit_user_dialog.dart';
// import 'package:generador_formato/utils/widgets/usuario_item_row.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:sidebarx/src/controller/sidebarx_controller.dart';

// import '../res/ui/custom_widgets.dart';
// import '../res/ui/progress_indicator.dart';
// import '../res/ui/textformfield_style.dart';
// import '../utils/shared_preferences/settings.dart';
// import '../res/ui/text_styles.dart';

// class GestionUsuariosView extends ConsumerStatefulWidget {
//   const GestionUsuariosView({super.key, required this.sideController});

//   final SidebarXController sideController;
//   @override
//   _GestionUsuariosViewState createState() => _GestionUsuariosViewState();
// }

// const List<Widget> modesVisual = <Widget>[
//   Icon(Icons.table_chart),
//   Icon(HeroIcons.list_bullet),
// ];

// class _GestionUsuariosViewState extends ConsumerState<GestionUsuariosView> {
//   final List<bool> _selectedMode = <bool>[true, false];
//   final TextEditingController _searchController =
//       TextEditingController(text: "");
//   bool startFlow = false;

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     final usuariosProvider = ref.watch(userQueryProvider(""));
//     final isEmptyUser = ref.watch(isEmptyUserProvider);
//     var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

//     void _searchQuote({String? text}) {
//       ref
//           .read(searchUserProvider.notifier)
//           .update((state) => text ?? _searchController.text);
//       ref.read(isEmptyUserProvider.notifier).update((state) => false);
//     }

//     if (!startFlow) {
//       if (!isEmptyUser) {
//         Future.delayed(
//             100.ms,
//             () =>
//                 ref.read(isEmptyUserProvider.notifier).update((state) => true));
//       }
//       startFlow = true;
//     }

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextStyles.titlePagText(
//                           text: "Gestión de usuarios",
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         TextStyles.standardText(
//                           text:
//                               "Crea, edita, supervisa y declina los usuarios activos del sistema.",
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 180,
//                     height: 37,
//                     child: Buttons.commonButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (contextBL) {
//                             return EditUserDialog(
//                               onInsert: (p0) async {
//                                 if (!await AuthService().saveUsers(p0)) {
//                                   showSnackBar(
//                                       context: context,
//                                       title: "Error al crear nuevo usuario",
//                                       message:
//                                           "Se presento un problema al registrar un nuevo usuario.",
//                                       type: "danger");
//                                   return;
//                                 }
//                                 showSnackBar(
//                                     context: context,
//                                     title: "Usuario creado correctamente",
//                                     message:
//                                         "Se creo el nuevo usuario: ${p0!.username}",
//                                     type: "success");
//                                 ref
//                                     .read(changeUsersProvider.notifier)
//                                     .update((state) => UniqueKey().hashCode);
//                               },
//                             );
//                           },
//                         );
//                       },
//                       text: "Agregar usuario",
//                     ),
//                   )
//                 ],
//               ).animate().fadeIn(
//                     delay: !Settings.applyAnimations ? null : 200.ms,
//                     duration: Settings.applyAnimations ? null : 0.ms,
//                   ),
//               Divider(
//                 color: brightness == Brightness.light
//                     ? Colors.black
//                     : Colors.white,
//               ).animate().fadeIn(
//                     duration: Settings.applyAnimations ? null : 0.ms,
//                   ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomWidgets.sectionButton(
//                       listModes: _selectedMode,
//                       modesVisual: modesVisual,
//                       onChanged: (p0, p1) =>
//                           setState(() => _selectedMode[p0] = p0 == p1),
//                     ),
//                     SizedBox(
//                       width: screenWidth * 0.32,
//                       height: 39,
//                       child: StatefulBuilder(builder: (context, snapshot) {
//                         return TextField(
//                           onSubmitted: (value) {
//                             _searchQuote(text: value);
//                             _searchController.text = '';
//                           },
//                           onChanged: (value) => snapshot(() {}),
//                           controller: _searchController,
//                           style: const TextStyle(
//                               fontSize: 13,
//                               fontFamily: "poppins_regular",
//                               height: 1),
//                           decoration: TextFormFieldStyle.decorationFieldSearch(
//                             label: "Buscar",
//                             controller: _searchController,
//                             function: () {
//                               if (_searchController.text.isNotEmpty) {
//                                 _searchController.text = '';
//                               }
//                             },
//                           ),
//                         );
//                       }),
//                     )
//                   ],
//                 ),
//               ).animate().fadeIn(
//                     delay: !Settings.applyAnimations ? null : 350.ms,
//                     duration: Settings.applyAnimations ? null : 0.ms,
//                   ),
//               if (_selectedMode.first)
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
//                   child: Table(
//                     columnWidths: {
//                       0: const FractionColumnWidth(.05),
//                       1: (screenWidth < 1200)
//                           ? const FractionColumnWidth(0.2)
//                           : const FractionColumnWidth(0.15),
//                       if (screenWidth < 1100) 4: const FractionColumnWidth(.15),
//                       if (screenWidth > 1100 && screenWidth < 1300)
//                         5: const FractionColumnWidth(.12),
//                       if (screenWidth > 1300) 6: const FractionColumnWidth(.12),
//                     },
//                     children: [
//                       TableRow(
//                         children: [
//                           for (var element in [
//                             "ID",
//                             "Rol",
//                             "Nombre",
//                             if (screenWidth > 1100) "Correo",
//                             if (screenWidth > 1300) "Teléfono",
//                             "Contraseña",
//                             "  Opciones  ",
//                           ])
//                             TextStyles.standardText(
//                                 text: element,
//                                 align: TextAlign.center,
//                                 color: Theme.of(context).primaryColor,
//                                 isBold: true,
//                                 overClip: true),
//                         ],
//                       ),
//                     ],
//                     border: TableBorder(
//                       verticalInside: BorderSide(
//                         color: Theme.of(context).primaryColorLight,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ).animate().fadeIn(
//                       delay: !Settings.applyAnimations ? null : 300.ms,
//                       duration: Settings.applyAnimations ? null : 0.ms,
//                     ),
//               Divider(color: Theme.of(context).primaryColorLight)
//                   .animate()
//                   .fadeIn(
//                     duration: Settings.applyAnimations ? null : 0.ms,
//                   ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
//                 child: usuariosProvider.when(
//                   data: (list) {
//                     return Column(
//                       children: [
//                         if (list.isEmpty)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 32),
//                             child: CustomWidgets.messageNotResult(
//                               context: context,
//                               sizeImage: 130,
//                               message:
//                                   "No se encontraron usuarios\n registrados",
//                             )
//                                 .animate(
//                                     delay: !Settings.applyAnimations
//                                         ? null
//                                         : 450.ms)
//                                 .slide(begin: const Offset(0, 0.1))
//                                 .fadeIn(
//                                   duration:
//                                       Settings.applyAnimations ? null : 0.ms,
//                                 ),
//                           ),
//                         if (list.isNotEmpty)
//                           SizedBox(
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.vertical,
//                               itemCount: list.length,
//                               itemBuilder: (context, index) {
//                                 return UsuarioItemRow(
//                                   index: index,
//                                   usuario: list[index],
//                                   sideController: widget.sideController,
//                                   isTable: _selectedMode.first,
//                                   onUpdateList: () {
//                                     ref
//                                         .read(changeUsersProvider.notifier)
//                                         .update(
//                                             (state) => UniqueKey().hashCode);
//                                     ref
//                                         .read(isEmptyUserProvider.notifier)
//                                         .update((state) => true);
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                       ],
//                     );
//                   },
//                   error: (error, stackTrace) {
//                     return SizedBox(
//                       height: 280,
//                       child: CustomWidgets.messageNotResult(context: context),
//                     );
//                   },
//                   loading: () {
//                     return ProgressIndicatorCustom(
//                       screenHight: 320,
//                       message: TextStyles.standardText(
//                         text: "Buscando usuarios",
//                         align: TextAlign.center,
//                         size: 11,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tuple/tuple.dart';

import '../res/helpers/animation_helpers.dart';
import '../res/ui/buttons.dart';
import '../res/ui/custom_widgets.dart';
import '../res/ui/text_styles.dart';
import '../res/ui/title_page.dart';
import '../utils/widgets/filter_modal.dart';
import '../utils/widgets/item_rows.dart';
import '../view-models/providers/gestion_usuario_provider.dart';
import '../view-models/providers/rol_provider.dart';
import '../view-models/providers/ui_provider.dart';
import '../view-models/providers/usuario_provider.dart';
import 'roles/dialogs/rol_delete_dialog.dart';
import 'usuarios/dialogs/usuario_delete_dialog.dart';

class GestionUsuariosView extends ConsumerWidget {
  const GestionUsuariosView({
    super.key,
    required this.sideController,
  });

  final SidebarXController sideController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSearchBar = ref.watch(showSearchExtProvider);
    final showSelectFunction = ref.watch(selectItemsUMProvider);
    final sectionManager = ref.watch(sectionManagerProvider);
    final sizeScreen = MediaQuery.of(context).size;
    final filter = ref.watch(filterUMProvider);
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    //user provider
    final userListKey = ref.watch(keyUserListProvider);
    Tuple4<String, String, String, String> _getArgUser() {
      var arg = Tuple4("", filter.orderByUser ?? "", userListKey, "registrado");
      return arg;
    }

    //role provider
    final roleListKey = ref.watch(keyRoleListProvider);
    Tuple3<String, String, String> _getArgRole() {
      var arg = Tuple3("", filter.orderByRole ?? "", roleListKey);
      return arg;
    }

    void existSearchUser() {
      String oldSearch = ref.watch(usuarioSearchProvider);

      if (oldSearch.isNotEmpty) {
        ref.watch(usuarioSearchProvider.notifier).update((state) => "");
        ref
            .watch(searchManagerUserProvider.notifier)
            .update((state) => TextEditingController());
        ref.read(keyUserListProvider.notifier).update((state) {
          return UniqueKey().hashCode.toString();
        });
      }
    }

    void existSearchRole() {
      String oldSearch = ref.watch(rolSearchProvider);

      if (oldSearch.isNotEmpty) {
        ref.watch(rolSearchProvider.notifier).update((state) => "");
        ref
            .watch(searchManagerUserProvider.notifier)
            .update((state) => TextEditingController());
        ref.read(keyRoleListProvider.notifier).update((state) {
          return UniqueKey().hashCode.toString();
        });
      }
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(selectAllItemsUMProvider.notifier).update((state) => false);
        ref.read(selectItemsUMProvider.notifier).update((state) => false);
        ref.read(usuariosProvider(_getArgUser()).notifier).selectAll(false);
        ref.read(rolesProvider(_getArgRole()).notifier).selectAll(false);

        existSearchUser();
        existSearchRole();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    AnimatedEntry(
                      duration: const Duration(milliseconds: 200),
                      child: TitlePage(
                        title: "Gestión de usuarios",
                        subtitle:
                            "Administra los usuarios y accesos del sistema.",
                        childOptional: Buttons.buttonPrimary(
                          text: "Agregar usuario",
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const AnimatedEntry(
                      type: AnimationType.slideIn,
                      child: Divider(),
                    ),
                  ],
                ),
                Card(
                  child: Row(
                    children: [
                      if (!showSelectFunction)
                        Buttons.floatingButton(
                          context,
                          tag: "search_manager_user",
                          icon: showSearchBar
                              ? Iconsax.close_circle_outline
                              : Iconsax.search_normal_outline,
                          onPressed: () {
                            ref.read(showSearchExtProvider.notifier).update(
                              (state) {
                                return !showSearchBar;
                              },
                            );

                            if (showSearchBar) {
                              if (sectionManager[0]) {
                                existSearchUser();
                              }
                              if (sectionManager[1]) {
                                existSearchRole();
                              }
                            }
                          },
                        ),
                      if (!showSelectFunction && !showSearchBar)
                        Buttons.floatingButton(
                          context,
                          tag: "filter_manager_user",
                          icon: Iconsax.filter_search_outline,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              elevation: 3,
                              enableDrag: false,
                              isScrollControlled: true,
                              backgroundColor: brightness == Brightness.dark
                                  ? null
                                  : Colors.white,
                              builder: (context) {
                                return const FilterModal(
                                  route: "USER_MANAGER",
                                );
                              },
                            );
                          },
                        ),
                      if (!showSearchBar)
                        ItemRow.compactOptions(
                          customItems: [
                            if (showSelectFunction)
                              ItemRow.itemPopup(
                                "Eliminar selecciones",
                                Iconsax.trash_outline,
                                () async {
                                  bool withSelections = false;

                                  if (sectionManager[0]) {
                                    withSelections = ref
                                        .read(usuariosProvider(_getArgUser())
                                            .notifier)
                                        .withSelections();
                                  }

                                  if (sectionManager[1]) {
                                    withSelections = ref
                                        .read(rolesProvider(_getArgRole())
                                            .notifier)
                                        .withSelections();
                                  }

                                  if (!withSelections) return;

                                  Widget _dialog = AlertDialog(
                                    title: TextStyles.standardText(
                                      text: "Dialogo no encontrado",
                                    ),
                                  );

                                  if (sectionManager[0]) {
                                    _dialog = const UsuarioDeleteDialog();
                                  }

                                  if (sectionManager[1]) {
                                    _dialog = const RolDeleteDialog();
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return _dialog;
                                    },
                                  );
                                },
                              ),
                            if (showSelectFunction)
                              ItemRow.itemPopup(
                                "Cancelar",
                                Iconsax.redo_outline,
                                () {
                                  ref
                                      .read(selectAllItemsUMProvider.notifier)
                                      .update((state) => false);

                                  if (sectionManager[0]) {
                                    ref
                                        .read(usuariosProvider(_getArgUser())
                                            .notifier)
                                        .selectAll(false);
                                  }

                                  if (sectionManager[1]) {
                                    ref
                                        .read(rolesProvider(_getArgRole())
                                            .notifier)
                                        .selectAll(false);
                                  }

                                  ref
                                      .read(selectItemsUMProvider.notifier)
                                      .update((state) => false);
                                },
                              ),
                            if (!showSelectFunction && sectionManager[0])
                              ItemRow.itemPopup(
                                "Usuarios eliminados",
                                Iconsax.user_minus_outline,
                                () {
                                  // pushScreen(
                                  //   context,
                                  //   screen: const UsuarioRecovery(),
                                  //   withNavBar: true,
                                  //   pageTransitionAnimation:
                                  //       PageTransitionAnimation.cupertino,
                                  // );
                                },
                              ),
                            if (!showSelectFunction)
                              ItemRow.itemPopup(
                                "Seleccionar",
                                Iconsax.stop_outline,
                                () {
                                  bool activeSelection = false;

                                  if (sectionManager[0]) {
                                    activeSelection = ref
                                        .read(usuariosProvider(_getArgUser())
                                            .notifier)
                                        .isNotEmpty();
                                  }

                                  if (sectionManager[1]) {
                                    activeSelection = ref
                                        .read(rolesProvider(_getArgRole())
                                            .notifier)
                                        .isNotEmpty();
                                  }

                                  if (!activeSelection) return;

                                  ref
                                      .read(selectItemsUMProvider.notifier)
                                      .update((state) => true);
                                },
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
