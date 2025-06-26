import 'dart:convert';

import 'categoria_model.dart';

List<ResumenOperacion> resumenHabitacionesFromJson(String str) =>
    List<ResumenOperacion>.from(
        json.decode(str).map((x) => ResumenOperacion.fromJson(x)));
String resumenHabitacionesToJson(List<ResumenOperacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<ResumenOperacion> listResumenHabitacionFromJson(List<dynamic> str) =>
    List<ResumenOperacion>.from(str.map((x) => ResumenOperacion.fromJson(x)));

ResumenOperacion resumenHabitacionJson(String str) =>
    ResumenOperacion.fromJson(json.decode(str));
String resumenHabitacionToJson(ResumenOperacion data) =>
    json.encode(data.toJson());

class ResumenOperacion {
  int? idInt;
  String? id;
  double? subtotal;
  double? descuento;
  double? impuestos;
  double? total;
  Categoria? categoria;

  ResumenOperacion({
    this.idInt,
    this.id,
    this.subtotal,
    this.descuento,
    this.impuestos,
    this.total,
    this.categoria,
  });

  ResumenOperacion copyWith({
    int? idInt,
    String? id,
    double? subtotal,
    double? descuento,
    double? impuestos,
    double? total,
    Categoria? categoria,
  }) =>
      ResumenOperacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        subtotal: subtotal ?? this.subtotal,
        descuento: descuento ?? this.descuento,
        impuestos: impuestos ?? this.descuento,
        categoria: categoria?.copyWith() ?? this.categoria?.copyWith(),
        total: total ?? this.total,
      );

  factory ResumenOperacion.fromJson(Map<String, dynamic> json) =>
      ResumenOperacion(
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
