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
    // this.numDays = 1,
  });
}
