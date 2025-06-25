import 'dart:convert';

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
  String? orden;
  String? descripcion;

  TipoHabitacion({
    this.idInt,
    this.id,
    this.codigo,
    this.orden,
    this.descripcion,
  });

  TipoHabitacion copyWith({
    int? idInt,
    String? id,
    String? codigo,
    String? orden,
    String? descripcion,
  }) =>
      TipoHabitacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        orden: orden ?? this.orden,
        descripcion: descripcion ?? this.descripcion,
      );

  factory TipoHabitacion.fromJson(Map<String, dynamic> json) => TipoHabitacion(
        idInt: json['id_int'],
        id: json['_id'],
        codigo: json['codigo'],
        orden: json['orden'],
        descripcion: json['descripcion'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "codigo": codigo,
      "orden": orden,
      "descripcion": descripcion,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
