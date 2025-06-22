import 'dart:convert';

import 'categoria_model.dart';

List<ResumenHabitacion> ResumenHabitacionesFromJson(String str) =>
    List<ResumenHabitacion>.from(
        json.decode(str).map((x) => ResumenHabitacion.fromJson(x)));
String ResumenHabitacionesToJson(List<ResumenHabitacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<ResumenHabitacion> ListResumenHabitacionFromJson(List<dynamic> str) =>
    List<ResumenHabitacion>.from(str.map((x) => ResumenHabitacion.fromJson(x)));

ResumenHabitacion ResumenHabitacionJson(String str) =>
    ResumenHabitacion.fromJson(json.decode(str));
String ResumenHabitacionToJson(ResumenHabitacion data) =>
    json.encode(data.toJson());

class ResumenHabitacion {
  int? idInt;
  String? id;
  double? subtotal;
  double? descuento;
  double? impuestos;
  double? total;
  Categoria? categoria;

  ResumenHabitacion({
    this.idInt,
    this.id,
    this.subtotal,
    this.descuento,
    this.impuestos,
    this.total,
    this.categoria,
  });

  factory ResumenHabitacion.fromJson(Map<String, dynamic> json) =>
      ResumenHabitacion(
        idInt: json['id_int'],
        id: json['id'],
        subtotal: json['subtotal'],
        descuento: json['descuento'],
        impuestos: json['impuestos'],
        total: json['total'],
        categoria: json['categoria'] != null
            ? Categoria.fromJson(
                json['categoria'],
              )
            : null,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "subtotal": subtotal,
      "descuento": descuento,
      "impuestos": impuestos,
      "total": total,
      "categoria_int": categoria?.idInt,
      "categoria": categoria?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
