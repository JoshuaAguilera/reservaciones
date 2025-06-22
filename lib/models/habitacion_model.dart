import 'dart:convert';

import 'package:generador_formato/models/tarifa_x_dia_model.dart';

import 'resumen_habitacion_model.dart';
import 'tarifa_x_habitacion_model.dart';

List<TarifaXDia> tarifasXDiaFromJson(String str) =>
    List<TarifaXDia>.from(json.decode(str).map((x) => TarifaXDia.fromJson(x)));

String tarifasXDiaToJson(List<TarifaXDia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaXDia> listTarifasXDiaFromJson(List<dynamic> list) =>
    List<TarifaXDia>.from(list.map((x) => TarifaXDia.fromJson(x)));

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
  List<TarifaXHabitacion>? tarifaXHabitacion;
  List<ResumenHabitacion>? resumenes;

  Habitacion({
    this.idInt,
    this.id,
    this.cotizacion,
    this.cotizacionInt,
    this.checkIn,
    this.checkOut,
    this.createdAt,
    this.tarifaXHabitacion,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.count = 1,
    this.esCortesia = false,
    this.paxAdic,
    this.resumenes,
  });

  Habitacion CopyWith({
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
    List<TarifaXHabitacion>? tarifaXHabitacion,
    List<ResumenHabitacion>? resumenes,
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
        tarifaXHabitacion: tarifaXHabitacion ?? this.tarifaXHabitacion,
        count: count ?? this.count,
        esCortesia: esCortesia ?? this.esCortesia,
        resumenes: resumenes ?? this.resumenes,
        paxAdic: paxAdic ?? this.paxAdic,
      );

  Map<String, dynamic> toJson() {
    return {
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
  }

  factory Habitacion.fromJson(Map<String, dynamic> json) {
    return Habitacion(
      idInt: json['id_int'],
      id: json['id'],
      cotizacionInt: json['cotizacion_int'],
      cotizacion: json['cotizacion'],
      checkIn: json['fechaCheckIn'],
      checkOut: json['fechaCheckOut'],
      createdAt: json['fecha'],
      adultos: json['adultos'],
      menores0a6: json['menores0a6'],
      menores7a12: json['menores7a12'],
      tarifaXHabitacion: json['tarifaXDia'] != null
          ? json['tarifaXDia'] != '[]'
              ? listTarifasXDiaFromJson(json['tarifaXDia'])
              : List<TarifaXDia>.empty()
          : List<TarifaXDia>.empty(),
      totalRealVR: json['totalRealVR'],
      descuentoVR: json['descuentoVR'],
      totalVR: json['totalVR'],
      totalRealVPM: json['totalRealVPM'],
      descuentoVPM: json['descuentoVPM'],
      totalVPM: json['totalVPM'],
      count: json['count'],
      esCortesia: json['isFree'],
      tarifaGrupal: json['tarifaGrupal'] == null
          ? null
          : TarifaXDia.fromJson(json['tarifaGrupal']),
      useCashSeason: json['useCashSeason'],
    );
  }
}
