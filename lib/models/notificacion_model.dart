import 'dart:convert';

import '../res/helpers/date_helpers.dart';
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
  String? title;
  String? message;
  String? documento;
  String? estatus;
  NotificationType? tipo;
  String? ruta;
  bool select = false;
  Usuario? usuario;

  Notificacion({
    this.idInt,
    this.id,
    this.tipo,
    this.createdAt,
    this.title,
    this.message,
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
    String? title,
    String? message,
    NotificationType? tipo,
    String? ruta,
    Usuario? usuario,
    String? documento,
    String? estatus,
    bool? select,
  }) =>
      Notificacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        title: title ?? this.title,
        message: message ?? this.message,
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
        idInt: json['idInt'],
        createdAt: DateValueFormat.fromJSON(json['createdAt']),
        title: json['mensaje'],
        tipo: json['tipo'] != null
            ? NotificationType.values.firstWhere(
                (e) => e.toString() == 'NotificationType.${json['tipo']}',
                orElse: () => NotificationType.message,
              )
            : null,
        ruta: json['ruta'],
        documento: json['documento'],
        estatus: json['estatus'],
        usuario:
            json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": id,
      "idInt": idInt,
      "mensaje": title,
      "documento": documento,
      "estatus": estatus,
      "tipo": tipo?.toString().split('.').last,
      "ruta": ruta,
      "usuario_int": usuario?.idInt,
      "usuario": usuario?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}

enum NotificationType {
  alert,
  info,
  danger,
  success,
  message,
  /* etc */
}
