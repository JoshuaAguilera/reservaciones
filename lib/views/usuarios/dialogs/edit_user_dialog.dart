import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../database/database.dart';
import '../../../services/auth_service.dart';
import '../../../ui/buttons.dart';
import '../../../ui/custom_widgets.dart';
import '../../../ui/inside_snackbar.dart';
import '../../../utils/encrypt/encrypter.dart';
import '../../../utils/helpers/constants.dart';
import '../../../utils/helpers/desktop_colors.dart';
import '../../../widgets/change_password_widget.dart';
import '../../../widgets/text_styles.dart';
import '../../../widgets/textformfield_custom.dart';

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({
    Key? key,
    this.usuario,
    this.onInsert,
    this.onUpdate,
    this.onUpdateList,
  }) : super(key: key);

  final UsuarioData? usuario;
  final void Function(UsuarioData?)? onInsert;
  final void Function(UsuarioData?)? onUpdate;
  final void Function()? onUpdateList;

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  String rol = roles[2];
  bool inProcess = false;
  bool showError = false;
  bool showConfigPassword = false;
  String messageError = '';

  final _formKeyUsuario = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordNewController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController passwordEditController = TextEditingController();

  @override
  void initState() {
    rol = widget.usuario?.rol ?? roles[2];
    nameController =
        TextEditingController(text: widget.usuario?.username ?? '');
    mailController =
        TextEditingController(text: widget.usuario?.correoElectronico ?? '');
    numberController =
        TextEditingController(text: widget.usuario?.telefono ?? '');
    passwordEditController = TextEditingController(
        text: widget.usuario != null
            ? EncrypterTool.decryptData(widget.usuario?.password ?? '', null)
            : '');

    super.initState();
  }

  bool detectChanges() {
    bool isDetect = false;
    String oldPassword = (widget.usuario != null
        ? EncrypterTool.decryptData(widget.usuario?.password ?? '', null)
        : '');

    if (widget.usuario?.username != nameController.text) isDetect = true;
    if (widget.usuario?.rol != rol) isDetect = true;
    if ((widget.usuario?.correoElectronico ?? '') != mailController.text) {
      isDetect = true;
    }
    if ((widget.usuario?.telefono ?? '') != numberController.text) {
      isDetect = true;
    }
    if (oldPassword != passwordEditController.text) isDetect = true;

    return isDetect;
  }

  Future<void> saveFunction(BuildContext context, dynamic setState,
      [bool forceUpdate = false]) async {
    if (!_formKeyUsuario.currentState!.validate()) return;

    if (!detectChanges()) {
      if (forceUpdate) {
        if (widget.onUpdateList != null) widget.onUpdateList!.call();
      }
      Navigator.of(context).pop();
      return;
    }

    setState(() => inProcess = true);

    if (await AuthService()
        .foundUserName(nameController.text, widget.usuario?.id)) {
      messageError =
          "Nombre no valido. Este usuario ya existe, cambie el nombre de usuario";
      nameController =
          TextEditingController(text: widget.usuario?.username ?? '');

      showError = true;
      inProcess = false;
      setState(() {});

      Future.delayed(4.seconds, () {
        if (!context.mounted) return;
        setState(() => showError = false);
      });
      return;
    }

    UsuarioData user = widget.usuario != null
        ? UsuarioData(
            id: widget.usuario!.id,
            username: nameController.text,
            correoElectronico: mailController.text,
            telefono: numberController.text,
            rol: rol,
          )
        : UsuarioData(
            id: 0,
            username: nameController.text,
            password:
                EncrypterTool.encryptData(passwordNewController.text, null),
            rol: rol,
          );

    if (widget.onInsert != null) {
      widget.onInsert!.call(user);
    }

    if (widget.onUpdate != null) {
      widget.onUpdate!.call(user);
    }
    setState(() => inProcess = false);

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: widget.usuario != null
            ? showConfigPassword
                ? 565
                : 470
            : 390,
        width: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitlePage(
                      icons: CupertinoIcons.person,
                      isDialog: true,
                      title: widget.usuario != null
                          ? "Editar Usuario"
                          : "Agregar Usuario",
                      subtitle:
                          "${widget.usuario != null ? "Edita" : "Asigna"} atributos y maneja el acceso del usuario",
                    ),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 0.6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: SizedBox(
                        width: 450,
                        height: widget.usuario != null ? null : 232,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKeyUsuario,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "Nombre de usuario",
                                  controller: nameController,
                                  validator: (value) {
                                    if ((value == null || value.isEmpty)) {
                                      return "Campo requirido*";
                                    }

                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextStyles.standardText(
                                          text: "Rol del usuario: ",
                                          overClip: true,
                                          color:
                                              Theme.of(context).primaryColor),
                                      const SizedBox(width: 15),
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        child: DropdownButton<String>(
                                          underline: const SizedBox(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          icon: const Icon(
                                              HeroIcons.square_3_stack_3d),
                                          isExpanded: true,
                                          value: widget.usuario?.rol ?? rol,
                                          items: [
                                            for (var item in roles)
                                              DropdownMenuItem(
                                                value: item,
                                                child: CustomWidgets.itemMedal(
                                                    item, brightness),
                                              ),
                                          ],
                                          onChanged: (value) =>
                                              setState(() => rol = value!),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (widget.usuario != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormFieldCustom
                                              .textFormFieldwithBorder(
                                            name: "Correo electrónico",
                                            isRequired: false,
                                            controller: mailController,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormFieldCustom
                                              .textFormFieldwithBorder(
                                            name: "Numero de contacto",
                                            isRequired: false,
                                            controller: numberController,
                                            isNumeric: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (widget.usuario != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ChangePasswordWidget(
                                            passwordController:
                                                passwordEditController,
                                            isChanged: (value) => setState(() =>
                                                showConfigPassword = value),
                                            userId: widget.usuario!.id,
                                            username:
                                                widget.usuario?.username ?? '',
                                            isPasswordMail: false,
                                            notAskChange: passwordEditController
                                                .text.isEmpty,
                                            onSummitUser: () => saveFunction(
                                                context, setState, true),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (widget.usuario == null)
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Contraseña",
                                          passwordVisible: true,
                                          isPassword: true,
                                          controller: passwordNewController,
                                          validator: (p0) {
                                            if (p0 == null ||
                                                p0.isEmpty ||
                                                p0.length < 4) {
                                              return "La contraseña debe de tener al menos 4 caracteres*";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormFieldCustom
                                            .textFormFieldwithBorder(
                                          name: "Confirmar contraseña",
                                          isPassword: true,
                                          passwordVisible: true,
                                          controller: passwordConfirmController,
                                          validator: (p0) {
                                            if (passwordNewController
                                                .text.isNotEmpty) {
                                              if (p0 == null ||
                                                  p0.isEmpty ||
                                                  p0 !=
                                                      passwordNewController
                                                          .text) {
                                                return "La contraseña debe ser la misma*";
                                              }
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                if (showError)
                                  insideSnackBar(
                                    message: messageError,
                                    type: 'danger',
                                    duration: 3.seconds,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!showConfigPassword)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: TextStyles.standardText(
                        text: "Cancelar",
                        isBold: true,
                        size: 12.5,
                        color: brightness == Brightness.light
                            ? DesktopColors.cerulean
                            : DesktopColors.azulUltClaro,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Buttons.commonButton(
                      text: "Guardar",
                      isLoading: inProcess,
                      sizeText: 12.5,
                      onPressed: () => saveFunction(context, setState),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
