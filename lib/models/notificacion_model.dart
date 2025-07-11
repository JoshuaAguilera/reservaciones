import 'dart:convert';

import 'usuario_model.dart';

List<Notificacion> notificacionesFromJson(String str) =>
    List<Notificacion>.from(
        json.decode(str).map((x) => Notificacion.fromJson(x)));

String notificacionesToJson(List<Notificacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Notificacion> listNotificacionFromJson(List<dynamic> list) =>
    List<Notificacion>.from(list.map((x) => Notificacion.fromJson(x)));

Notificacion notificacionJson(String str) =>
    Notificacion.fromJson(json.decode(str));
String notificacionToJson(Notificacion data) => json.encode(data.toJson());

class Notificacion {
  int? idInt;
  String? id;
  DateTime? createdAt;
  String? mensaje;
  String? documento;
  String? estatus;
  String? tipo;
  String? ruta;
  bool select = false;
  Usuario? usuario;

  Notificacion({
    this.idInt,
    this.id,
    this.tipo,
    this.createdAt,
    this.mensaje,
    this.ruta,
    this.usuario,
    this.documento,
    this.estatus,
    this.select = false,
  });

  Notificacion copyWith({
    int? idInt,
    String? id,
    DateTime? createdAt,
    String? mensaje,
    String? tipo,
    String? ruta,
    Usuario? usuario,
    String? documento,
    String? estatus,
    bool? select,
  }) =>
      Notificacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        mensaje: mensaje ?? this.mensaje,
        ruta: ruta ?? this.ruta,
        tipo: tipo ?? this.tipo,
        usuario: usuario?.copyWith() ?? this.usuario?.copyWith(),
        createdAt: createdAt ?? this.createdAt,
        documento: documento ?? this.documento,
        estatus: estatus ?? this.estatus,
        select: select ?? this.select,
      );

  factory Notificacion.fromJson(Map<String, dynamic> json) => Notificacion(
        id: json['id'],
        idInt: json['id_int'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at']),
        mensaje: json['mensaje'],
        tipo: json['tipo'],
        ruta: json['ruta'],
        documento: json['documento'],
        estatus: json['estatus'],
        usuario:
            json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": id,
      "id_int": idInt,
      "mensaje": mensaje,
      "documento": documento,
      "estatus": estatus,
      "tipo": tipo,
      "ruta": ruta,
      "usuario_int": usuario?.idInt,
      "usuario": usuario?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
