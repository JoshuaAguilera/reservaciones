import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _token = '';
  static String _username = '';
  static String _mail = '';
  static int _phone = 0;
  static String _rol = '';
  static String _passwordMail = '';
  static String _urlApi = '';
  static String _aplication = '';
  static bool _modeDark = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token(String token) {
    _token = token;
    _prefs.setString('token', token);
  }

  static String get username {
    return _prefs.getString('username') ?? _username;
  }

  static set username(String value) {
    _username = value;
    _prefs.setString('username', value);
  }

  static String get mail {
    return _prefs.getString('mail') ?? _mail;
  }

  static set mail(String value) {
    _mail = value;
    _prefs.setString('mail', value);
  }
  
  static int get phone {
    return _prefs.getInt('phone') ?? _phone;
  }

  static set phone(int value) {
    _phone = value;
    _prefs.setInt('phone', value);
  }
  
  static String get rol {
    return _prefs.getString('rol') ?? _rol;
  }

  static set rol(String value) {
    _rol = value;
    _prefs.setString('rol', value);
  }

  static String get passwordMail {
    return _prefs.getString('passwordMail') ?? _passwordMail;
  }

  static set passwordMail(String value) {
    _passwordMail = value;
    _prefs.setString('passwordMail', value);
  }


  static String get sucursal {
    return _prefs.getString('sucursal') ?? _aplication;
  }

  static set sucursal(String value) {
    _aplication = value;
    _prefs.setString('sucursal', value);
  }

  static String get urlApi {
    return _prefs.getString('urlApi') ?? _urlApi;
  }

  static set urlApi(String value) {
    _urlApi = value;
    _prefs.setString('urlApi', value);
  }

  static bool get modeDark {
    return _prefs.getBool('modeDark') ?? _modeDark;
  }

  static set modeDark(bool value) {
    _modeDark = value;
    _prefs.setBool('modeDark', value);
  }
}
