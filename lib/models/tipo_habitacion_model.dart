import 'dart:convert';

import '../res/helpers/date_helpers.dart';

List<TipoHabitacion> TipoHabitacionesFromJson(String str) =>
    List<TipoHabitacion>.from(
        json.decode(str).map((x) => TipoHabitacion.fromJson(x)));
String TipoHabitacionesToJson(List<TipoHabitacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TipoHabitacion> ListTipoHabitacionFromJson(List<dynamic> str) =>
    List<TipoHabitacion>.from(str.map((x) => TipoHabitacion.fromJson(x)));

TipoHabitacion TipoHabitacionFromJson(String str) =>
    TipoHabitacion.fromJson(json.decode(str));
String TipoHabitacionToJson(TipoHabitacion data) => json.encode(data.toJson());

class TipoHabitacion {
  int? idInt;
  String? id;
  String? codigo;
  int? orden;
  String? camas;
  String? descripcion;
  DateTime? createdAt;

  TipoHabitacion({
    this.idInt,
    this.id,
    this.codigo,
    this.orden,
    this.camas,
    this.descripcion,
    this.createdAt,
  });

  TipoHabitacion copyWith({
    int? idInt,
    String? id,
    String? codigo,
    int? orden,
    String? descripcion,
    String? camas,
    DateTime? createdAt,
  }) =>
      TipoHabitacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        orden: orden ?? this.orden,
        camas: camas ?? this.camas,
        descripcion: descripcion ?? this.descripcion,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TipoHabitacion.fromJson(Map<String, dynamic> json) => TipoHabitacion(
        idInt: json['idInt'],
        id: json['_id'],
        codigo: json['codigo'],
        orden: json['orden'],
        descripcion: json['descripcion'],
        camas: json['camas'],
        createdAt: DateValueFormat.fromJSON(json['createdAt']),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "idInt": idInt,
      "id": id,
      "codigo": codigo,
      "orden": orden,
      "descripcion": descripcion,
      "camas": camas,
      "createdAt": createdAt,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
