import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/change_password_widget.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';

import '../ui/buttons.dart';
import '../utils/helpers/constants.dart';

class Dialogs {
  Widget userFormDialog({
    required BuildContext buildContext,
    UsuarioData? usuario,
    void Function(UsuarioData?)? onInsert,
    void Function(UsuarioData?)? onUpdate,
    required Brightness brightness,
  }) {
    String rol = roles.first;
    bool inProcess = false;

    final _formKeyUsuario = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: usuario != null ? usuario.username : '');
    final TextEditingController mailController = TextEditingController(
        text: usuario != null ? usuario.correoElectronico : '');
    final TextEditingController passwordNewController = TextEditingController();
    final TextEditingController passwordConfirmController =
        TextEditingController();

    final TextEditingController passwordEditController = TextEditingController(
        text: usuario != null
            ? EncrypterTool.decryptData(usuario.password!, null)
            : '');

    final TextEditingController passwordMailEditController =
        TextEditingController(
            text: usuario != null
                ? (usuario.passwordCorreo != null &&
                        usuario.passwordCorreo!.isNotEmpty)
                    ? EncrypterTool.decryptData(usuario.passwordCorreo!, null)
                    : ''
                : '');
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          height: usuario != null ? 470 : 380,
          width: 450,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: brightness == Brightness.light
                                        ? Colors.black87
                                        : Colors.white,
                                    width: 0.5,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(9))),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  CupertinoIcons.person,
                                  size: 32,
                                  color: brightness == Brightness.light
                                      ? Colors.black87
                                      : Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextStyles.titleText(
                                  text: usuario != null
                                      ? "Editar Usuario"
                                      : "Agregar Usuario",
                                  color: Theme.of(buildContext).primaryColor,
                                ),
                                TextStyles.standardText(
                                    text:
                                        "${usuario != null ? "Edita" : "Asigna"} atributos y maneja el acceso del usuario")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                      color: Theme.of(context).primaryColor, thickness: 0.6),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: SizedBox(
                      width: 450,
                      height: usuario != null ? 320 : 232,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKeyUsuario,
                          child: Column(
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
                              if (usuario != null)
                                TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "Correo electrónico",
                                  isRequired: false,
                                  controller: mailController,
                                ),
                              if (usuario != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ChangePasswordWidget(
                                            passwordController:
                                                passwordEditController,
                                            isChanged: (value) {},
                                            userId: usuario.id,
                                            username: usuario.username,
                                            isPasswordMail: false,
                                            notAskChange: passwordEditController
                                                .text.isEmpty,
                                          ),
                                        ),
                                        // const SizedBox(width: 10),
                                        // if (usuario != null &&
                                        //     passwordMailEditController
                                        //         .text.isEmpty)
                                        //   Expanded(
                                        //     child: TextFormFieldCustom
                                        //         .textFormFieldwithBorder(
                                        //       name: "Contraseña de correo",
                                        //       passwordVisible: true,
                                        //       isPassword: true,
                                        //       controller:
                                        //           passwordMailEditController,
                                        //       validator: (p0) {
                                        //         if (p0 == null ||
                                        //             p0.isEmpty ||
                                        //             p0.length < 4) {
                                        //           return "La contraseña debe de tener al menos 4 caracteres*";
                                        //         }
                                        //         return null;
                                        //       },
                                        //     ),
                                        //   )
                                        // else
                                        //   Expanded(
                                        //     child: ChangePasswordWidget(
                                        //       passwordController:
                                        //           passwordMailEditController,
                                        //       isChanged: (value) {},
                                        //       userId: usuario.id,
                                        //       username: usuario.username,
                                        //       isPasswordMail: true,
                                        //       notAskChange:
                                        //           passwordMailEditController
                                        //               .text.isEmpty,
                                        //     ),
                                        //   ),
                                      ]),
                                ),
                              if (usuario == null)
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
                                    ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextStyles.standardText(
                                      text: "Rol del usuario: ",
                                      overClip: true,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 15),
                                  CustomDropdown.dropdownMenuCustom(
                                    initialSelection:
                                        usuario != null ? usuario.rol! : rol,
                                    onSelected: (String? value) {
                                      rol = value!;
                                    },
                                    elements: roles,
                                    screenWidth: 550,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(buildContext);
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: DesktopColors.cerulean),
                          onPressed: () async {
                            if (!_formKeyUsuario.currentState!.validate()) {
                              return;
                            }

                            setState(() => inProcess = true);

                            if (await AuthService()
                                .foundUserName(nameController.text)) {
                              showSnackBar(
                                  context: buildContext,
                                  title: "Nombre no valido",
                                  message:
                                      "Este usuario ya existe, cambie el nombre de usuario",
                                  type: "alert");
                              setState(() => inProcess = false);
                              return;
                            }

                            UsuarioData user = usuario != null
                                ? UsuarioData(
                                    id: usuario.id,
                                    username: nameController.text,
                                    correoElectronico: mailController.text,
                                    passwordCorreo: passwordMailEditController.text.isEmpty ? null : EncrypterTool.encryptData(
                                        passwordMailEditController.text, null),
                                    rol: rol,
                                  )
                                : UsuarioData(
                                    id: 0,
                                    username: nameController.text,
                                    password: EncrypterTool.encryptData(
                                        passwordNewController.text, null),
                                    rol: rol,
                                  );

                            if (onInsert != null) {
                              onInsert.call(user);
                            }

                            if (onUpdate != null) {
                              onUpdate.call(user);
                            }
                            setState(() => inProcess = false);

                            Navigator.of(buildContext).pop();
                          },
                          child: TextStyles.standardText(
                            text: "Guardar",
                            size: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  static Widget customAlertDialog({
    IconData? iconData,
    Color? iconColor,
    Color? colorTextButton,
    required BuildContext context,
    required String title,
    String contentText = '',
    Widget? contentCustom,
    String? contentBold,
    bool otherButton = false,
    bool notCloseInstant = false,
    bool withLoadingProcess = false,
    required String nameButtonMain,
    required VoidCallback funtionMain,
    String nameButtonCancel = "",
    required bool withButtonCancel,
  }) {
    bool loadingProcess = false;

    return StatefulBuilder(builder: (context, snapshot) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Row(children: [
          if (iconData != null)
            Icon(
              iconData,
              size: 33,
              color: iconColor ?? DesktopColors.ceruleanOscure,
            ),
          const SizedBox(width: 10),
          Expanded(
              child: TextStyles.titleText(
                  text: title, size: 18, color: Theme.of(context).primaryColor))
        ]),
        content: contentCustom ??
            TextStyles.TextAsociative(contentBold ?? "", contentText,
                isInverted: contentBold != null,
                color: Theme.of(context).primaryColor),
        actions: [
          if (withButtonCancel)
            Opacity(
              opacity: (withLoadingProcess && loadingProcess) ? 0.4 : 1,
              child: TextButton(
                onPressed: (withLoadingProcess && loadingProcess)
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                child: TextStyles.buttonText(
                  text: nameButtonCancel,
                  color: colorTextButton,
                ),
              ),
            ),
          if (otherButton)
            SizedBox(
              width: 120,
              child: Buttons.commonButton(
                text: "ACEPTAR",
                isLoading: loadingProcess,
                onPressed: () {
                  if (withLoadingProcess) snapshot(() => loadingProcess = true);
                  funtionMain.call();
                  if (!notCloseInstant) Navigator.of(context).pop(true);
                },
              ),
            )
          else
            TextButton(
              onPressed: () {
                funtionMain.call();
                if (!notCloseInstant) Navigator.of(context).pop(true);
              },
              child: TextStyles.buttonText(
                text: nameButtonMain,
                color: colorTextButton,
              ),
            ),
        ],
      );
    });
  }

  static AlertDialog filterDateDialog({
    required BuildContext context,
    required VoidCallback funtionMain,
  }) {
    final TextEditingController _initDateController = TextEditingController(
        text: DateTime.now()
            .subtract(const Duration(days: 30))
            .toIso8601String()
            .substring(0, 10));
    final TextEditingController _endDateController = TextEditingController(
        text: DateTime.now().toIso8601String().substring(0, 10));

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Row(children: [
        Icon(
          Icons.date_range_outlined,
          size: 33,
          color: DesktopColors.ceruleanOscure,
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextStyles.titleText(
          text: "Filtrar por fechas",
          color: Theme.of(context).primaryColor,
          size: 18,
        ))
      ]),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.standardText(
                    text: "Seleccione un periodo de tiempo:",
                    color: Theme.of(context).primaryColor),
                const SizedBox(height: 15),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha inicial",
                  msgError: "",
                  esInvertido: true,
                  dateController: _initDateController,
                  onChanged: () => setState(
                    () => _endDateController.text =
                        Utility.getNextMonth(_initDateController.text),
                  ),
                ),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha final",
                  msgError: "",
                  dateController: _endDateController,
                  fechaLimite: (_initDateController.text),
                )
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            funtionMain.call();
            Navigator.of(context)
                .pop(_initDateController.text + _endDateController.text);
          },
          child: TextStyles.buttonText(
            text: "Aceptar",
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextStyles.buttonText(text: "Cancelar")),
      ],
    );
  }
}
