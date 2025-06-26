import 'dart:convert';

import 'resumen_operacion_model.dart';
import 'tarifa_x_habitacion_model.dart';

List<Habitacion> habitacionesFromJson(String str) =>
    List<Habitacion>.from(json.decode(str).map((x) => Habitacion.fromJson(x)));

String habitacionesToJson(List<Habitacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Habitacion> listHabitacionFromJson(List<dynamic> list) =>
    List<Habitacion>.from(list.map((x) => Habitacion.fromJson(x)));

Habitacion habitacionJson(String str) => Habitacion.fromJson(json.decode(str));
String habitacionToJson(Habitacion data) => json.encode(data.toJson());

class Habitacion {
  int? idInt;
  String? id;
  int? cotizacionInt;
  String? cotizacion;
  DateTime? createdAt;
  DateTime? checkIn;
  DateTime? checkOut;
  int? adultos;
  int? menores0a6;
  int? menores7a12;
  int? paxAdic;
  int count;
  bool esCortesia;
  List<TarifaXHabitacion>? tarifasXHabitacion;
  List<ResumenOperacion>? resumenes;

  Habitacion({
    this.idInt,
    this.id,
    this.cotizacion,
    this.cotizacionInt,
    this.checkIn,
    this.checkOut,
    this.createdAt,
    this.tarifasXHabitacion,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.count = 1,
    this.esCortesia = false,
    this.paxAdic,
    this.resumenes,
  });

  Habitacion copyWith({
    int? idInt,
    String? id,
    int? cotizacionInt,
    String? cotizacion,
    DateTime? createdAt,
    DateTime? fechaCheckIn,
    DateTime? fechaCheckOut,
    int? adultos,
    int? menores0a6,
    int? menores7a12,
    int? paxAdic,
    int? count,
    bool? esCortesia,
    List<TarifaXHabitacion>? tarifasXHabitacion,
    List<ResumenOperacion>? resumenes,
  }) =>
      Habitacion(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        cotizacionInt: cotizacionInt ?? this.cotizacionInt,
        cotizacion: cotizacion ?? this.cotizacion,
        createdAt: createdAt ?? this.createdAt,
        checkIn: fechaCheckIn ?? this.checkIn,
        checkOut: fechaCheckOut ?? this.checkOut,
        adultos: adultos ?? this.adultos,
        menores0a6: menores0a6 ?? this.menores0a6,
        menores7a12: menores7a12 ?? this.menores7a12,
        tarifasXHabitacion: tarifasXHabitacion ?? this.tarifasXHabitacion,
        count: count ?? this.count,
        esCortesia: esCortesia ?? this.esCortesia,
        resumenes: resumenes ?? this.resumenes,
        paxAdic: paxAdic ?? this.paxAdic,
      );

  Map<String, dynamic> toJson() {
    final data = {
      'id_int': idInt,
      'id': id,
      'cotizacion_int': cotizacionInt,
      'cotizacion': cotizacion,
      'check_in': checkIn,
      'check_out': checkOut,
      'adultos': adultos,
      'menores0a6': menores0a6,
      'menores7a12': menores7a12,
      'pax_adic': paxAdic,
      'count': count,
      'es_cortesia': esCortesia,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory Habitacion.fromJson(Map<String, dynamic> json) {
    return Habitacion(
      idInt: json['id_int'],
      id: json['id'],
      cotizacionInt: json['cotizacion_int'],
      cotizacion: json['cotizacion'],
      checkIn:
          json['check_in'] == null ? null : DateTime.tryParse(json['check_in']),
      checkOut: json['check_out'] == null
          ? null
          : DateTime.tryParse(json['check_out']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at']),
      adultos: json['adultos'],
      menores0a6: json['menores0a6'],
      menores7a12: json['menores7a12'],
      paxAdic: json['pax_adic'],
      count: json['count'],
      esCortesia: json['isFree'],
      tarifasXHabitacion: json['tarifas_x_habitacion'] != null
          ? json['tarifas_x_habitacion'] != '[]'
              ? listTarifaXHabitacionsFromJson(json['tarifas_x_habitacion'])
              : List<TarifaXHabitacion>.empty()
          : List<TarifaXHabitacion>.empty(),
      resumenes: json['resumenes'] != null
          ? json['resumenes'] != '[]'
              ? listResumenHabitacionFromJson(json['resumenes'])
              : List<ResumenOperacion>.empty()
          : List<ResumenOperacion>.empty(),
    );
  }
}
