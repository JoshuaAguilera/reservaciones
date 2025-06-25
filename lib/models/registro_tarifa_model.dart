import 'dart:ui';

import '../database/database.dart';
import 'temporada_model.dart';

class RegistroTarifa {
  int? id;
  bool? isSelected;
  String? code;
  String? codeSeason;
  String? codePeriod;
  String? nombre;
  Color? color;
  DateTime? fechaRegistro;
  int? userId;
  List<PeriodoTableData>? periodos;
  List<Temporada>? temporadas;
  List<TarifaTableData>? tarifas;
  int numDays;

  RegistroTarifa({
    this.id,
    this.isSelected = true,
    this.code,
    this.codePeriod,
    this.codeSeason,
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
    String? codeSeason,
    String? codePeriod,
    String? nombre,
    Color? color,
    DateTime? fechaRegistro,
    int? userId,
    List<PeriodoTableData>? periodos,
    List<Temporada>? temporadas,
    List<TarifaTableData>? tarifas,
    int? numDays,
  }) =>
      RegistroTarifa(
        id: id ?? this.id,
        isSelected: isSelected ?? this.isSelected,
        code: code ?? this.code,
        codeSeason: codeSeason ?? this.codeSeason,
        codePeriod: codePeriod ?? this.codePeriod,
        nombre: nombre ?? this.nombre,
        color: color ?? this.color,
        fechaRegistro: fechaRegistro ?? this.fechaRegistro,
        periodos: periodos?.map((e) => e.copyWith()).toList() ??
            this.periodos?.map((e) => e.copyWith()).toList(),
        temporadas: temporadas?.map((e) => e.copyWith()).toList() ??
            this.temporadas?.map((e) => e.copyWith()).toList(),
        tarifas: tarifas?.map((e) => e.copyWith()).toList() ??
            this.tarifas?.map((e) => e.copyWith()).toList(),
        userId: userId ?? this.userId,
        numDays: numDays ?? this.numDays,
      );
}
