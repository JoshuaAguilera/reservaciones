import 'package:flutter/material.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/container_section.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/shared_preferences/settings.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:icons_plus/icons_plus.dart';

class ConfigSMTPView extends StatefulWidget {
  const ConfigSMTPView({Key? key}) : super(key: key);

  @override
  State<ConfigSMTPView> createState() => _ConfigSMTPViewState();
}

class _ConfigSMTPViewState extends State<ConfigSMTPView> {
  String mailServer = "";
  String portSMTP = "";
  bool applySSL = false;
  bool ignoreBadCertificate = false;
  bool isSaving = false;

  @override
  void initState() {
    mailServer = Settings.mailServer;
    portSMTP = Settings.portSMTP.toString();
    applySSL = Settings.applySSL;
    ignoreBadCertificate = Settings.ignoreBadCertificate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isSaving,
      child: Opacity(
        opacity: isSaving ? 0.5 : 1,
        child: ContainerSection(
          title: "Configuracion del Servidor SMTP",
          icons: Iconsax.send_2_outline,
          children: [
            _compactField(
              title: "Servidor de correo:",
              label: "mail.server.com",
              value: mailServer,
            ),
            _compactField(
              title: "Puerto SMTP:",
              value: portSMTP,
            ),
            FormWidgets.inputSwitch(
              value: applySSL,
              onChanged: (p0) {
                applySSL = p0;
                setState(() {});
              },
              context: context,
              name: "SSL:",
              activeColor: DesktopColors.notSuccess,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: FormWidgets.inputSwitch(
                value: ignoreBadCertificate,
                onChanged: (p0) {
                  ignoreBadCertificate = p0;
                  setState(() {});
                },
                context: context,
                name: "Ignorar certificado incorrecto:",
                activeColor: DesktopColors.notDanger,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: SizedBox(
                  width: 150,
                  height: 32,
                  child: Buttons.commonButton(
                    text: "Guardar",
                    onPressed: () {
                      isSaving = true;
                      setState(() {});

                      Settings.mailServer = mailServer;
                      Settings.portSMTP = int.tryParse(portSMTP) ?? 0;
                      Settings.applySSL = applySSL;
                      Settings.ignoreBadCertificate = ignoreBadCertificate;

                      isSaving = false;
                      setState(() {});

                      showSnackBar(
                        context: context,
                        title: "Configuración guardada",
                        message:
                            "La configuracion del Servidor SMTP se guardo exitosamente.",
                        type: "success",
                        iconCustom: Icons.save,
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _compactField(
      {required String title,
      String label = '',
      required String value,
      bool isNumeric = false}) {
    return SizedBox(
      width: 375,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 15,
        children: [
          TextStyles.standardText(text: title),
          SizedBox(
            width: 220,
            child: FormWidgets.textFormFieldResizable(
              name: label,
              isNumeric: isNumeric,
              initialValue: value,
              onChanged: (p0) {
                setState(() => value = p0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
