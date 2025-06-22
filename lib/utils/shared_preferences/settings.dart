import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static late SharedPreferences _prefs;

  static String _aplication = '';
  static bool _modeDark = false;
  static int _numberQuotes = 0;
  static int _portSMTP = 465;
  static String _mailServer = "mail.coralbluehuatulco.mx";
  static bool _showAlertTariffModified = true;
  static bool _applyAnimations = true;
  static bool _applySSL = true;
  static bool _ignoreBadCertificate = false;
  static bool _isOnline = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isOnline {
    return _prefs.getBool('isOnline') ?? _isOnline;
  }

  static set isOnline(bool value) {
    _isOnline = value;
    _prefs.setBool('isOnline', value);
  }

  static String get sucursal {
    return _prefs.getString('sucursal') ?? _aplication;
  }

  static set sucursal(String value) {
    _aplication = value;
    _prefs.setString('sucursal', value);
  }

  static bool get modeDark {
    return _prefs.getBool('modeDark') ?? _modeDark;
  }

  static set modeDark(bool value) {
    _modeDark = value;
    _prefs.setBool('modeDark', value);
  }

  static int get numberQuotes {
    return _prefs.getInt('numberQuotes') ?? _numberQuotes;
  }

  static set numberQuotes(int numberQuotes) {
    _numberQuotes = numberQuotes;
    _prefs.setInt('numberQuotes', numberQuotes);
  }

  static int get portSMTP {
    return _prefs.getInt('portSMTP') ?? _portSMTP;
  }

  static set portSMTP(int portSMTP) {
    _portSMTP = portSMTP;
    _prefs.setInt('portSMTP', portSMTP);
  }

  static String get mailServer {
    return _prefs.getString('mailServer') ?? _mailServer;
  }

  static set mailServer(String value) {
    _mailServer = value;
    _prefs.setString('mailServer', value);
  }

  static bool get showAlertTariffModified {
    return _prefs.getBool('showAlertTariffModified') ??
        _showAlertTariffModified;
  }

  static set showAlertTariffModified(bool value) {
    _showAlertTariffModified = value;
    _prefs.setBool('showAlertTariffModified', value);
  }

  static bool get applyAnimations {
    return _prefs.getBool('applyAnimations') ?? _applyAnimations;
  }

  static set applyAnimations(bool value) {
    _applyAnimations = value;
    _prefs.setBool('applyAnimations', value);
  }

  static bool get applySSL {
    return _prefs.getBool('applySSL') ?? _applySSL;
  }

  static set applySSL(bool value) {
    _applySSL = value;
    _prefs.setBool('applySSL', value);
  }

  static bool get ignoreBadCertificate {
    return _prefs.getBool('ignoreBadCertificate') ?? _ignoreBadCertificate;
  }

  static set ignoreBadCertificate(bool value) {
    _ignoreBadCertificate = value;
    _prefs.setBool('ignoreBadCertificate', value);
  }
}
