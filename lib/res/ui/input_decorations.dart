import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../helpers/desktop_colors.dart';
import 'text_styles.dart';

class InputDecorations {
  static String fontRegular = "poppins_regular";

  static CustomDropdownDecoration defaultDropdownDecoration(
      BuildContext context) {
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    return CustomDropdownDecoration(
      closedFillColor:
          brightness != Brightness.dark ? null : Colors.transparent,
      hintStyle: TextStyles.styleStandar(),
      listItemStyle: TextStyles.styleStandar(),
      headerStyle: TextStyles.styleStandar(),
      errorStyle: TextStyles.styleStandar(color: Colors.red),
      noResultFoundStyle: TextStyles.styleStandar(),
      searchFieldDecoration: SearchFieldDecoration(
        textStyle: TextStyles.styleStandar(),
        fillColor: brightness != Brightness.dark ? null : Colors.transparent,
      ),
      closedBorder: Border.all(
          color: brightness == Brightness.dark ? Colors.white : Colors.black),
      closedBorderRadius: const BorderRadius.all(Radius.circular(14)),
      expandedBorderRadius: BorderRadius.circular(5),
      expandedFillColor:
          brightness != Brightness.dark ? null : Theme.of(context).cardColor,
    );
  }

  static CustomDropdownDisabledDecoration defaultDropdownDiseableDecoration() {
    return CustomDropdownDisabledDecoration(
      hintStyle: TextStyles.styleStandar(color: Colors.black38),
      headerStyle: TextStyles.styleStandar(color: Colors.black38),
      border: Border.all(color: Colors.black38),
      borderRadius: const BorderRadius.all(Radius.circular(14)),
    );
  }

  static InputDecorationTheme DropdownMenuInput({
    bool centerLabel = true,
    Color? colorBorder,
    Color? colorLabel,
  }) {
    return InputDecorationTheme(
      floatingLabelAlignment: !centerLabel
          ? FloatingLabelAlignment.start
          : FloatingLabelAlignment.center,
      alignLabelWithHint: true,
      isDense: false,
      labelStyle: TextStyle(
        color: colorLabel,
        fontFamily: fontRegular,
        fontSize: 14,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      errorStyle: TextStyle(
        color: DesktopColors.errorColor,
        fontFamily: fontRegular,
        fontSize: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.2, color: colorBorder ?? Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      focusedBorder: InputBorderDecoration.OutlineBorder(radius: 12),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.2, color: Colors.red),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.2, color: Colors.red),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }

  static InputDecoration authInputDecoration({
    required String labelText,
    Color? colorBorder,
    Color? colorLabel,
    Widget? suffixIcon,
    bool centerLabel = true,
    String? msgError,
    Widget? icon,
    Color? fillColor,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      labelText: labelText,
      counterText: "",
      floatingLabelAlignment:
          !centerLabel ? null : FloatingLabelAlignment.center,
      alignLabelWithHint: true,
      isDense: false,
      labelStyle: TextStyle(
        color: colorLabel,
        fontFamily: fontRegular,
        fontSize: 13,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.2),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.2,
          color: colorBorder ?? Colors.transparent,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      errorStyle: TextStyle(
        color: DesktopColors.errorColor,
        fontFamily: fontRegular,
        fontSize: 12,
      ),
      suffixIcon: suffixIcon,
      icon: icon,
      focusedBorder: InputBorderDecoration.OutlineBorder(
        radius: 12,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.2, color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1.2, color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }

  static InputDecoration inputDecoration({
    required String labelText,
    IconButton? icon,
    bool withIconMoney = false,
  }) {
    return InputDecoration(
        labelText: labelText,
        labelStyle: TextStyles.styleStandar(),
        suffixIcon: icon,
        hintText: labelText,
        isDense: false,
        prefixIcon: withIconMoney
            ? Icon(
                Icons.attach_money_rounded,
                color: DesktopColors.primaryColor,
              )
            : null,
        contentPadding:
            const EdgeInsets.only(top: 0, bottom: 9, left: 21, right: 21),
        filled: true,
        fillColor: const Color.fromRGBO(239, 239, 239, 1.0),
        enabledBorder: InputBorderDecoration.NoneBorder(),
        focusedBorder: InputBorderDecoration.NoneBorder(),
        errorBorder: InputBorderDecoration.NoneBorder(),
        focusedErrorBorder: InputBorderDecoration.NoneBorder());
  }

  static InputDecoration inputDecorationPassword(
      {required String labelText,
      required bool passwordVisible,
      required VoidCallback event}) {
    return InputDecoration(
        hintText: labelText,
        isDense: false,
        contentPadding:
            const EdgeInsets.only(top: 9, bottom: 9, left: 21, right: 21),
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black87,
          ),
          onPressed: event,
        ),
        fillColor: const Color.fromRGBO(239, 239, 239, 1.0),
        enabledBorder: InputBorderDecoration.NoneBorder(),
        focusedBorder: InputBorderDecoration.NoneBorder(),
        errorBorder: InputBorderDecoration.NoneBorder(),
        focusedErrorBorder: InputBorderDecoration.NoneBorder());
  }

  static InputDecoration inputIconDecoration(
      {required String labelText,
      required ValueChanged<String> onSubmitted,
      required TextEditingController search}) {
    return InputDecoration(
        hintText: labelText,
        isDense: false,
        contentPadding:
            const EdgeInsets.only(top: 9, bottom: 9, left: 21, right: 21),
        filled: true,
        fillColor: const Color.fromRGBO(239, 239, 239, 1.0),
        enabledBorder: InputBorderDecoration.NoneBorder(),
        focusedBorder: InputBorderDecoration.NoneBorder(),
        errorBorder: InputBorderDecoration.NoneBorder(),
        focusedErrorBorder: InputBorderDecoration.NoneBorder(),
        suffixIcon: IconButton(
            onPressed: () {
              onSubmitted.call(search.text);
            },
            icon: const Icon(
              Icons.search,
              size: 33,
              color: Colors.black,
            ))
        //const Icon(Icons.search, size: 33, color: Colors.black)
        );
  }

  static InputDecoration formInputDecoration(
      {required String labelText,
      IconButton? icon,
      double verticalPadding = 0,
      double? horizontalPadding,
      bool withIconMoney = false}) {
    return InputDecoration(
      suffixIcon: icon,
      labelText: labelText,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      prefixIcon: withIconMoney
          ? Icon(
              Icons.attach_money_rounded,
              color: DesktopColors.primaryColor,
            )
          : null,
      //alignLabelWithHint: true,
      isDense: false,
      labelStyle: TextStyle(
        fontFamily: fontRegular,
        fontSize: 14,
        color: DesktopColors.grisSemiPalido,
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 15, vertical: verticalPadding),
      //contentPadding: EdgeInsets.only(top: 12,bottom: 12,left: 21,right: 21),
      //filled: true,
      fillColor: Colors.white,
      // enabledBorder: InputBorder.OutlineBorderEnabled(),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      focusedBorder: InputBorderDecoration.OutlineBorder(),
      // errorBorder: InputBorder.OutlineBorder(),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      focusedErrorBorder: InputBorderDecoration.OutlineBorder(),
    );
  }
}

class TextInputDecoration {
  static InputDecoration inputDecoration({required String label}) {
    return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: DesktopColors.primaryColor,
        ),
        enabledBorder: InputBorderDecoration.OutlineBorderEnabled(),
        focusedBorder: InputBorderDecoration.OutlineBorder(),
        errorBorder: InputBorderDecoration.OutlineBorder(),
        focusedErrorBorder: InputBorderDecoration.OutlineBorder());
  }
}

class InputBorderDecoration {
  static OutlineInputBorder OutlineBorderEnabled() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.0),
      borderSide: const BorderSide(
        color: Color.fromRGBO(162, 162, 162, 1.0),
      ),
    );
  }

  static OutlineInputBorder OutlineBorder({double radius = 3}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: DesktopColors.cerulean),
    );
  }

  static OutlineInputBorder NoneBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.0),
      borderSide: BorderSide.none,
    );
  }
}
