import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuple/tuple.dart';

import '../../models/usuario_model.dart';
import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/functions_ui.dart';
import '../../res/ui/buttons.dart';
import '../../view-models/providers/usuario_provider.dart';
import '../shared_preferences/settings.dart';
import '../../res/ui/text_styles.dart';
import 'form_widgets.dart';

class PasswordManager extends ConsumerStatefulWidget {
  const PasswordManager({
    super.key,
    this.notAskChange = false,
    this.onSummitUser,
    this.enable = true,
    this.formKey,
    this.user,
    this.onInput,
  });

  final void Function()? onSummitUser;
  final bool notAskChange;
  final bool enable;
  final GlobalKey<FormState>? formKey;
  final Usuario? user;
  final ValueChanged<bool>? onInput;

  @override
  ConsumerState<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends ConsumerState<PasswordManager> {
  bool canChangedKey = false;
  bool cancelChangedKey = false;
  bool isLoading = false;
  final TextEditingController passwordMailNewController =
      TextEditingController();
  final TextEditingController passwordMailConfirmController =
      TextEditingController();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.notAskChange) cancelChangedKey = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider = ref.watch(passwordContProvider);

    return Column(
      children: [
        if (!widget.notAskChange)
          AnimatedEntry(
            child: SizedBox(
              height: canChangedKey ? 0 : null,
              child: Buttons.buttonSecundary(
                icon: Iconsax.key_outline,
                text: "Cambiar contraseña",
                onPressed: !widget.enable
                    ? null
                    : () {
                        if (widget.onInput != null) {
                          widget.onInput!.call(canChangedKey);
                        }
                        setState(() => canChangedKey = true);
                        Future.delayed(Durations.long1,
                            () => setState(() => cancelChangedKey = true));
                      },
              ).animate(target: canChangedKey ? 0 : 1).fadeIn(
                    delay: !Settings.applyAnimations ? null : 300.ms,
                    duration: Settings.applyAnimations ? null : 0.ms,
                  ),
            ),
          ),
        SizedBox(
          height: cancelChangedKey ? null : 0,
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextStyles.standardText(
                  text:
                      "${(widget.notAskChange) ? "Establecer" : "Modificación de"} contraseña",
                  size: 13.5,
                ),
              ),
              Form(
                key: widget.formKey ?? _formKeyPassword,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FormWidgets.textFormField(
                      name: "Nueva Contraseña",
                      isPassword: true,
                      controller: passwordMailNewController,
                      passwordVisible: true,
                      colorBorder: Colors.black87,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty || p0.length < 4) {
                          return "La contraseña debe de tener al menos 4 caracteres*";
                        }
                        return null;
                      },
                    ),
                    FormWidgets.textFormField(
                      name: "Confirmar Contraseña",
                      isPassword: true,
                      passwordVisible: true,
                      controller: widget.notAskChange
                          ? passwordProvider
                          : passwordMailConfirmController,
                      colorBorder: Colors.black87,
                      validator: (p0) {
                        if (passwordMailNewController.text.isNotEmpty) {
                          if (p0 == null ||
                              p0.isEmpty ||
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
              const SizedBox(height: 2),
              if (!widget.notAskChange)
                SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Buttons.buttonSecundary(
                        text: "Cancelar",
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() => cancelChangedKey = false);
                                Future.delayed(Durations.long1, () {
                                  if (widget.onInput != null) {
                                    widget.onInput!.call(canChangedKey);
                                  }
                                  setState(() => canChangedKey = false);
                                });
                                passwordMailConfirmController.text = "";
                                passwordMailNewController.text = "";
                              },
                      ),
                      Buttons.buttonPrimary(
                        text: "Guardar",
                        padVer: 0,
                        isLoading: isLoading,
                        onPressed: () async {
                          if (!_formKeyPassword.currentState!.validate())
                            return;
                          applyUnfocus();
                          setState(() => isLoading = true);

                          if (widget.user != null) {
                            Usuario workUser = Usuario(id: widget.user?.id);
                            workUser.password =
                                passwordMailConfirmController.text;

                            ref
                                .read(usuarioProvider.notifier)
                                .update((state) => workUser);

                            Tuple2<bool, Usuario?> responseUser =
                                await ref.read(saveUserProvider.future);

                            if (responseUser.item1) {
                              isLoading = false;
                              setState(() {});
                              return;
                            }

                            ref
                                .read(usuarioProvider.notifier)
                                .update((state) => null);
                          }
                          setState(() => isLoading = false);

                          ref
                              .read(passwordContProvider.notifier)
                              .update((state) => TextEditingController());
                          passwordMailConfirmController.text = "";
                          passwordMailNewController.text = "";

                          setState(() => cancelChangedKey = false);

                          Future.delayed(
                            Durations.long1,
                            () {
                              if (!mounted) return;
                              setState(() => canChangedKey = false);
                              if (widget.onInput != null) {
                                widget.onInput!.call(true);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ).animate(target: cancelChangedKey ? 1 : 0).fadeIn(
                duration: (!widget.notAskChange && Settings.applyAnimations)
                    ? 500.ms
                    : 0.ms,
              ),
        ),
      ],
    );
  }
}
