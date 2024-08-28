import 'dart:ui';

import 'package:generador_formato/database/database.dart';

class RegistroTarifa {
  int? id;
  bool? isSelected;
  String? code;
  String? nombre;
  Color? color;
  DateTime? fechaRegistro;
  int? userId;
  List<PeriodoData>? periodos;
  List<TemporadaData>? temporadas;
  List<TarifaData>? tarifas;

  RegistroTarifa({
    this.id,
    this.isSelected = true,
    this.code,
    this.nombre,
    this.color,
    this.fechaRegistro,
    this.periodos,
    this.temporadas,
    this.tarifas,
    this.userId,
  });
}
