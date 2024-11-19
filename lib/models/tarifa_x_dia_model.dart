import 'dart:convert';
import 'dart:ui';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../database/database.dart';
import '../utils/helpers/web_colors.dart';

/*
List<Categoria> CategoriasFromJson(String str) =>
    List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));
String CategoriasToJson(List<Categoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Categoria> ListCategoriaFromJson(List<dynamic> str) =>
    List<Categoria>.from(str.map((x) => Categoria.fromJson(x)));

    List<DireccionCliente> ListClientesDireccionesFromJson(List<dynamic> str) =>
    List<DireccionCliente>.from(str.map((x) => DireccionCliente.fromJson(x)));


Categoria CategoriaFromJson(String str) => Categoria.fromJson(json.decode(str));
String CategoriaToJson(Categoria data) => json.encode(data.toJson());
*/

List<TemporadaData> temporadasFromJson(String str) => List<TemporadaData>.from(
    json.decode(str).map((x) => TemporadaData.fromJson(x)));

String temporadasToJson(List<TemporadaData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TemporadaData> listTemporadaFromJson(List<dynamic> list) =>
    List<TemporadaData>.from(list.map((x) => TemporadaData.fromJson(x)));

List<TarifaData> tarifasFromJson(String str) =>
    List<TarifaData>.from(json.decode(str).map((x) => TarifaData.fromJson(x)));

String tarifasToJson(List<TarifaData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaData> listTarifasFromJson(List<dynamic> list) =>
    List<TarifaData>.from(list.map((x) => TarifaData.fromJson(x)));

class TarifaXDia {
  int? id;
  String? code;
  String? folioRoom;
  String? categoria;
  String? subCode;
  double? descuentoProvisional;
  bool? modificado;
  int? dia;
  DateTime? fecha;
  String? nombreTariff;
  Color? color;
  TarifaData? tarifa;
  TemporadaData? temporadaSelect;
  PeriodoData? periodo;
  List<TemporadaData>? temporadas;
  List<TarifaData>? tarifas;
  int numDays;

  TarifaXDia({
    this.id,
    this.color,
    this.folioRoom,
    this.fecha,
    this.dia,
    this.code,
    this.subCode,
    this.descuentoProvisional,
    this.nombreTariff,
    this.periodo,
    this.tarifa,
    this.temporadaSelect,
    this.temporadas,
    this.modificado = false,
    this.categoria,
    this.tarifas,
    this.numDays = 1,
  });

  TarifaXDia copyWith({
    int? id,
    Color? color,
    String? folioRoom,
    DateTime? fecha,
    int? dia,
    String? code,
    String? subCode,
    double? descuentoProvisional,
    String? nombreTarif,
    PeriodoData? periodo,
    TarifaData? tarifa,
    TemporadaData? temporadaSelect,
    List<TemporadaData>? temporadas,
    bool? modificado,
    String? categoria,
    List<TarifaData>? tarifas,
    int? numDays,
  }) =>
      TarifaXDia(
        id: id ?? this.id,
        code: code ?? this.code,
        folioRoom: folioRoom ?? this.folioRoom,
        color: color ?? this.color,
        temporadas: temporadas ?? this.temporadas,
        tarifas: tarifas ?? this.tarifas,
        numDays: numDays ?? this.numDays,
        categoria: categoria ?? this.categoria,
        descuentoProvisional: descuentoProvisional ?? this.descuentoProvisional,
        dia: dia ?? this.dia,
        fecha: fecha ?? this.fecha,
        modificado: modificado ?? this.modificado,
        nombreTariff: nombreTarif ?? this.nombreTariff,
        periodo: periodo ?? this.periodo,
        subCode: subCode ?? this.subCode,
        tarifa: tarifa ?? this.tarifa,
        temporadaSelect: temporadaSelect ?? this.temporadaSelect,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'color': colorToHex(color ?? DesktopColors.cerulean),
      'temporadas': temporadas,
      'tarifas': tarifas,
      'numDays': numDays,
      'categoria': categoria,
      'descuentoProvisional': descuentoProvisional,
      'dia': dia,
      'fecha': fecha != null ? fecha!.toIso8601String() : '',
      'modificado': modificado,
      'nombreTarif': nombreTariff,
      'periodo': periodo,
      'subCode': subCode,
      'tarifa': tarifa,
      'temporadaSelect': temporadaSelect,
    };
  }

  factory TarifaXDia.fromJson(Map<String, dynamic> json) {
    return TarifaXDia(
      id: json['id'],
      code: json['code'],
      color: colorFromHex(json['color']),
      temporadas: json['temporadas'] != null
          ? json['temporadas'] != '[]'
              ? listTemporadaFromJson(json['temporadas'])
              : List<TemporadaData>.empty()
          : List<TemporadaData>.empty(),
      tarifas: json['tarifas'] != null
          ? json['tarifas'] != '[]'
              ? listTarifasFromJson(json['tarifas'])
              : List<TarifaData>.empty()
          : List<TarifaData>.empty(),
      numDays: json['numDays'],
      categoria: json['categoria'],
      descuentoProvisional: json['descuentoProvisional'],
      dia: json['dia'],
      fecha: DateTime.parse(json['fecha'] ?? DateTime.now().toString()),
      modificado: json['modificado'],
      nombreTariff: json['nombreTarif'],
      periodo: json['periodo'] != null
          ? PeriodoData.fromJson(json['periodo'])
          : null,
      subCode: json['subCode'],
      tarifa:
          json['tarifa'] != null ? TarifaData.fromJson(json['tarifa']) : null,
      temporadaSelect: json['temporadaSelect'] != null
          ? TemporadaData.fromJson(json['temporadaSelect'])
          : null,
    );
  }
}
