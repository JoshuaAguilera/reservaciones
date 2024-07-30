import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'text_styles.dart';
import 'textformfield_custom.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  bool canChangedKeyMail = false;
  bool cancelChangedKeyMail = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: canChangedKeyMail ? 0 : null,
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
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
            /*
            Wrap(
              children: [
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Nueva Contraseña",
                  controller: passwordMailNewController,
                ),
                TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Confirmar Contraseña",
                  controller: passwordMailConfirmController,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Buttons.commonButton(
                    onPressed: () {
                      setState(() => cancelChangedKeyMail = false);
                      Future.delayed(Durations.long1,
                          () => setState(() => canChangedKeyMail = false));
                    },
                    color: DesktopColors.mentaOscure,
                    text: "Cancelar"),
                Buttons.commonButton(onPressed: () {}, text: "Guardar")
              ],
            )
            */
          ],
        )
            .animate(target: cancelChangedKeyMail ? 1 : 0)
            .fadeIn(duration: 500.ms),
      ),
    ]);
  }
}
