import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/res/ui/container_section.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';
import 'package:generador_formato/utils/shared_preferences/settings.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../res/ui/themes.dart';
import '../../utils/widgets/form_widgets.dart';

class ConfigGeneralView extends StatefulWidget {
  const ConfigGeneralView({super.key});

  @override
  State<ConfigGeneralView> createState() => _ConfigGeneralViewState();
}

class _ConfigGeneralViewState extends State<ConfigGeneralView> {
  bool activeModeDark = false;
  bool activeAnimations = false;
  bool modificMode = false;

  @override
  void initState() {
    activeAnimations = Settings.applyAnimations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    return ContainerSection(
      title: "Configuraciones generales",
      icons: Iconsax.setting_2_outline,
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
                    isReversed: brightness == Brightness.dark ? true : false,
                  );
                  Settings.modeDark = !Settings.modeDark;
                  setState(() {});

                  Future.delayed(400.ms, () {
                    modificMode = false;
                    setState(() {});
                  });
                },
                child: FormWidgets.inputSwitch(
                  value: Settings.modeDark,
                  activeColor: Colors.white,
                  isModeDark: true,
                  name: "Modo Oscuro: ",
                  context: context,
                ),
              ),
            );
          },
        ),
        FormWidgets.inputSwitch(
          value: Settings.applyAnimations,
          activeColor: brightness == Brightness.dark
              ? Colors.amber
              : DesktopColors.cerulean,
          name: "Animaciones activadas: ",
          onChanged: (value) {
            Settings.applyAnimations = !Settings.applyAnimations;
            setState(() {});
          },
          context: context,
        ),
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
    );
  }
}
