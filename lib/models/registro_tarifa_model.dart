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
  int numDays;

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
    this.numDays = 1,
  });

  RegistroTarifa copyWith({
    int? id,
    bool? isSelected,
    String? code,
    String? nombre,
    Color? color,
    DateTime? fechaRegistro,
    int? userId,
    List<PeriodoData>? periodos,
    List<TemporadaData>? temporadas,
    List<TarifaData>? tarifas,
    int? numDays,
  }) =>
      RegistroTarifa(
        id: id ?? this.id,
        isSelected: isSelected ?? this.isSelected,
        code: code ?? this.code,
        nombre: nombre ?? this.nombre,
        color: color ?? this.color,
        fechaRegistro: fechaRegistro ?? this.fechaRegistro,
        periodos: periodos ?? this.periodos,
        temporadas: temporadas ?? this.temporadas,
        tarifas: tarifas ?? this.tarifas,
        userId: userId ?? this.userId,
        numDays: numDays ?? this.numDays,
      );
}
