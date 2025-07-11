import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class EstructuraDocumento {
  static final EstructuraDocumento _instance = EstructuraDocumento._internal();

  factory EstructuraDocumento() {
    return _instance;
  }

  EstructuraDocumento._internal();

  late Map<String, String> _mensajes;

  Future<void> cargarEstructuras() async {
    String jsonString = await rootBundle.loadString('assets/file/comprobante.json');
    _mensajes = Map<String, String>.from(json.decode(jsonString));
  }

  String getMensaje(int codigo) {
    return _mensajes[codigo.toString()] ?? "Not found";
  }
}
