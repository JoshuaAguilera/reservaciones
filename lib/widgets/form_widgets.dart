import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'text_styles.dart';

class FormWidgets {
  static Widget inputColor({required String nameInput, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Row(
            children: [
              TextStyles.standardText(text: nameInput),
              GestureDetector(
                onTap: () {
                  Color pickerColor = Color(0xff443a49);
                  Color currentColor = Color(0xff443a49);

                  void changeColor(Color color) {
                    setState(() => pickerColor = color);
                  }

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                          ),
                          // Use Material color picker:
                          //
                          // child: MaterialPicker(
                          //   pickerColor: pickerColor,
                          //   onColorChanged: changeColor,
                          //   showLabel: true, // only on portrait mode
                          // ),
                          //
                          // Use Block color picker:
                          //
                          // child: BlockPicker(
                          //   pickerColor: currentColor,
                          //   onColorChanged: changeColor,
                          // ),
                          //
                          // child: MultipleChoiceBlockPicker(
                          //   pickerColors: currentColors,
                          //   onColorsChanged: changeColors,
                          // ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Got it'),
                            onPressed: () {
                              setState(() => currentColor = pickerColor);
                              Navigator.of(context).pop();
                            },
                          ),
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
                      color: color,
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
}
