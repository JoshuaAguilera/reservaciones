import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/web_colors.dart';
import 'text_styles.dart';

class TextFormFieldCustom {
  static Widget textFormFieldwithBorder({
    required String name,
    required String msgError,
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
  }) {
    bool withContent = false;
    return StatefulBuilder(
      builder: (context, snapshot) {
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
              if (withContent && isMoneda)
                Positioned(
                    top: 15, child: TextStyles.standardText(text: "   \$")),
              AbsorbPointer(
                absorbing: blocked,
                child: TextFormField(
                  enabled: enabled,
                  controller: controller,
                  onChanged: (value) {
                    snapshot(
                      () {
                        if (value.isEmpty) {
                          withContent = false;
                        } else {
                          withContent = true;
                        }
                      },
                    );
                    if (onChanged != null) onChanged.call(value);
                  },
                  obscureText: passwordVisible,
                  validator: (value) {
                    if ((value == null || value.isEmpty) && isRequired) {
                      return msgError;
                    }
                    return null;
                  },
                  style: GoogleFonts.poppins(fontSize: 13),
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
                            : FilteringTextInputFormatter.singleLineFormatter
                  ],
                  textAlign: isMoneda ? TextAlign.right : TextAlign.left,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelStyle: GoogleFonts.poppins(fontSize: 13),
                    suffixIcon: isPassword
                        ? IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: WebColors.azulCielo,
                            ),
                            onPressed: () {
                              snapshot(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          )
                        : null,
                    labelText: name,
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
    String fechaInicial = '',
    void Function()? onChanged,
  }) {
    DateTime fecha = DateTime.now();
    if (fechaInicial.isNotEmpty) fecha = fecha.add(const Duration(days: 1));
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
                    return null;
                  },
                  controller: dateController,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelStyle: GoogleFonts.poppins(fontSize: 13),
                      labelText: name),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: IconButton(
                  icon: Icon(
                    Icons.calendar_month,
                    color: WebColors.azulCielo,
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: fechaInicial.isNotEmpty
                          ? DateTime.parse(fechaInicial)
                              .add(const Duration(days: 1))
                          : DateTime.now(),
                      firstDate: fechaInicial.isNotEmpty
                          ? DateTime.parse(fechaInicial)
                              .add(const Duration(days: 1))
                          : DateTime.now(),
                      lastDate: DateTime((DateTime.now().year + 2)),
                      locale: const Locale('es', 'ES'),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          dateController.text =
                              date.toIso8601String().substring(0, 10);
                          if (onChanged != null) onChanged.call();
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
