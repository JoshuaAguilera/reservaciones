import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../res/helpers/date_helpers.dart';
import '../../res/helpers/utility.dart';
import '../../res/helpers/desktop_colors.dart';
import '../../res/ui/textformfield_style.dart';

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
    String? hintText,
    double marginBottom = 8,
    FloatingLabelAlignment? floatingLabelAlignment,
    void Function(String)? onFieldSubmitted,
    void Function()? onUnfocus,
    bool withLabelAndHint = false,
  }) {
    return StatefulBuilder(
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(bottom: marginBottom),
          decoration: BoxDecoration(
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
                child: Focus(
                  onFocusChange: (value) {
                    if (!value && onUnfocus != null) {
                      onUnfocus.call();
                    }
                  },
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
                      filled: readOnly,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(
                        fontFamily: "poppins_regular",
                        fontSize: 13,
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: "poppins_regular",
                        fontSize: 13,
                      ),
                      alignLabelWithHint: true,
                      floatingLabelAlignment: floatingLabelAlignment,
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
                      labelText: withLabelAndHint
                          ? name
                          : hintText != null
                              ? null
                              : name,
                      hintText: hintText,
                      errorMaxLines: 2,
                      errorStyle: TextStyle(
                        fontFamily: "poppins_regular",
                        color: Colors.red[800],
                        fontSize: 10,
                        height: msgError.isEmpty ? 0 : 1,
                      ),
                    ),
                    initialValue: initialValue,
                    onFieldSubmitted: onFieldSubmitted,
                  ),
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
    String msgError = "",
    required TextEditingController dateController,
    void Function()? onChanged,
    String fechaLimite = "",
    bool esInvertido = false,
    int firstYear = 2,
    int lastYear = 2,
    bool nowLastYear = false,
    bool changed = false,
    bool compact = false,
    bool readOnly = false,
    bool enabled = true,
    bool withButton = true,
    TextAlign align = TextAlign.start,
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
                  textAlign: align,
                  enabled: enabled,
                  readOnly: readOnly,
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
                    text: dateController.text.isEmpty
                        ? ""
                        : DateHelpers.getStringDate(
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
              if (withButton)
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
                      onPressed: !enabled
                          ? null
                          : () {
                              showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.parse(dateController.text),
                                firstDate: fechaLimite.isNotEmpty
                                    ? DateTime.parse(fechaLimite)
                                        .add(const Duration(days: 1))
                                    : DateTime(DateTime.now().year - firstYear),
                                lastDate: nowLastYear
                                    ? DateTime.now()
                                    : DateTime(
                                        (DateTime.now().year + lastYear)),
                                locale: const Locale('es', 'ES'),
                              ).then(
                                (date) {
                                  if (date != null) {
                                    setState(() {
                                      dateController.text = date
                                          .toIso8601String()
                                          .substring(0, 10);
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
