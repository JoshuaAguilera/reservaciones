import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/usuario_provider.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/usuario_item_row.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../ui/custom_widgets.dart';
import '../ui/progress_indicator.dart';
import '../ui/textformfield_style.dart';
import '../utils/helpers/utility.dart';
import '../widgets/text_styles.dart';

class GestionUsuariosView extends ConsumerStatefulWidget {
  const GestionUsuariosView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  _GestionUsuariosViewState createState() => _GestionUsuariosViewState();
}

const List<Widget> modesVisual = <Widget>[
  Icon(Icons.table_chart),
  Icon(Icons.dehaze_sharp),
];

class _GestionUsuariosViewState extends ConsumerState<GestionUsuariosView> {
  final List<bool> _selectedMode = <bool>[true, false];
  final TextEditingController _searchController =
      TextEditingController(text: "");
  bool startFlow = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final usuariosProvider = ref.watch(userQueryProvider(""));
    final isEmptyUser = ref.watch(isEmptyUserProvider);
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    void _searchQuote({String? text}) {
      ref
          .read(searchUserProvider.notifier)
          .update((state) => text ?? _searchController.text);
      ref.read(isEmptyUserProvider.notifier).update((state) => false);
    }

    if (!startFlow) {
      if (isEmptyUser) {
        Future.delayed(
            100.ms,
            () =>
                ref.read(isEmptyUserProvider.notifier).update((state) => true));
      }
      startFlow = true;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyles.titlePagText(
                          text: "Gestión de usuarios",
                          color: Theme.of(context).primaryColor,
                        ),
                        TextStyles.standardText(
                          text:
                              "Crea, edita, supervisa y declina los usuarios activos del sistema.",
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  Buttons.commonButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contextBL) {
                          return Dialogs().userFormDialog(
                            brightness: brightness,
                            buildContext: contextBL,
                            onInsert: (p0) async {
                              if (!await AuthService().saveUsers(p0)) {
                                showSnackBar(
                                    context: context,
                                    title: "Error al crear nuevo usuario",
                                    message:
                                        "Se presento un problema al registrar un nuevo usuario.",
                                    type: "danger");
                                return;
                              }
                              showSnackBar(
                                  context: context,
                                  title: "Usuario creado correctamente",
                                  message:
                                      "Se creo el nuevo usuario: ${p0!.username}",
                                  type: "success");
                              ref
                                  .read(changeUsersProvider.notifier)
                                  .update((state) => UniqueKey().hashCode);
                            },
                          );
                        },
                      );
                    },
                    text: "Agregar usuario",
                    color: DesktopColors.cerulean,
                  )
                ],
              ).animate().fadeIn(delay: 200.ms),
              Divider(
                color: brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ).animate().fadeIn(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgets.sectionButton(
                      listModes: _selectedMode,
                      modesVisual: modesVisual,
                      onChanged: (p0, p1) =>
                          setState(() => _selectedMode[p0] = p0 == p1),
                    ),
                    SizedBox(
                      width: screenWidth * 0.32,
                      height: 39,
                      child: StatefulBuilder(builder: (context, snapshot) {
                        return TextField(
                          onSubmitted: (value) {
                            _searchQuote(text: value);
                            _searchController.text = '';
                          },
                          onChanged: (value) => snapshot(() {}),
                          controller: _searchController,
                          style: const TextStyle(
                              fontSize: 13,
                              fontFamily: "poppins_regular",
                              height: 1),
                          decoration: TextFormFieldStyle.decorationFieldSearch(
                            label: "Buscar",
                            controller: _searchController,
                            function: () {
                              if (_searchController.text.isNotEmpty) {
                                _searchController.text = '';
                              }
                            },
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ).animate().fadeIn(delay: 350.ms),
              if (!Utility.isResizable(
                      extended: widget.sideController.extended,
                      context: context) &&
                  _selectedMode.first)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Table(
                    columnWidths: {
                      0: const FractionColumnWidth(.05),
                      1: (screenWidth < 1200)
                          ? const FractionColumnWidth(0.2)
                          : const FractionColumnWidth(0.15),
                      if (screenWidth < 1100) 4: const FractionColumnWidth(.15),
                      if (screenWidth > 1100 && screenWidth < 1300)
                        5: const FractionColumnWidth(.12),
                      if (screenWidth > 1300) 6: const FractionColumnWidth(.12),
                    },
                    children: [
                      TableRow(
                        children: [
                          for (var element in [
                            "ID",
                            "Rol",
                            "Nombre",
                            if (screenWidth > 1100) "Correo",
                            if (screenWidth > 1300) "Teléfono",
                            "Contraseña",
                            "  Opciones  ",
                          ])
                            TextStyles.standardText(
                                text: element,
                                aling: TextAlign.center,
                                color: Theme.of(context).primaryColor,
                                isBold: true,
                                overClip: true),
                        ],
                      ),
                    ],
                    border: TableBorder(
                      verticalInside: BorderSide(
                        color: Theme.of(context).primaryColorLight,
                        width: 2,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms),
              Divider(color: Theme.of(context).primaryColorLight)
                  .animate()
                  .fadeIn(),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                child: usuariosProvider.when(
                  data: (list) {
                    return Column(
                      children: [
                        if (list.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: CustomWidgets.messageNotResult(
                              context: context,
                              sizeImage: 130,
                              message:
                                  "No se encontraron usuarios\n registrados",
                            )
                                .animate(delay: 450.ms)
                                .slide(begin: const Offset(0, 0.1))
                                .fadeIn(),
                          ),
                        if (list.isNotEmpty)
                          SizedBox(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return UsuarioItemRow(
                                  index: index,
                                  usuario: list[index],
                                  sideController: widget.sideController,
                                  isTable: _selectedMode.first,
                                  onUpdateList: () {
                                    ref
                                        .read(changeUsersProvider.notifier)
                                        .update(
                                            (state) => UniqueKey().hashCode);
                                    ref
                                        .read(isEmptyUserProvider.notifier)
                                        .update((state) => true);
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return SizedBox(
                      height: 280,
                      child: CustomWidgets.messageNotResult(context: context),
                    );
                  },
                  loading: () {
                    return ProgressIndicatorCustom(screenHight: 320);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
