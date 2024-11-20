import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/usuario_provider.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../ui/custom_widgets.dart';
import '../ui/progress_indicator.dart';
import '../utils/encrypt/encrypter.dart';
import '../utils/helpers/utility.dart';
import '../widgets/text_styles.dart';
import '../widgets/textformfield_custom.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final usuariosProvider = ref.watch(allUsersProvider(""));
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

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
              ),
              Divider(
                color: brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              CustomWidgets.sectionButton(
                listModes: _selectedMode,
                modesVisual: modesVisual,
                onChanged: (p0, p1) {},
              ),
              if (!Utility.isResizable(
                  extended: widget.sideController.extended, context: context))
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
                          TextStyles.standardText(
                              text: "ID",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              isBold: true,
                              overClip: true),
                          TextStyles.standardText(
                              text: "Rol",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              isBold: true,
                              overClip: true),
                          TextStyles.standardText(
                              text: "Nombre",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              isBold: true,
                              overClip: true),
                          if (screenWidth > 1100)
                            TextStyles.standardText(
                                text: "Correo",
                                aling: TextAlign.center,
                                color: Theme.of(context).primaryColor,
                                isBold: true,
                                overClip: true),
                          if (screenWidth > 1300)
                            TextStyles.standardText(
                                text: "Teléfono",
                                aling: TextAlign.center,
                                color: Theme.of(context).primaryColor,
                                isBold: true,
                                overClip: true),
                          TextStyles.standardText(
                              text: "Contraseña",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              isBold: true,
                              overClip: true),
                          TextStyles.standardText(
                              text: "  Opciones  ",
                              aling: TextAlign.center,
                              color: Theme.of(context).primaryColor,
                              isBold: true,
                              overClip: false),
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
                ),
              Divider(color: Theme.of(context).primaryColorLight),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                child: usuariosProvider.when(
                  data: (list) {
                    return Column(
                      children: [
                        for (var data in list)
                          Card(
                            elevation: 4,
                            child: Table(
                              columnWidths: {
                                0: const FractionColumnWidth(.05),
                                1: (screenWidth < 1200)
                                    ? const FractionColumnWidth(0.2)
                                    : const FractionColumnWidth(0.15),
                                if (screenWidth < 1100)
                                  4: const FractionColumnWidth(.15),
                                if (screenWidth > 1100 && screenWidth < 1300)
                                  5: const FractionColumnWidth(.12),
                                if (screenWidth > 1300)
                                  6: const FractionColumnWidth(.12),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    TextStyles.standardText(
                                      text: data.id.toString(),
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Utility.getColorTypeUser(
                                              data.rol!),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextStyles.standardText(
                                            text: data.rol!,
                                            aling: TextAlign.center,
                                            color: Theme.of(context).cardColor,
                                            overClip: true,
                                            isBold: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextStyles.standardText(
                                      text: data.username ?? '',
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true,
                                    ),
                                    if (screenWidth > 1100)
                                      TextStyles.standardText(
                                        text: data.correoElectronico ?? '-',
                                        aling: TextAlign.center,
                                        color: Theme.of(context).primaryColor,
                                        overClip: true,
                                      ),
                                    if (screenWidth > 1300)
                                      TextStyles.standardText(
                                        text: data.telefono ?? '-',
                                        aling: TextAlign.center,
                                        color: Theme.of(context).primaryColor,
                                        overClip: true,
                                      ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 7, 8, 0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 47,
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          msgError: "",
                                          isPassword: true,
                                          passwordVisible: true,
                                          name: "",
                                          initialValue:
                                              EncrypterTool.decryptData(
                                                  data.password ?? '', null),
                                          readOnly: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (contextBL) {
                                                  return Dialogs()
                                                      .userFormDialog(
                                                    buildContext: contextBL,
                                                    brightness: brightness,
                                                    usuario: data,
                                                    onUpdate: (p0) async {
                                                      if (await AuthService()
                                                          .updateUser(p0!)) {
                                                        showSnackBar(
                                                            context: context,
                                                            title:
                                                                "Error al actualizar la informacion del usuario",
                                                            message:
                                                                "Se presento un problema al intentar actualizar los datos del usuario.",
                                                            type: "danger");
                                                        return;
                                                      }
                                                      showSnackBar(
                                                          context: context,
                                                          title:
                                                              "Usuario actualizado correctamente",
                                                          message:
                                                              "Se actualizo el usuario: ${p0!.username}",
                                                          type: "success");
                                                      ref
                                                          .read(
                                                              changeUsersProvider
                                                                  .notifier)
                                                          .update((state) =>
                                                              UniqueKey()
                                                                  .hashCode);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Iconsax.edit_outline,
                                              opticalSize: 28,
                                              size: 28,
                                            ),
                                          ),
                                          IconButton(
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () {},
                                            icon: const Icon(
                                              CupertinoIcons.delete,
                                              opticalSize: 26,
                                              size: 26,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              // border: TableBorder(
                              //   verticalInside: BorderSide(
                              //     color: Theme.of(context).primaryColorLight,
                              //     width: 2,
                              //   ),
                              // ),
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
