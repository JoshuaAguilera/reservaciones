import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/ui/textformfield_style.dart';

import '../utils/helpers/utility.dart';
import '../utils/helpers/web_colors.dart';

class TextFormFieldCustom {
  static Widget textFormFieldwithBorder({
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
    Widget? icon,
    double maxHeight = 100,
    bool readOnly = false,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
  }) {
    return StatefulBuilder(
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
          constraints: BoxConstraints(
            minWidth: 110,
            minHeight: 25.0,
            maxHeight: maxHeight,
            maxWidth: maxWidth ?? double.infinity,
          ),
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: blocked,
                child: TextFormField(
                  readOnly: readOnly,
                  textInputAction: textInputAction,
                  enabled: enabled,
                  controller: controller,
                  onChanged: (value) {
                    snapshot(() {});
                    if (onChanged != null) onChanged.call(value);
                  },
                  obscureText: passwordVisible,
                  validator: validator ??
                      (value) {
                        if (isRequired) {
                          if ((value == null || value.isEmpty)) {
                            return msgError;
                          }
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
                        ? FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9]+[.]?[0-9]*'))
                        : isNumeric
                            ? FilteringTextInputFormatter.digitsOnly
                            : FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  textAlignVertical: TextAlignVertical.top,
                  textAlign: isMoneda ? TextAlign.right : TextAlign.left,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelStyle: const TextStyle(
                      fontFamily: "poppins_regular",
                      fontSize: 13,
                    ),
                    alignLabelWithHint: true,
                    prefixIcon: isMoneda
                        ? const Icon(
                            CupertinoIcons.money_dollar,
                            size: 20,
                          )
                        : null,
                    prefixIconConstraints:
                        const BoxConstraints(maxWidth: 20, minWidth: 20),
                    suffixIcon: isPassword
                        ? IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: DesktopColors.azulCielo,
                            ),
                            onPressed: () {
                              snapshot(() {
                                passwordVisible = !passwordVisible;
                              });
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
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget textFormFieldwithBorderCalendar({
    required String name,
    required String msgError,
    required TextEditingController dateController,
    void Function()? onChanged,
    String fechaLimite = "",
    bool esInvertido = false,
    int firstYear = 2,
    int lastYear = 2,
    bool nowLastYear = false,
    bool changed = false,
    bool compact = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
          constraints: const BoxConstraints(
            minWidth: 270,
            minHeight: 25.0,
            maxHeight: 100.0,
          ),
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: true,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return msgError;
                    }

                    if (changed && value.isNotEmpty) {
                      return msgError;
                    }
                    return null;
                  },
                  controller: TextEditingController(
                    text: Utility.getCompleteDate(
                      data: DateTime.parse(dateController.text),
                      compact: compact,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "poppins_regular",
                  ),
                  decoration: TextFormFieldStyle.decorationFieldStandar(name),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  color: Theme.of(context).secondaryHeaderColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: DesktopColors.azulCielo,
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(dateController.text),
                        firstDate: fechaLimite.isNotEmpty
                            ? DateTime.parse(fechaLimite)
                                .add(const Duration(days: 1))
                            : DateTime(DateTime.now().year - firstYear),
                        lastDate: nowLastYear
                            ? DateTime.now()
                            : DateTime((DateTime.now().year + lastYear)),
                        locale: const Locale('es', 'ES'),
                      ).then(
                        (date) {
                          if (date != null) {
                            setState(() {
                              dateController.text =
                                  date.toIso8601String().substring(0, 10);
                              if (onChanged != null) onChanged.call();
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
