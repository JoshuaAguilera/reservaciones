import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:generador_formato/res/ui/section_container.dart';
import 'package:generador_formato/res/ui/show_snackbar.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/shared_preferences/settings.dart';
import 'package:generador_formato/utils/widgets/form_widgets.dart';
import 'package:generador_formato/res/ui/text_styles.dart';

import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/general_helpers.dart';

class ConfigSMTPView extends StatefulWidget {
  const ConfigSMTPView({super.key});
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
    return AnimatedEntry(
      child: SectionContainer(
        padH: 18,
        spacingHeader: 20,
        title: "Configuracion del Servidor SMTP",
        isModule: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            name: "Activar SSL (Secure Sockets Layer):",
            activeColor: DesktopColors.notSuccess,
          ),
          FormWidgets.inputSwitch(
            value: ignoreBadCertificate,
            onChanged: (p0) {
              ignoreBadCertificate = p0;
              setState(() {});
            },
            context: context,
            name: "Ignorar certificado incorrecto:",
            activeColor: DesktopColors.notDanger,
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: SizedBox(
              width: GeneralHelpers.clampSize(250.w, min: 80, max: 150),
              child: Buttons.buttonPrimary(
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
        ],
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
          AppText.simpleText(text: title),
          SizedBox(
            width: 220,
            height: 40,
            child: FormWidgets.textFormField(
              name: label,
              fillColor: Theme.of(context).cardColor,
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
