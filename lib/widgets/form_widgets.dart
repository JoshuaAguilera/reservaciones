import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

import '../utils/helpers/constants.dart';
import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';

class FormWidgets {
  static Widget inputColor({
    required String nameInput,
    required Color primaryColor,
    bool blocked = false,
    required Color colorText,
    void Function(Color)? onChangedColor,
  }) {
    Color pickerColor = primaryColor;
    Color currentColor = primaryColor;

    return StatefulBuilder(
      builder: (context, setState) {
        void changeColor(Color color) {
          setState(() => pickerColor = color);
        }

        return Opacity(
          opacity: blocked ? 0.6 : 1,
          child: AbsorbPointer(
            absorbing: blocked,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: TextStyles.titleText(
                          text: "Selecciona un color",
                          color: Theme.of(context).primaryColor),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                          enableLabel: false,
                          portraitOnly: true,
                        ),
                      ),
                      actions: <Widget>[
                        Buttons.commonButton(
                          onPressed: () {
                            setState(() => currentColor = pickerColor);
                            onChangedColor!.call(currentColor);
                            Navigator.of(context).pop();
                          },
                          text: "Aceptar",
                        ),
                      ],
                    );
                  },
                );
              },
              child: Stack(
                children: [
                  TextFormFieldCustom.textFormFieldwithBorder(
                      name: "Color", initialValue: "s", blocked: true),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Center(
                      child: Container(
                        width: 105,
                        height: 30,
                        decoration: BoxDecoration(
                            color: currentColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
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
    void Function(bool)? onChanged,
    bool bloked = false,
    required BuildContext context,
  }) {
    return Opacity(
      opacity: bloked ? 0.6 : 1,
      child: AbsorbPointer(
        absorbing: bloked,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextStyles.standardText(
              text: name,
              color: Theme.of(context).primaryColor,
            ),
            Switch(
              value: value,
              activeColor: activeColor ?? Colors.white,
              inactiveTrackColor: !isModeDark ? null : Colors.blue[200],
              inactiveThumbColor: !isModeDark
                  ? null
                  : value
                      ? Colors.white
                      : Colors.amber,
              activeTrackColor: !isModeDark ? null : Colors.black54,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  static Widget textFormFieldResizable({
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
    bool blocked = false,
    TextEditingController? controller,
    bool enabled = true,
    double? maxWidth,
    Icon? icon,
    double maxHeight = 100,
    double verticalPadding = 10,
    String? Function(String?)? validator,
  }) {
    bool withContent = false;

    validator ??= (value) {
      if ((value == null || value.isEmpty)) {
        return msgError;
      }
    };

    return AbsorbPointer(
      absorbing: blocked,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        onChanged: (value) {
          if (value.isEmpty) {
            withContent = false;
          } else {
            withContent = true;
          }
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
        style: const TextStyle(
          fontFamily: "poppins_regular",
          fontSize: 13,
        ),
        keyboardType: isNumeric
            ? TextInputType.numberWithOptions(
                decimal: isDecimal,
                signed: isNumeric,
              )
            : TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          isDecimal
              ? FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+[.]?[0-9]*'))
              : isNumeric
                  ? FilteringTextInputFormatter.digitsOnly
                  : FilteringTextInputFormatter.singleLineFormatter
        ],
        textAlign: isMoneda ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          floatingLabelAlignment:
              isMoneda ? FloatingLabelAlignment.center : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 10),
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(
            fontFamily: "poppins_regular",
            fontSize: 13,
          ),
          prefixIcon: isMoneda ? const Icon(CupertinoIcons.money_dollar) : null,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: DesktopColors.azulCielo,
                  ),
                  onPressed: () {
                    passwordVisible = !passwordVisible;
                  },
                )
              : icon,
          labelText: name,
          errorStyle: TextStyle(
            fontFamily: "poppins_regular",
            color: Colors.red[800],
            fontSize: 10,
          ),
        ),
        initialValue: initialValue,
      ),
    );
  }
}
