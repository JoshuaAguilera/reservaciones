import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void applyUnfocus() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  try {
    FocusManager.instance.primaryFocus!.unfocus();
  } catch (e) {
    print(e);
  }
}
