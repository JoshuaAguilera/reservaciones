import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

import '../ui/buttons.dart';
import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';
import 'textformfield_custom.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({
    super.key,
    required this.passwordController,
    required this.isChanged,
    required this.userId,
    required this.isPasswordMail,
    this.notAskChange = false,
  });

  final TextEditingController passwordController;
  final void Function(bool value) isChanged;
  final int userId;
  final bool isPasswordMail;
  final bool notAskChange;

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  bool canChangedKeyMail = false;
  bool cancelChangedKeyMail = false;
  final TextEditingController passwordMailNewController =
      TextEditingController();
  final TextEditingController passwordMailConfirmController =
      TextEditingController();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: TextFormFieldCustom.textFormFieldwithBorder(
          isPassword: true,
          passwordVisible: true,
          name: widget.isPasswordMail
              ? "Contraseña de correo"
              : "Contraseña de cuenta",
          controller: widget.passwordController,
          readOnly: true,
        ),
      ),
      if(!widget.notAskChange)
      SizedBox(
        height: canChangedKeyMail ? 0 : null,
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              widget.isChanged.call(true);
              setState(() => canChangedKeyMail = true);
              Future.delayed(Durations.long1,
                  () => setState(() => cancelChangedKeyMail = true));
            },
            child: TextStyles.buttonText(
                text: "Cambiar contraseña  de correo", size: 12),
          ),
        ).animate(target: canChangedKeyMail ? 0 : 1).fadeIn(delay: 300.ms),
      ),
      SizedBox(
        height: cancelChangedKeyMail ? null : 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextStyles.standardText(
                text: "Modificación de contraseña",
                color: Theme.of(context).primaryColor,
                size: 11,
              ),
            ),
            Form(
              key: _formKeyPassword,
              child: Wrap(
                children: [
                  TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Nueva Contraseña",
                    controller: passwordMailNewController,
                    validator: (p0) {
                      if (p0 == null || p0!.isEmpty || p0.length < 4) {
                        return "La contraseña debe de tener al menos 4 caracteres*";
                      }
                      return null;
                    },
                  ),
                  TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Confirmar Contraseña",
                    controller: passwordMailConfirmController,
                    validator: (p0) {
                      if (passwordMailNewController.text.length > 0) {
                        if (p0 == null ||
                            p0!.isEmpty ||
                            p0 != passwordMailNewController.text) {
                          return "La contraseña debe ser la misma*";
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Buttons.commonButton(
                    onPressed: () {
                      widget.isChanged.call(false);
                      setState(() => cancelChangedKeyMail = false);
                      Future.delayed(Durations.long1,
                          () => setState(() => canChangedKeyMail = false));
                      passwordMailConfirmController.text = "";
                      passwordMailNewController.text = "";
                    },
                    color: DesktopColors.mentaOscure,
                    text: "Cancelar"),
                Buttons.commonButton(
                    onPressed: () async {
                      if (!_formKeyPassword.currentState!.validate()) {
                        return;
                      }

                      if (widget.isPasswordMail) {
                        if (await AuthService().updatePasswordMail(
                            widget.userId,
                            EncrypterTool.encryptData(
                                passwordMailConfirmController.text, null))) {
                          showSnackBar(
                              context: context,
                              title: "Error de actualización",
                              message:
                                  "No se proceso el cambio de contraseña de correo correctamente",
                              type: 'danger');
                          return;
                        }

                        Preferences.passwordMail = EncrypterTool.encryptData(
                            passwordMailConfirmController.text, null);
                      } else {
                        if (await AuthService().updatePasswordUser(
                            widget.userId,
                            EncrypterTool.encryptData(
                                passwordMailConfirmController.text, null))) {
                          showSnackBar(
                              context: context,
                              title: "Error de actualización",
                              message:
                                  "No se proceso el cambio de contraseña correctamente",
                              type: 'danger');
                          return;
                        }

                        Preferences.password = EncrypterTool.encryptData(
                            passwordMailConfirmController.text, null);
                      }

                      showSnackBar(
                          context: context,
                          title: "Contraseña actualizada",
                          message: "Se actualizó la contraseña correctamente.",
                          type: 'success');

                      widget.passwordController.text =
                          passwordMailConfirmController.text;
                      passwordMailConfirmController.text = "";
                      passwordMailNewController.text = "";

                      widget.isChanged.call(false);
                      setState(() => cancelChangedKeyMail = false);
                      Future.delayed(Durations.long1,
                          () => setState(() => canChangedKeyMail = false));
                    },
                    text: "Guardar"),
              ],
            )
          ],
        )
            .animate(target: cancelChangedKeyMail ? 1 : 0)
            .fadeIn(duration: 500.ms),
      ),
    ]);
  }
}
