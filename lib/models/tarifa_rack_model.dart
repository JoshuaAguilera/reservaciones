import 'dart:convert';

import 'package:flutter/material.dart';

import '../res/helpers/colors_helpers.dart';
import 'usuario_model.dart';

List<TarifaRack> tarifaRacksFromJson(String str) =>
    List<TarifaRack>.from(json.decode(str).map((x) => TarifaRack.fromJson(x)));
String tarifaRacksToJson(List<TarifaRack> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaRack> listTarifaRackFromJson(List<dynamic> str) =>
    List<TarifaRack>.from(str.map((x) => TarifaRack.fromJson(x)));

TarifaRack tarifaRackFromJson(String str) =>
    TarifaRack.fromJson(json.decode(str));
String tarifaRackToJson(TarifaRack data) => json.encode(data.toJson());

class TarifaRack {
  int? idInt;
  String? id;
  DateTime? createdAt;
  Color? color;
  String? nombre;
  Usuario? creadoPor;

  TarifaRack({
    this.idInt,
    this.id,
    this.createdAt,
    this.color,
    this.nombre,
    this.creadoPor,
  });

  TarifaRack copyWith({
    int? idInt,
    String? id,
    DateTime? createdAt,
    Color? color,
    String? nombre,
    Usuario? creadoPor,
  }) =>
      TarifaRack(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        color: color ?? this.color,
        nombre: nombre ?? this.nombre,
        creadoPor: creadoPor?.copyWith() ?? this.creadoPor?.copyWith(),
      );

  factory TarifaRack.fromJson(Map<String, dynamic> json) => TarifaRack(
        idInt: json['id_int'],
        id: json['id'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at']),
        nombre: json['nombre'],
        color: ColorsHelpers.colorFromJson(json['color']),
        creadoPor: json['creado_por'] != null
            ? Usuario.fromJson(json['creado_por'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id_int": idInt,
      "id": id,
      "nombre": nombre,
      "color": ColorsHelpers.colorToJson(color),
      "creado_por_int": creadoPor?.idInt,
      "creado_por": creadoPor?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
