import 'package:flutter/material.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

class BaseService extends ChangeNotifier {
  var userName = Preferences.username;
  var rol = Preferences.rol;
  var mail = Preferences.mail;
  var phone = Preferences.phone;
  var passwordMail = Preferences.passwordMail;
}
