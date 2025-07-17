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
  int? habitacionInt;
  String? habitacion;
  int? cotizacionInt;
  String? cotizacion;
  double? subtotal;
  double? descuento;
  double? impuestos;
  double? total;
  Categoria? categoria;

  ResumenOperacion({
    this.idInt,
    this.id,
    this.habitacionInt,
    this.habitacion,
    this.cotizacionInt,
    this.cotizacion,
    this.subtotal,
    this.descuento,
    this.impuestos,
    this.total,
    this.categoria,
  });

  ResumenOperacion copyWith({
    int? idInt,
    String? id,
    int? habitacionIdInt,
    String? habitacionId,
    int? cotizacionIdInt,
    String? cotizacionId,
    double? subtotal,
    double? descuento,
    double? impuestos,
    double? total,
    Categoria? categoria,
  }) =>
      ResumenOperacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        habitacionInt: habitacionIdInt ?? this.habitacionInt,
        habitacion: habitacionId ?? this.habitacion,
        cotizacionInt: cotizacionIdInt ?? this.cotizacionInt,
        cotizacion: cotizacionId ?? this.cotizacion,
        subtotal: subtotal ?? this.subtotal,
        descuento: descuento ?? this.descuento,
        impuestos: impuestos ?? this.descuento,
        categoria: categoria?.copyWith() ?? this.categoria?.copyWith(),
        total: total ?? this.total,
      );

  factory ResumenOperacion.fromJson(Map<String, dynamic> json) =>
      ResumenOperacion(
        idInt: json['idInt'],
        id: json['id'],
        habitacionInt: json['habitacionInt'],
        habitacion: json['habitacion'],
        cotizacionInt: json['cotizacionInt'],
        cotizacion: json['cotizacion'],
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
      "idInt": idInt,
      "id": id,
      "habitacionInt": habitacionInt,
      "habitacion": habitacion,
      "cotizacionInt": cotizacionInt,
      "cotizacion": cotizacion,
      "subtotal": subtotal,
      "descuento": descuento,
      "impuestos": impuestos,
      "total": total,
      "categoriaInt": categoria?.idInt,
      "categoria": categoria?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
