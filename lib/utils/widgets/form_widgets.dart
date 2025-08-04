import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:generador_formato/res/ui/buttons.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/constants.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/helpers/functions_ui.dart';
import '../../res/helpers/general_helpers.dart';
import '../../res/ui/input_decorations.dart';
import '../../res/ui/tools_ui.dart';
import 'number_input_with_increment_decrement.dart';
import '../../res/ui/text_styles.dart';
import 'textformfield_custom.dart';

class FormWidgets {
  static Widget inputColor({
    required String nameInput,
    Color? primaryColor,
    bool blocked = false,
    required void Function(Color) onChangedColor,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    Color pickerColor = primaryColor ?? DesktopColors.buttonPrimary;
    Color currentColor = primaryColor ?? DesktopColors.buttonPrimary;

    return StatefulBuilder(
      builder: (context, setState) {
        void changeColor(Color color) {
          setState(() => pickerColor = color);
        }

        return Column(
          spacing: 3,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            AppText.styledText(text: nameInput, size: 9),
            ToolsUi.blockedWidget(
              isBloqued: blocked,
              child: GestureDetector(
                onTap: () {
                  applyUnfocus();
                  showDialog(
                    context: context,
                    builder: (context) {
                      final fillColor = Theme.of(context).cardColor;

                      return AlertDialog(
                        title: AppText.cardTitleText(
                          text: "Selecciona un color",
                        ),
                        content: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: pickerColor,
                                ),
                            inputDecorationTheme: InputDecorationTheme(
                              filled: true,
                              fillColor: fillColor,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.2, color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: HueRingPicker(
                              pickerColor: pickerColor,
                              pickerAreaBorderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              onColorChanged: changeColor,
                              portraitOnly: true,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          Buttons.buttonPrimary(
                            text: "Aceptar",
                            onPressed: () {
                              setState(() => currentColor = pickerColor);
                              onChangedColor.call(currentColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: currentColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      AppText.simpleText(
                        text: HexColor.colorToHex(currentColor) ?? 'Unknown',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget inputImage({
    required String nameInput,
    bool bloked = false,
    required Color colorText,
  }) {
    return Opacity(
      opacity: bloked ? 0.6 : 1,
      child: AbsorbPointer(
        absorbing: bloked,
        child: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: 65,
              child: Wrap(
                children: [
                  TextStyles.standardText(text: nameInput, color: colorText),
                  GestureDetector(
                    onTap: () {},
                    child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "coralbluelogo.png",
                        msgError: "",
                        blocked: true,
                        icon: const Icon(Icons.upload),
                        maxHeight: 48),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget inputDropdownFont({
    required String title,
    required String font,
    bool blocked = false,
    required Color textColor,
    required Color contentColor,
    required Color textFontColor,
  }) {
    return Opacity(
      opacity: blocked ? 0.6 : 1,
      child: AbsorbPointer(
        absorbing: blocked,
        child: Wrap(
          children: [
            TextStyles.standardText(text: title, color: textColor),
            SizedBox(
              child: CustomDropdown<String>.search(
                searchHintText: "Buscar",
                hintText: "Selecciona la nueva fuente del documento",
                closedHeaderPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                items: textFont,
                decoration: CustomDropdownDecoration(
                    closedFillColor: contentColor,
                    expandedFillColor: contentColor,
                    searchFieldDecoration:
                        SearchFieldDecoration(fillColor: contentColor),
                    closedBorderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                    expandedBorderRadius:
                        const BorderRadius.all(Radius.circular(4)),
                    closedBorder: Border.all(color: Colors.grey)),
                initialItem: font,
                onChanged: (p0) {
                  font = p0!;
                },
                headerBuilder: (context, selectedItem, enabled) => Text(
                  selectedItem,
                  style: TextStyle(
                      fontFamily:
                          "${selectedItem.toLowerCase().replaceAll(' ', '')}_regular",
                      color: textFontColor),
                ),
                listItemBuilder: (context, item, isSelected, onItemSelect) =>
                    Text(
                  item,
                  style: TextStyle(
                      fontFamily:
                          "${item.toLowerCase().replaceAll(' ', '')}_regular",
                      color: textFontColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget inputSwitch({
    String name = "",
    required bool value,
    bool isModeDark = false,
    Color? activeColor,
    Color? inactiveColor,
    void Function(bool)? onChanged,
    bool bloked = false,
    bool compact = false,
    required BuildContext context,
  }) {
    return Opacity(
      opacity: bloked ? 0.6 : 1,
      child: AbsorbPointer(
        absorbing: bloked,
        child: Tooltip(
          message: compact ? name : "",
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (!compact)
                AppText.styledText(
                  text: name,
                  fontFamily: AppText.fontMedium,
                  size: 11,
                ),
              SizedBox(
                height: 25,
                child: Transform.scale(
                  scale: GeneralHelpers.clampSize(2.w, min: 0.8, max: 1),
                  child: Switch(
                    value: value,
                    trackOutlineColor: !(isModeDark && value)
                        ? null
                        : const WidgetStatePropertyAll(Colors.white30),
                    activeColor: activeColor ?? Colors.white,
                    inactiveTrackColor:
                        !isModeDark ? null : inactiveColor ?? Colors.blue[200],
                    inactiveThumbColor: !isModeDark
                        ? null
                        : value
                            ? Colors.white
                            : Colors.amber,
                    activeTrackColor: !isModeDark ? null : Colors.black54,
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget textFormField({
    required String name,
    String msgError = "Campo requerido*",
    bool isPassword = false,
    bool passwordVisible = false,
    bool isNumeric = false,
    bool isDecimal = false,
    bool isMoneda = false,
    void Function(String)? onChanged,
    bool isRequired = true,
    String? initialValue,
    bool readOnly = false,
    TextEditingController? controller,
    bool enabled = true,
    double? maxWidth,
    Widget? suffixIcon,
    Widget? icon,
    double maxHeight = 100,
    double padVer = 10,
    String? Function(String?)? validator,
    void Function()? onEditingComplete,
    Color? colorText,
    Color? colorBorder,
    Color? colorIcon,
    Color? fillColor,
    bool autofocus = false,
    bool filled = false,
    TextInputType? keyboardType,
    void Function(String)? onFieldSubmitted,
    TextAlign? aling,
    TextInputAction? textInputAction,
    double? sizeText,
    double? heightText,
    FocusNode? focusNode,
    int? maxLength,
  }) {
    validator ??= (value) {
      if ((value == null || value.isEmpty)) {
        return msgError;
      }
      return null;
    };

    return AbsorbPointer(
      absorbing: readOnly,
      child: StatefulBuilder(
        builder: (context, snapshot) {
          return TextFormField(
            focusNode: focusNode,
            autofocus: autofocus,
            textInputAction: textInputAction,
            enabled: enabled,
            maxLength: maxLength,
            controller: controller,
            readOnly: readOnly,
            onEditingComplete: onEditingComplete,
            textAlign: isMoneda ? TextAlign.right : aling ?? TextAlign.start,
            initialValue: initialValue,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: (value) {
              if (onChanged != null) onChanged.call(value);
            },
            obscureText: passwordVisible,
            validator: (value) {
              if (isRequired) {
                return validator!.call(value);
              } else {
                return null;
              }
            },
            style: AppText.inputStyle(
              size: sizeText ?? 12.5,
              color: colorText,
              height: heightText,
            ),
            keyboardType: keyboardType ??
                (isNumeric
                    ? TextInputType.numberWithOptions(
                        decimal: isDecimal,
                        signed: isNumeric,
                      )
                    : TextInputType.name),
            inputFormatters: <TextInputFormatter>[
              isDecimal
                  ? FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]+[.]?[0-9]*'),
                    )
                  : isNumeric
                      ? FilteringTextInputFormatter.digitsOnly
                      : FilteringTextInputFormatter.singleLineFormatter
            ],
            decoration: InputDecorations.authInputDecoration(
              labelText: name,
              colorLabel: colorText,
              colorBorder: colorBorder,
              fillColor: fillColor,
              icon: icon,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Iconsax.eye_outline
                            : Iconsax.eye_slash_outline,
                      ),
                      onPressed: () {
                        snapshot(() => passwordVisible = !passwordVisible);
                      },
                    )
                  : suffixIcon,
            ),
          );
        },
      ),
    );
  }

  static Widget inputCountField({
    required Color colorText,
    required String nameField,
    required String initialValue,
    String description = "",
    String definition = "",
    double sizeText = 12,
    double widthInput = 50,
    required void Function(String) onChanged,
    void Function(int)? onDecrement,
    void Function(int)? onIncrement,
  }) {
    bool showMessage = false;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextStyles.standardText(
            text: nameField,
            color: colorText,
            size: sizeText,
          ),
        ),
        if (description.isNotEmpty)
          StatefulBuilder(builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                tooltip: !showMessage ? "" : description,
                icon: const Icon(Iconsax.info_circle_outline),
                onPressed: () {
                  snapshot(() => showMessage = !showMessage);
                },
              ),
            );
          }),
        SizedBox(
          width: widthInput,
          height: 50,
          child: NumberInputWithIncrementDecrement(
            onChanged: onChanged,
            initialValue: initialValue,
            minimalValue: 1,
            sizeIcons: 18,
            height: 6,
            focused: true,
            colorText: colorText,
            maxValue: 106,
            onDecrement: onDecrement,
            onIncrement: onIncrement,
          ),
        ),
        if (definition.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextStyles.standardText(
              text: definition,
              color: colorText,
              isBold: true,
              size: sizeText,
            ),
          ),
      ],
    );
  }

  static Widget textAreaForm({
    TextEditingController? controller,
    String hintText = "",
    bool isError = false,
    bool readOnly = false,
    int? maxLines,
    Color? fillColor,
  }) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      maxLines: maxLines,
      keyboardType: TextInputType.multiline,
      decoration: InputDecorations.authInputDecoration(
        labelText: "",
        fillColor: fillColor,
        hintText: hintText,
      ),
      style: AppText.inputStyle(
        size: 12.5,
        color: isError ? DesktopColors.errorColor : null,
      ),
    );
  }

  static Widget inputCheckBox(
    BuildContext context, {
    required String title,
    String description = "",
    required bool value,
    required void Function(bool?) onChanged,
    Color? activeColor,
    bool compact = false,
    double height = 35,
    double titleSize = 13,
    double spacing = 0,
    bool enable = true,
  }) {
    return SizedBox(
      height: height,
      child: ToolsUi.blockedWidget(
        isBloqued: !enable,
        child: Column(
          children: [
            Row(
              spacing: spacing,
              children: [
                SizedBox(
                  height: height,
                  width: 30,
                  child: Checkbox(
                    value: value,
                    onChanged: (value) => onChanged.call(value),
                    activeColor: activeColor ?? Colors.amber,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      AppText.textButtonStyle(
                        text: title,
                      ),
                      if (compact && description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Tooltip(
                            message: description,
                            textAlign: TextAlign.center,
                            child: const Icon(Iconsax.info_circle_outline,
                                size: 22),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            if (!compact)
              TextStyles.standardText(
                text: description,
                size: 10,
                overflow: TextOverflow.clip,
                align: TextAlign.justify,
              ),
            if (!compact) const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
