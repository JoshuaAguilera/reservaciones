import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _token = '';
  static String _username = '';
  static String _lastName = '';
  static String _firstName = '';
  static String _birthDate = '';
  static String _mail = '';
  static String _phone = '';
  static String _rol = '';
  static String _passwordMail = '';
  static String _password = '';
  static String _urlApi = '';
  static String _aplication = '';
  static int _numberQuotes = 0;
  static int _userId = 0;
  static String _userImageUrl = '';

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

  static String get firstName {
    return _prefs.getString('firstName') ?? _firstName;
  }

  static set firstName(String value) {
    _firstName = value;
    _prefs.setString('firstName', value);
  }

  static String get lastName {
    return _prefs.getString('lastName') ?? _lastName;
  }

  static set lastName(String value) {
    _lastName = value;
    _prefs.setString('lastName', value);
  }

  static String get birthDate {
    return _prefs.getString('birthDate') ?? _birthDate;
  }

  static set birthDate(String value) {
    _birthDate = value;
    _prefs.setString('birthDate', value);
  }

  static String get mail {
    return _prefs.getString('mail') ?? _mail;
  }

  static set mail(String value) {
    _mail = value;
    _prefs.setString('mail', value);
  }

  static String get phone {
    return _prefs.getString('phoneUser') ?? _phone;
  }

  static set phone(String value) {
    _phone = value;
    _prefs.setString('phoneUser', value);
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

  static String get password {
    return _prefs.getString('password') ?? _password;
  }

  static set password(String value) {
    _password = value;
    _prefs.setString('password', value);
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

  static int get numberQuotes {
    return _prefs.getInt('numberQuotes') ?? _numberQuotes;
  }

  static set numberQuotes(int numberQuotes) {
    _numberQuotes = numberQuotes;
    _prefs.setInt('numberQuotes', numberQuotes);
  }

  static int get userId {
    return _prefs.getInt('userId') ?? _userId;
  }

  static set userId(int userId) {
    _userId = userId;
    _prefs.setInt('userId', userId);
  }

  static String get userImageUrl {
    return _prefs.getString('userImageUrl') ?? _userImageUrl;
  }

  static set userImageUrl(String value) {
    _userImageUrl = value;
    _prefs.setString('userImageUrl', value);
  }
}
