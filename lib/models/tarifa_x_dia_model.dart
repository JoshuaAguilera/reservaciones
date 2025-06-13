import 'dart:convert';
import 'dart:ui';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/models/temporada_model.dart';

import '../database/database.dart';
import '../res/helpers/desktop_colors.dart';

List<TarifaData> tarifasDataFromJson(String str) =>
    List<TarifaData>.from(json.decode(str).map((x) => TarifaData.fromJson(x)));

String tarifasDataToJson(List<TarifaData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaData> listTarifasDataFromJson(List<dynamic> list) =>
    List<TarifaData>.from(list.map((x) => TarifaData.fromJson(x)));

class TarifaXDia {
  int? id;
  String? code;
  String? folioRoom;
  String? categoria;
  String? subCode;
  String? tariffCode;
  double? descuentoProvisional;
  bool? modificado;
  int? dia;
  DateTime? fecha;
  String? nombreTariff;
  Color? color;
  TarifaData? tarifa;
  Temporada? temporadaSelect;
  PeriodoData? periodo;
  List<Temporada>? temporadas;
  List<TarifaData>? tarifas;
  List<TarifaData>? tarifasBase;
  List<TarifaData>? tarifasEfectivo;
  int numDays;

  TarifaXDia({
    this.id,
    this.color,
    this.folioRoom,
    this.tariffCode,
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
    this.tarifasBase,
    this.tarifasEfectivo,
    this.numDays = 1,
  });

  TarifaXDia copyWith({
    int? id,
    Color? color,
    String? folioRoom,
    String? tariffCode,
    DateTime? fecha,
    int? dia,
    String? code,
    String? subCode,
    double? descuentoProvisional,
    String? nombreTarif,
    PeriodoData? periodo,
    TarifaData? tarifa,
    Temporada? temporadaSelect,
    List<Temporada>? temporadas,
    bool? modificado,
    String? categoria,
    List<TarifaData>? tarifas,
    List<TarifaData>? tarifasBase,
    List<TarifaData>? tarifasEfectivo,
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
        tarifasBase: tarifasBase ?? this.tarifasBase,
        tarifasEfectivo: tarifasEfectivo ?? this.tarifasEfectivo,
        temporadaSelect: temporadaSelect ?? this.temporadaSelect,
        tariffCode: tariffCode ?? this.tariffCode,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'tariffCode': tariffCode,
      'color': colorToHex(color ?? DesktopColors.cerulean),
      'temporadas': temporadas,
      'tarifas': tarifas,
      'tarifasBase': tarifasBase,
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
      tariffCode: json['tariffCode'],
      color: colorFromHex(json['color']),
      temporadas: json['temporadas'] != null
          ? json['temporadas'] != '[]'
              ? listTemporadaFromJson(json['temporadas'])
              : List<Temporada>.empty()
          : List<Temporada>.empty(),
      tarifas: json['tarifas'] != null
          ? json['tarifas'] != '[]'
              ? listTarifasDataFromJson(json['tarifas'])
              : List<TarifaData>.empty()
          : List<TarifaData>.empty(),
      tarifasBase: json['tarifasBase'] != null
          ? json['tarifasBase'] != '[]'
              ? listTarifasDataFromJson(json['tarifasBase'])
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
          ? Temporada.fromJson(json['temporadaSelect'])
          : null,
    );
  }
}
