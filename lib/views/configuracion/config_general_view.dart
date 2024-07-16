import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import '../../widgets/form_widgets.dart';

class ConfigGeneralView extends StatefulWidget {
  @override
  State<ConfigGeneralView> createState() => _ConfigGeneralViewState();
}

class _ConfigGeneralViewState extends State<ConfigGeneralView> {
  bool activeModeDark = false;
  bool activeAnimations = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextStyles.mediumText(
            //     text: "Estetica", color: DesktopColors.prussianBlue),
            FormWidgets.inputSwitch(
                value: activeModeDark,
                isModeDark: true,
                name: "Modo Oscuro: ",
                onChanged: (value) {
                  activeModeDark = value;
                  setState(() {});
                }),
            FormWidgets.inputSwitch(
                value: activeAnimations,
                activeColor: DesktopColors.prussianBlue,
                name: "Animaciones: ",
                onChanged: (value) {
                  activeAnimations = value;
                  setState(() {});
                }),
            // FormWidgets.inputColor(
            //     color: Colors.amberAccent,
            //     nameInput: "Tema de Cotizaciones Individuales: "),
            // FormWidgets.inputColor(
            //     color: Colors.blue,
            //     nameInput: "Tema de Cotizaciones Individuales Preventa: "),
            // FormWidgets.inputColor(
            //     color: Colors.red, nameInput: "Tema de Cotizaciones Grupales: "),
            // FormWidgets.inputColor(
            //     color: Colors.green,
            //     nameInput: "Tema de Cotizaciones Grupales Preventa: "),
          ],
        ),
      ),
    );
  }
}
