import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';

import '../ui/buttons.dart';

class Dialogs {
  static Widget customAlertDialog({
    IconData? iconData,
    Color? iconColor,
    Color? colorTextButton,
    required BuildContext context,
    required String title,
    String contentText = '',
    Widget? contentCustom,
    String? contentBold,
    bool otherButton = false,
    bool notCloseInstant = false,
    bool withLoadingProcess = false,
    required String nameButtonMain,
    required void Function() funtionMain,
    String nameButtonCancel = "",
    required bool withButtonCancel,
  }) {
    bool loadingProcess = false;

    return StatefulBuilder(builder: (context, snapshot) {
      var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
      return AlertDialog(
        actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Row(children: [
          if (iconData != null)
            Icon(
              iconData,
              size: 33,
              color: iconColor ??
                  (brightness == Brightness.light
                      ? DesktopColors.cerulean
                      : DesktopColors.azulUltClaro),
            ),
          const SizedBox(width: 10),
          Expanded(
              child: TextStyles.titleText(
                  text: title, size: 18, color: Theme.of(context).primaryColor))
        ]),
        content: contentCustom ??
            TextStyles.TextAsociative(contentBold ?? "", contentText,
                isInverted: contentBold != null,
                color: Theme.of(context).primaryColor),
        actions: [
          if (withButtonCancel)
            Opacity(
              opacity: (withLoadingProcess && loadingProcess) ? 0.4 : 1,
              child: TextButton(
                onPressed: (withLoadingProcess && loadingProcess)
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                child: TextStyles.buttonText(
                  text: nameButtonCancel,
                  color: colorTextButton ??
                      (brightness == Brightness.light
                          ? DesktopColors.cerulean
                          : DesktopColors.azulUltClaro),
                ),
              ),
            ),
          if (otherButton)
            SizedBox(
              width: 120,
              child: Buttons.commonButton(
                text: "ACEPTAR",
                isLoading: loadingProcess,
                onPressed: () {
                  if (withLoadingProcess) snapshot(() => loadingProcess = true);
                  funtionMain.call();
                  if (!notCloseInstant) Navigator.of(context).pop(true);
                },
              ),
            )
          else
            TextButton(
              onPressed: () {
                funtionMain.call();
                if (!notCloseInstant) Navigator.of(context).pop(true);
              },
              child: TextStyles.buttonText(
                text: nameButtonMain,
                color: colorTextButton,
              ),
            ),
        ],
      );
    });
  }

  static AlertDialog filterDateDialog({
    required BuildContext context,
    required VoidCallback funtionMain,
  }) {
    final TextEditingController _initDateController = TextEditingController(
        text: DateTime.now()
            .subtract(const Duration(days: 30))
            .toIso8601String()
            .substring(0, 10));
    final TextEditingController _endDateController = TextEditingController(
        text: DateTime.now().toIso8601String().substring(0, 10));

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Row(children: [
        Icon(
          Icons.date_range_outlined,
          size: 33,
          color: DesktopColors.ceruleanOscure,
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextStyles.titleText(
          text: "Filtrar por fechas",
          color: Theme.of(context).primaryColor,
          size: 18,
        ))
      ]),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.standardText(
                    text: "Seleccione un periodo de tiempo:",
                    color: Theme.of(context).primaryColor),
                const SizedBox(height: 15),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha inicial",
                  msgError: "",
                  esInvertido: true,
                  dateController: _initDateController,
                  onChanged: () => setState(
                    () => _endDateController.text =
                        Utility.getNextMonth(_initDateController.text),
                  ),
                ),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha final",
                  msgError: "",
                  dateController: _endDateController,
                  fechaLimite: (_initDateController.text),
                )
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            funtionMain.call();
            Navigator.of(context)
                .pop(_initDateController.text + _endDateController.text);
          },
          child: TextStyles.buttonText(
            text: "Aceptar",
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextStyles.buttonText(text: "Cancelar")),
      ],
    );
  }
}
