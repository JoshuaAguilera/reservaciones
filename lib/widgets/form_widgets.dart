import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

import '../utils/helpers/constants.dart';
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
}
