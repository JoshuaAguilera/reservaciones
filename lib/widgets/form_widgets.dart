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
    double verticalPadding = 6,
    bool blocked = false,
  }) {
    Color pickerColor = primaryColor;
    Color currentColor = primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: StatefulBuilder(
        builder: (context, setState) {
          void changeColor(Color color) {
            setState(() => pickerColor = color);
          }

          return Opacity(
            opacity: blocked ? 0.6 : 1,
            child: AbsorbPointer(
              absorbing: blocked,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextStyles.standardText(text: nameInput),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: TextStyles.titleText(
                                text: "Selecciona un color",
                                color: Colors.black87),
                            content: SingleChildScrollView(
                              child: MaterialPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                                enableLabel: true,
                              ),
                            ),
                            actions: <Widget>[
                              Buttons.commonButton(
                                  onPressed: () {
                                    setState(() => currentColor = pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                  text: "Aceptar"),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3.5),
                        child: Container(
                          color: currentColor,
                          width: 35,
                          height: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget inputImage({
    required String nameInput,
    bool bloked = false,
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
                  TextStyles.standardText(text: nameInput),
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
  }) {
    return Opacity(
      opacity: blocked ? 0.6 : 1,
      child: AbsorbPointer(
        absorbing: blocked,
        child: Wrap(
          children: [
            TextStyles.standardText(text: title),
            SizedBox(
              child: CustomDropdown<String>.search(
                searchHintText: "Buscar",
                hintText: "Selecciona la nueva fuente del documento",
                closedHeaderPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                items: textFont,
                decoration: CustomDropdownDecoration(
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
                          "${selectedItem.toLowerCase().replaceAll(' ', '')}_regular"),
                ),
                listItemBuilder: (context, item, isSelected, onItemSelect) =>
                    Text(
                  item,
                  style: TextStyle(
                      fontFamily:
                          "${item.toLowerCase().replaceAll(' ', '')}_regular"),
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
  }) {
    return Opacity(
      opacity: bloked ? 0.6 : 1,
      child: AbsorbPointer(
        absorbing: bloked,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextStyles.standardText(text: name),
            Switch(
              value: value,
              activeColor: activeColor ?? Colors.white,
              inactiveTrackColor: !isModeDark ? null : Colors.blue[200],
              inactiveThumbColor: !isModeDark ? null : Colors.amber,
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
            validator!.call(value);
          }
          return null;
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
          contentPadding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 10),
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(
            fontFamily: "poppins_regular",
            fontSize: 13,
          ),
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
