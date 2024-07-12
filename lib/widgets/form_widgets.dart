import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';

import 'text_styles.dart';

class FormWidgets {
  static Widget inputColor(
      {required String nameInput,
      required Color primaryColor,
      double verticalPadding = 6}) {
    Color pickerColor = primaryColor;
    Color currentColor = primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: StatefulBuilder(
        builder: (context, setState) {
          void changeColor(Color color) {
            setState(() => pickerColor = color);
          }

          return Wrap(
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
                            text: "Selecciona un color", color: Colors.black87),
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
          );
        },
      ),
    );
  }

  static Widget inputImage({required String nameInput}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 52,
            child: Wrap(
              children: [
                TextStyles.standardText(text: nameInput),
                GestureDetector(
                  onTap: () {},
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                      name: "coralbluelogo.png",
                      msgError: "",
                      blocked: true,
                      icon: const Icon(Icons.upload)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget inputSwitch(
      {String name = "",
      required bool value,
      bool isModeDark = false,
      Color? activeColor,
      void Function(bool)? onChanged}) {
    return Wrap(
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
    );
  }
}
