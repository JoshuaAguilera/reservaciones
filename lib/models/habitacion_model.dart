import 'dart:convert';

import '../res/helpers/date_helpers.dart';
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
        tarifasXHabitacion: (tarifasXHabitacion ?? this.tarifasXHabitacion)
            ?.map((e) => e.copyWith())
            .toList(),
        count: count ?? this.count,
        esCortesia: esCortesia ?? this.esCortesia,
        resumenes:
            (resumenes ?? this.resumenes)?.map((e) => e.copyWith()).toList(),
        paxAdic: paxAdic ?? this.paxAdic,
      );

  Map<String, dynamic> toJson() {
    final data = {
      'idInt': idInt,
      'id': id,
      'cotizacionInt': cotizacionInt,
      'cotizacion': cotizacion,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'adultos': adultos,
      'menores0a6': menores0a6,
      'menores7a12': menores7a12,
      'paxAdic': paxAdic,
      'count': count,
      'esCortesia': esCortesia,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory Habitacion.fromJson(Map<String, dynamic> json) {
    return Habitacion(
      idInt: json['idInt'],
      id: json['id'],
      cotizacionInt: json['cotizacionInt'],
      cotizacion: json['cotizacion'],
      checkIn: DateValueFormat.fromJSON(json['checkIn']),
      checkOut: DateValueFormat.fromJSON(json['checkOut']),
      createdAt: DateValueFormat.fromJSON(json['createdAt']),
      adultos: json['adultos'],
      menores0a6: json['menores0a6'],
      menores7a12: json['menores7a12'],
      paxAdic: json['paxAdic'],
      count: json['count'],
      esCortesia: json['isFree'],
      tarifasXHabitacion: json['tarifasXHabitacion'] != null
          ? json['tarifasXHabitacion'] != '[]'
              ? listTarifaXHabitacionsFromJson(json['tarifasXHabitacion'])
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
