import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/services/auth_service.dart';
import 'package:generador_formato/res/ui/show_snackbar.dart';
import 'package:generador_formato/utils/encrypt/encrypter.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

import '../../res/ui/buttons.dart';
import '../../res/helpers/desktop_colors.dart';
import '../shared_preferences/settings.dart';
import '../../res/ui/text_styles.dart';
import 'textformfield_custom.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({
    super.key,
    required this.passwordController,
    required this.isChanged,
    required this.userId,
    required this.username,
    required this.isPasswordMail,
    this.notAskChange = false,
    this.onSummitUser,
    this.enable = true,
  });

  final TextEditingController passwordController;
  final void Function(bool value) isChanged;
  final void Function()? onSummitUser;
  final int userId;
  final String username;
  final bool isPasswordMail;
  final bool notAskChange;
  final bool enable;

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  bool canChangedKeyMail = false;
  bool cancelChangedKeyMail = false;
  bool isLoading = false;
  final TextEditingController passwordMailNewController =
      TextEditingController();
  final TextEditingController passwordMailConfirmController =
      TextEditingController();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

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
          enabled: widget.enable,
          isRequired: false,
        ),
      ),
      if (!widget.notAskChange)
        SizedBox(
          height: canChangedKeyMail ? 0 : null,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: !widget.enable
                  ? null
                  : () {
                      widget.isChanged.call(true);
                      setState(() => canChangedKeyMail = true);
                      Future.delayed(Durations.long1,
                          () => setState(() => cancelChangedKeyMail = true));
                    },
              child: TextStyles.buttonText(
                text: "Cambiar contraseña  de correo",
                size: 12,
                color: brightness == Brightness.light
                    ? DesktopColors.cerulean
                    : DesktopColors.azulUltClaro,
              ),
            ),
          ).animate(target: canChangedKeyMail ? 0 : 1).fadeIn(
                delay: !Settings.applyAnimations ? null : 300.ms,
                duration: Settings.applyAnimations ? null : 0.ms,
              ),
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
                    isPassword: true,
                    controller: passwordMailNewController,
                    passwordVisible: true,
                    validator: (p0) {
                      if (p0 == null || p0!.isEmpty || p0.length < 4) {
                        return "La contraseña debe de tener al menos 4 caracteres*";
                      }
                      return null;
                    },
                  ),
                  TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Confirmar Contraseña",
                    isPassword: true,
                    passwordVisible: true,
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
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          widget.isChanged.call(false);
                          setState(() => cancelChangedKeyMail = false);
                          Future.delayed(Durations.long1,
                              () => setState(() => canChangedKeyMail = false));
                          passwordMailConfirmController.text = "";
                          passwordMailNewController.text = "";
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
                Buttons.commonButton(
                  text: "Guardar",
                  sizeText: 12.5,
                  isLoading: isLoading,
                  onPressed: () async {
                    if (!_formKeyPassword.currentState!.validate()) {
                      return;
                    }

                    setState(() => isLoading = true);

                    if (widget.isPasswordMail) {
                      if (await AuthService().updatePasswordMail(
                          widget.userId,
                          widget.username,
                          EncrypterTool.encryptData(
                              passwordMailConfirmController.text, null))) {
                        showSnackBar(
                          context: context,
                          title: "Error de actualización",
                          message:
                              "No se proceso el cambio de contraseña de correo correctamente",
                          type: 'danger',
                        );
                        return;
                      }

                      Preferences.passwordMail = EncrypterTool.encryptData(
                          passwordMailConfirmController.text, null);
                    } else {
                      if (await AuthService().updatePasswordUser(
                          widget.userId,
                          widget.username,
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

                      if (widget.onSummitUser != null) {
                        widget.onSummitUser!.call();
                      } else {
                        Preferences.password = EncrypterTool.encryptData(
                            passwordMailConfirmController.text, null);
                      }
                    }

                    setState(() => isLoading = false);

                    showSnackBar(
                      context: context,
                      title: "Contraseña actualizada",
                      message: "Se actualizó la contraseña correctamente.",
                      type: 'success',
                    );

                    widget.passwordController.text =
                        passwordMailConfirmController.text;
                    passwordMailConfirmController.text = "";
                    passwordMailNewController.text = "";

                    widget.isChanged.call(false);
                    setState(() => cancelChangedKeyMail = false);

                    Future.delayed(
                      Durations.long1,
                      () {
                        if (!mounted) return;
                        setState(() => canChangedKeyMail = false);
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ).animate(target: cancelChangedKeyMail ? 1 : 0).fadeIn(
              duration: Settings.applyAnimations ? 500.ms : 0.ms,
            ),
      ),
    ]);
  }
}
