import 'package:flutter/material.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';

class BaseService extends ChangeNotifier {
  var userName = Preferences.username;
  var rol = Preferences.rol;
  var mail = Preferences.mail;
  var phone = Preferences.phone;
  var passwordMail = Preferences.passwordMail;
  var userId = Preferences.userId;
  var mailUser = Preferences.mail;
  var passwordUser = Preferences.passwordMail;
  var phoneUser = Preferences.phone;
  var username = Preferences.username;
  var firstName = Preferences.firstName;
  var lastName = Preferences.lastName;
}
