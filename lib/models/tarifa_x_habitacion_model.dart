import 'dart:convert';

import 'tarifa_x_dia_model.dart';

List<TarifaXHabitacion> TarifaXHabitacionXHabitacionsFromJson(String str) =>
    List<TarifaXHabitacion>.from(
        json.decode(str).map((x) => TarifaXHabitacion.fromJson(x)));

String TarifaXHabitacionsToJson(List<TarifaXHabitacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaXHabitacion> listTarifaXHabitacionsFromJson(List<dynamic> list) =>
    List<TarifaXHabitacion>.from(
        list.map((x) => TarifaXHabitacion.fromJson(x)));

class TarifaXHabitacion {
  int? idInt;
  String? id;
  int? habitacionInt;
  String? habitacion;
  TarifaXDia? tarifaXDia;
  int? dia;
  DateTime? fecha;
  bool? esGrupal;

  TarifaXHabitacion({
    this.id,
    this.idInt,
    this.habitacionInt,
    this.habitacion,
    this.tarifaXDia,
    this.dia,
    this.fecha,
    this.esGrupal,
  });

  TarifaXHabitacion copyWith({
    int? idInt,
    String? id,
    int? habitacionInt,
    String? habitacion,
    TarifaXDia? tarifaXDia,
    int? dia,
    DateTime? fecha,
    bool? esGrupal,
  }) =>
      TarifaXHabitacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        habitacion: habitacion ?? this.habitacion,
        habitacionInt: habitacionInt ?? this.habitacionInt,
        tarifaXDia: tarifaXDia ?? this.tarifaXDia,
        dia: dia ?? this.dia,
        fecha: fecha ?? this.fecha,
        esGrupal: esGrupal ?? this.esGrupal,
      );

  Map<String, dynamic> toJson() {
    return {
      'id_int': idInt,
      'id': id,
      'habitacion_int': habitacionInt,
      'habitacion': habitacion,
      'tarifa_x_dia_int': tarifaXDia?.idInt,
      'tarifa_x_dia': tarifaXDia?.id,
      'dia': dia,
      'fecha': fecha,
      'es_grupal': esGrupal,
    };
  }

  factory TarifaXHabitacion.fromJson(Map<String, dynamic> json) {
    return TarifaXHabitacion(
      idInt: json['id_int'],
      id: json['id'],
      habitacionInt: json['habitacion_int'],
      habitacion: json['habitacion'],
      tarifaXDia: json['tarifa_x_dia'],
      dia: json['dia'],
      fecha: json['fecha'] ?? DateTime.now().toString(),
      esGrupal: json['es_grupal'],
    );
  }
}
