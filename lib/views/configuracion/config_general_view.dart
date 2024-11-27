import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import '../../ui/themes.dart';
import '../../widgets/form_widgets.dart';

class ConfigGeneralView extends StatefulWidget {
  @override
  State<ConfigGeneralView> createState() => _ConfigGeneralViewState();
}

class _ConfigGeneralViewState extends State<ConfigGeneralView> {
  bool activeModeDark = false;
  bool activeAnimations = false;
  bool modificMode = false;
  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitcher(
              clipper: const ThemeSwitcherCircleClipper(),
              builder: (context) {
                return AbsorbPointer(
                  absorbing: modificMode,
                  child: GestureDetector(
                    onTapDown: (details) {
                      modificMode = true;
                      setState(() {});
                      ThemeSwitcher.of(context).changeTheme(
                        theme: brightness == Brightness.light
                            ? Themes().darkMode()
                            : Themes().lightMode(),
                        offset: details.localPosition,
                        isReversed:
                            brightness == Brightness.dark ? true : false,
                      );
                      Preferences.modeDark = !Preferences.modeDark;
                      setState(() {});

                      Future.delayed(400.ms, () {
                        modificMode = false;
                        setState(() {});
                      });
                    },
                    child: FormWidgets.inputSwitch(
                      value: Preferences.modeDark,
                      activeColor: Colors.white,
                      isModeDark: true,
                      name: "Modo Oscuro: ",
                      context: context,
                    ),
                  ),
                );
              },
            ),
            // FormWidgets.inputSwitch(
            //   value: activeAnimations,
            //   activeColor: DesktopColors.prussianBlue,
            //   name: "Animaciones: ",
            //   onChanged: (value) {
            //     activeAnimations = value;
            //     setState(() {});
            //   },
            //   context: context,
            // ),
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
