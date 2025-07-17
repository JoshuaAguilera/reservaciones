import 'dart:convert';

import '../res/helpers/date_helpers.dart';
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
      'idInt': idInt,
      'id': id,
      'subcode': subcode,
      'habitacionInt': habitacionInt,
      'habitacion': habitacion,
      'tarifaXDiaInt': tarifaXDia?.idInt,
      'tarifaXDia': tarifaXDia?.id,
      'dia': dia,
      'fecha': fecha,
      'esGrupal': esGrupal,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory TarifaXHabitacion.fromJson(Map<String, dynamic> json) {
    return TarifaXHabitacion(
      idInt: json['idInt'],
      id: json['id'],
      subcode: json['subcode'],
      habitacionInt: json['habitacionInt'],
      habitacion: json['habitacion'],
      tarifaXDia: json['tarifaXDia'],
      dia: json['dia'],
      fecha: DateValueFormat.fromJSON(json['fecha']),
      esGrupal: json['esGrupal'],
    );
  }
}
