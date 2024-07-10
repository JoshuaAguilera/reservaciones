import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:generador_formato/widgets/text_styles.dart';

class ConfigGeneralView extends StatefulWidget {
  @override
  State<ConfigGeneralView> createState() => _ConfigGeneralViewState();
}

class _ConfigGeneralViewState extends State<ConfigGeneralView> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextStyles.mediumText(
              text: "Estetica", color: DesktopColors.prussianBlue),
          Row(
            children: [
              TextStyles.standardText(text: "Modo Oscuro: "),
              Switch(
                value: active,
                activeColor: Colors.white,
                inactiveTrackColor: Colors.blue[200],
                inactiveThumbColor: Colors.amber,
                activeTrackColor: Colors.black54,
                onChanged: (value) {
                  active = value;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              TextStyles.standardText(text: "Animaciones: "),
              Switch(
                value: active,
                activeColor: DesktopColors.prussianBlue,
                onChanged: (value) {
                  active = value;
                  setState(() {});
                },
              ),
            ],
          ),
          FormWidgets.inputColor(
              color: Colors.amberAccent,
              nameInput: "Tema de Cotizaciones Individuales: "),
          FormWidgets.inputColor(
              color: Colors.blue,
              nameInput: "Tema de Cotizaciones Individuales Preventa: "),
          FormWidgets.inputColor(
              color: Colors.red, nameInput: "Tema de Cotizaciones Grupales: "),
          FormWidgets.inputColor(
              color: Colors.green,
              nameInput: "Tema de Cotizaciones Grupales Preventa: "),
        ],
      ),
    );
  }
}
