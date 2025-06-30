import 'dart:convert';

import 'tarifa_x_dia_model.dart';

List<TarifaXHabitacion> tarifaXHabitacionXHabitacionsFromJson(String str) =>
    List<TarifaXHabitacion>.from(
        json.decode(str).map((x) => TarifaXHabitacion.fromJson(x)));

String tarifaXHabitacionsToJson(List<TarifaXHabitacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaXHabitacion> listTarifaXHabitacionsFromJson(List<dynamic> list) =>
    List<TarifaXHabitacion>.from(
        list.map((x) => TarifaXHabitacion.fromJson(x)));

class TarifaXHabitacion {
  int? idInt;
  String? id;
  String? subcode;
  int? habitacionInt;
  String? habitacion;
  TarifaXDia? tarifaXDia;
  int? dia;
  DateTime? fecha;
  bool? esGrupal;
  int numDays;

  TarifaXHabitacion({
    this.id,
    this.idInt,
    this.subcode,
    this.habitacionInt,
    this.habitacion,
    this.tarifaXDia,
    this.dia,
    this.fecha,
    this.esGrupal,
    this.numDays = 1,
  });

  TarifaXHabitacion copyWith({
    int? idInt,
    String? id,
    String? subcode,
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
        subcode: subcode,
        habitacion: habitacion ?? this.habitacion,
        habitacionInt: habitacionInt ?? this.habitacionInt,
        tarifaXDia: tarifaXDia ?? this.tarifaXDia,
        dia: dia ?? this.dia,
        fecha: fecha ?? this.fecha,
        esGrupal: esGrupal ?? this.esGrupal,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id_int': idInt,
      'id': id,
      'subcode': subcode,
      'habitacion_int': habitacionInt,
      'habitacion': habitacion,
      'tarifa_x_dia_int': tarifaXDia?.idInt,
      'tarifa_x_dia': tarifaXDia?.id,
      'dia': dia,
      'fecha': fecha,
      'es_grupal': esGrupal,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory TarifaXHabitacion.fromJson(Map<String, dynamic> json) {
    return TarifaXHabitacion(
      idInt: json['id_int'],
      id: json['id'],
      subcode: json['subcode'],
      habitacionInt: json['habitacion_int'],
      habitacion: json['habitacion'],
      tarifaXDia: json['tarifa_x_dia'],
      dia: json['dia'],
      fecha: json['fecha'] ?? DateTime.now().toString(),
      esGrupal: json['es_grupal'],
    );
  }
}
