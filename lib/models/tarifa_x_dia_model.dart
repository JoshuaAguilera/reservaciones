import 'dart:ui';

import '../database/database.dart';

class TarifaXDia {
  int? id;
  String? code;
  int? dia;
  DateTime? fecha;
  String? nombreTarif;
  Color? color;
  TarifaData? tarifa;
  TemporadaData? temporadaSelect;
  PeriodoData? periodo;
  List<TemporadaData>? temporadas;
  // int numDays;

  TarifaXDia({
    this.id,
    this.color,
    this.fecha,
    this.dia,
    this.code,
    this.nombreTarif,
    this.periodo,
    this.tarifa,
    this.temporadaSelect,
    this.temporadas,
    // this.numDays = 1,
  });
}
