import 'dart:convert';

import 'package:flutter/material.dart';

import '../res/helpers/colors_helpers.dart';
import 'periodo_model.dart';
import 'tarifa_model.dart';
import 'temporada_model.dart';
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
  List<Periodo>? periodos;
  List<Temporada>? temporadas;
  List<Tarifa>? tarifas;

  TarifaRack({
    this.idInt,
    this.id,
    this.createdAt,
    this.color,
    this.nombre,
    this.creadoPor,
    this.periodos,
    this.temporadas,
    this.tarifas,
  });

  TarifaRack copyWith({
    int? idInt,
    String? id,
    DateTime? createdAt,
    Color? color,
    String? nombre,
    Usuario? creadoPor,
    List<Periodo>? periodos,
    List<Temporada>? temporadas,
    List<Tarifa>? tarifas,
  }) =>
      TarifaRack(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        color: color ?? this.color,
        nombre: nombre ?? this.nombre,
        creadoPor: creadoPor?.copyWith() ?? this.creadoPor?.copyWith(),
        periodos:
            (periodos ?? this.periodos)?.map((e) => e.copyWith()).toList(),
        temporadas:
            (temporadas ?? this.temporadas)?.map((e) => e.copyWith()).toList(),
        tarifas: (tarifas ?? this.tarifas)?.map((e) => e.copyWith()).toList(),
      );

  factory TarifaRack.fromJson(Map<String, dynamic> json) {
    return TarifaRack(
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
      periodos: json['periodos'] != null
          ? json['periodos'] != '[]'
              ? listPeriodoFromJson(json['periodos'])
              : List<Periodo>.empty()
          : List<Periodo>.empty(),
      temporadas: json['temporadas'] != null
          ? json['temporadas'] != '[]'
              ? listTemporadaFromJson(json['temporadas'])
              : List<Temporada>.empty()
          : List<Temporada>.empty(),
      tarifas: json['tarifas'] != null
          ? json['tarifas'] != '[]'
              ? listTarifasFromJson(json['tarifas'])
              : List<Tarifa>.empty()
          : List<Tarifa>.empty(),
    );
  }

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
