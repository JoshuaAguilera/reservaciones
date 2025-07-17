import 'dart:convert';

import 'package:flutter/material.dart';

import '../res/helpers/colors_helpers.dart';
import '../res/helpers/date_helpers.dart';
import 'periodo_model.dart';
import 'registro_tarifa_bd_model.dart';
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
  List<RegistroTarifaBD>? registros;
  bool select;

  TarifaRack({
    this.idInt,
    this.id,
    this.createdAt,
    this.color,
    this.nombre,
    this.creadoPor,
    this.periodos,
    this.temporadas,
    this.registros,
    this.select = false,
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
    List<RegistroTarifaBD>? registros,
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
        registros:
            (registros ?? this.registros)?.map((e) => e.copyWith()).toList(),
      );

  factory TarifaRack.fromJson(Map<String, dynamic> json) {
    return TarifaRack(
      idInt: json['idInt'],
      id: json['id'],
      createdAt: DateValueFormat.fromJSON(json['createdAt']),
      nombre: json['nombre'],
      color: ColorsHelpers.colorFromJson(json['color']),
      creadoPor: json['creadoPor'] != null
          ? Usuario.fromJson(json['creadoPor'])
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
      registros: json['registrosTarifa'] != null
          ? json['registrosTarifa'] != '[]'
              ? listRegistroTarifaFromJson(json['registrosTarifa'])
              : List<RegistroTarifaBD>.empty()
          : List<RegistroTarifaBD>.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "idInt": idInt,
      "id": id,
      "nombre": nombre,
      "color": ColorsHelpers.colorToJson(color),
      "creadoPorInt": creadoPor?.idInt,
      "creadoPor": creadoPor?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
