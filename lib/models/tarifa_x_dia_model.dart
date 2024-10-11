import 'dart:ui';

import '../database/database.dart';

class TarifaXDia {
  int? id;
  String? code;
  String? categoria;
  String? subCode;
  double? descuentoProvisional;
  bool? modificado;
  int? dia;
  DateTime? fecha;
  String? nombreTarif;
  Color? color;
  TarifaData? tarifa;
  TemporadaData? temporadaSelect;
  PeriodoData? periodo;
  List<TemporadaData>? temporadas;
  List<TarifaData>? tarifas;
  int numDays;
  // int numDays;

  TarifaXDia({
    this.id,
    this.color,
    this.fecha,
    this.dia,
    this.code,
    this.subCode,
    this.descuentoProvisional,
    this.nombreTarif,
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
        color: color ?? this.color,
        temporadas: temporadas ?? this.temporadas,
        tarifas: tarifas ?? this.tarifas,
        numDays: numDays ?? this.numDays,
        categoria: categoria ?? this.categoria,
        descuentoProvisional: descuentoProvisional ?? this.descuentoProvisional,
        dia: dia ?? this.dia,
        fecha: fecha ?? this.fecha,
        modificado: modificado ?? this.modificado,
        nombreTarif: nombreTarif ?? this.nombreTarif,
        periodo: periodo ?? this.periodo,
        subCode: subCode ?? this.subCode,
        tarifa: tarifa ?? this.tarifa,
        temporadaSelect: temporadaSelect ?? this.temporadaSelect,
      );
}
