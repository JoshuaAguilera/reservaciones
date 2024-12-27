import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/views/usuarios/edit_user_dialog.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sidebarx/sidebarx.dart';

import '../services/auth_service.dart';
import '../ui/custom_widgets.dart';
import '../ui/show_snackbar.dart';
import '../utils/encrypt/encrypter.dart';
import '../utils/helpers/utility.dart';
import 'dialogs.dart';
import 'text_styles.dart';
import 'textformfield_custom.dart';

class UsuarioItemRow extends StatefulWidget {
  const UsuarioItemRow({
    super.key,
    this.onUpdateList,
    this.isTable = false,
    required this.usuario,
    required this.sideController,
    required this.index,
  });

  final void Function()? onUpdateList;
  final bool isTable;
  final UsuarioData usuario;
  final SidebarXController sideController;
  final int index;

  @override
  State<UsuarioItemRow> createState() => _UsuarioItemRowState();
}

class _UsuarioItemRowState extends State<UsuarioItemRow> {
  bool selected = false;

  void showUpdateDialog(UsuarioData user, Brightness brightness) {
    showDialog(
      context: context,
      builder: (contextBL) {
        return EditUserDialog(
          usuario: user,
          onUpdateList: () {
            if (widget.onUpdateList != null) widget.onUpdateList!.call();
          },
          onUpdate: (p0) async {
            if (await AuthService().updateUser(p0!)) {
              showSnackBar(
                  context: context,
                  title: "Error al actualizar la informacion del usuario",
                  message:
                      "Se presento un problema al intentar actualizar los datos del usuario.",
                  type: "danger");
              return;
            }
            showSnackBar(
                context: context,
                title: "Usuario actualizado correctamente",
                message: "Se actualizo el usuario: ${p0.username}",
                type: "success");

            if (widget.onUpdateList != null) widget.onUpdateList!.call();
          },
        );
      },
    );
  }

  void showDeleteDialog(UsuarioData user) {
    showDialog(
      context: context,
      builder: (context) => Dialogs.customAlertDialog(
        context: context,
        title: "Eliminar tarifa",
        contentText: "¿Desea eliminar el siguiente usuario: ${user.username}?",
        nameButtonMain: "Aceptar",
        nameButtonCancel: "Cancelar",
        withButtonCancel: true,
        notCloseInstant: true,
        withLoadingProcess: true,
        otherButton: true,
        iconData: Icons.delete,
        funtionMain: () async {
          bool isDeleted = await AuthService().deleteUser(user);

          if (isDeleted) {
            showSnackBar(
              context: context,
              title: "Usuario ${user.username} Eliminado",
              message: "El usuario fue eliminado exitosamente.",
              type: "success",
              iconCustom: Icons.delete,
            );

            if (widget.onUpdateList != null) {
              widget.onUpdateList!.call();
            }
          } else {
            showSnackBar(
              context: context,
              title: "Error al eliminar usuario ${user.username}",
              message:
                  "El usuario no fue eliminado debido a un error inesperado.",
              type: "danger",
              iconCustom: Icons.delete,
            );
          }

          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Container(
      child: !widget.isTable
          ? selected
              ? _ListTileUser(
                  usuario: widget.usuario,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  sideController: widget.sideController,
                )
              : _ListTileUser(
                  usuario: widget.usuario,
                  onPressedDelete: () => showDeleteDialog(widget.usuario),
                  onPressedEdit: () =>
                      showUpdateDialog(widget.usuario, brightness),
                  sideController: widget.sideController,
                )
          : selected
              ? _TableRowUser(
                  usuario: widget.usuario,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  sideController: widget.sideController,
                )
              : _TableRowUser(
                  usuario: widget.usuario,
                  onPressedDelete: () => showDeleteDialog(widget.usuario),
                  onPressedEdit: () =>
                      showUpdateDialog(widget.usuario, brightness),
                  sideController: widget.sideController,
                ),
    ).animate().slideY().fadeIn(
        begin: -0.2, delay: Duration(milliseconds: 200 + (35 * widget.index)));
  }
}

class _TableRowUser extends ConsumerStatefulWidget {
  final UsuarioData usuario;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final SidebarXController sideController;

  const _TableRowUser({
    super.key,
    required this.usuario,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.sideController,
  });

  @override
  _TableRowCotizacionState createState() => _TableRowCotizacionState();
}

class _TableRowCotizacionState extends ConsumerState<_TableRowUser> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Card(
      elevation: 4,
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
                text: widget.usuario.id.toString(),
                aling: TextAlign.center,
                color: Theme.of(context).primaryColor,
                overClip: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CustomWidgets.itemMedal(widget.usuario.rol!, brightness),
              ),
              TextStyles.standardText(
                text: widget.usuario.username ?? '',
                aling: TextAlign.center,
                color: Theme.of(context).primaryColor,
                overClip: true,
              ),
              if (screenWidth > 1100)
                TextStyles.standardText(
                  text: widget.usuario.correoElectronico?.isNotEmpty == true
                      ? widget.usuario.correoElectronico!
                      : '-',
                  aling: TextAlign.center,
                  color: Theme.of(context).primaryColor,
                  overClip: true,
                ),
              if (screenWidth > 1300)
                TextStyles.standardText(
                  text: widget.usuario.telefono?.isNotEmpty == true
                      ? widget.usuario.telefono!
                      : '-',
                  aling: TextAlign.center,
                  color: Theme.of(context).primaryColor,
                  overClip: true,
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 7, 8, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 47,
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    msgError: "",
                    isPassword: true,
                    passwordVisible: true,
                    name: "",
                    initialValue: EncrypterTool.decryptData(
                        widget.usuario.password ?? '', null),
                    readOnly: true,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Iconsax.edit_outline,
                        opticalSize: 28,
                        size: 28,
                      ),
                      tooltip: "Editar",
                      onPressed: () => widget.onPressedEdit!.call(),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        CupertinoIcons.delete,
                        opticalSize: 26,
                        size: 26,
                      ),
                      tooltip: "Eliminar",
                      onPressed: () => widget.onPressedDelete!.call(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      ),
    );
  }
}

class _ListTileUser extends ConsumerStatefulWidget {
  final UsuarioData usuario;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final SidebarXController sideController;

  const _ListTileUser({
    super.key,
    required this.usuario,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.sideController,
  });

  @override
  _ListTileCotizacionState createState() => _ListTileCotizacionState();
}

class _ListTileCotizacionState extends ConsumerState<_ListTileUser> {
  @override
  Widget build(BuildContext context) {
    Color? colorText = Theme.of(context).primaryColor;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 50);
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Card(
      elevation: 5,
      child: ListTile(
        leading: TextStyles.TextSpecial(
          day: widget.usuario.id,
          colorTitle: colorText,
          colorsubTitle: colorText,
          subtitle: "ID",
          sizeSubtitle: 12,
        ),
        visualDensity: VisualDensity.standard,
        title: TextStyles.titleText(
          text: widget.usuario.username ?? '',
          color: colorText,
          size: 14,
        ),
        subtitle: Opacity(
          opacity: 0.8,
          child: Wrap(
            spacing: 16,
            runSpacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 260,
                child: Row(
                  children: [
                    TextStyles.standardText(
                      text: (screenWidthWithSideBar < 1100)
                          ? "Rol:   "
                          : "Rol de usuario:   ",
                      color: colorText,
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Utility.getColorTypeUser(widget.usuario.rol!,
                            alpha: 100),
                        border: Border.all(
                          color: Utility.getColorTypeUser(widget.usuario.rol!)!,
                          width: 1.5,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextStyles.standardText(
                          text: widget.usuario.rol!,
                          aling: TextAlign.center,
                          color: Utility.darken(
                              Utility.getColorTypeUser(widget.usuario.rol!)!,
                              brightness == Brightness.light ? 0.1 : -0.1),
                          overClip: true,
                          isBold: true,
                        ),
                      ),
                    ).animate(
                      onPlay: (controller) => controller.repeat(),
                      effects: [
                        if (widget.usuario.rol == "SUPERADMIN" ||
                            widget.usuario.rol == "ADMIN")
                          ShimmerEffect(
                            delay: 2.5.seconds,
                            duration: 750.ms,
                            color: Colors.white,
                          ),
                      ],
                    )
                  ],
                ),
              ),
              TextStyles.TextAsociative(
                (screenWidthWithSideBar < 1100)
                    ? "Nombre: "
                    : "Nombre Completo: ",
                "${widget.usuario.nombre ?? ''} ${widget.usuario.apellido ?? '-'}",
                color: colorText,
              ),
              TextStyles.TextAsociative(
                (screenWidthWithSideBar < 1100)
                    ? "Correo: "
                    : "Correo electronico: ",
                widget.usuario.correoElectronico ?? '-',
                color: colorText,
              ),
              TextStyles.TextAsociative(
                (screenWidthWithSideBar < 1100)
                    ? "Número: "
                    : "Número telefonico: ",
                widget.usuario.telefono ?? '-',
                color: colorText,
              ),
            ],
          ),
        ),
        trailing: optionsListTile(Theme.of(context).primaryColor),
        isThreeLine: true,
      ),
    );
  }

  Widget optionsListTile(Color? colorIcon) {
    return Wrap(
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: SizedBox(
            width: 160,
            height: 47,
            child: TextFormFieldCustom.textFormFieldwithBorder(
              msgError: "",
              isPassword: true,
              passwordVisible: true,
              name: "Contraseña",
              initialValue: EncrypterTool.decryptData(
                  widget.usuario.password ?? '', null),
              readOnly: true,
            ),
          ),
        ),
        SizedBox(
          height: 35,
          width: 40,
          child: CustomWidgets.compactOptions(
            context,
            onPreseedDelete: widget.onPressedDelete,
            onPreseedEdit: widget.onPressedEdit,
            colorIcon: colorIcon,
          ),
        ),
      ],
    );
  }
}
