import 'dart:convert';

import 'package:generador_formato/models/tarifa_x_dia_model.dart';

List<TarifaXDia> tarifasXDiaFromJson(String str) =>
    List<TarifaXDia>.from(json.decode(str).map((x) => TarifaXDia.fromJson(x)));

String tarifasXDiaToJson(List<TarifaXDia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TarifaXDia> listTarifasXDiaFromJson(List<dynamic> list) =>
    List<TarifaXDia>.from(list.map((x) => TarifaXDia.fromJson(x)));

class Habitacion {
  int? id;
  String? folioHabitacion;
  String? categoria;
  String? fechaCheckIn;
  String? fechaCheckOut;
  String? fecha;
  int? adultos;
  int? menores0a6;
  int? menores7a12;
  List<TarifaXDia>? tarifaXDia;
  double? totalReal;
  double? descuento;
  double? total;
  int count;
  bool isFree;

  Habitacion({
    this.id,
    this.categoria,
    this.fechaCheckIn,
    this.fechaCheckOut,
    this.fecha,
    this.folioHabitacion,
    this.tarifaXDia,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.totalReal,
    this.descuento,
    this.total,
    this.count = 1,
    this.isFree = false,
  });

  Habitacion CopyWith({
    int? id,
    String? folioHabitacion,
    String? categoria,
    String? fechaCheckIn,
    String? fechaCheckOut,
    String? fecha,
    int? adultos,
    int? menores0a6,
    int? menores7a12,
    List<TarifaXDia>? tarifaXDia,
    double? totalReal,
    double? descuento,
    double? total,
    int? count,
    bool? isFree,
  }) =>
      Habitacion(
        id: id ?? this.id,
        folioHabitacion: folioHabitacion ?? this.folioHabitacion,
        categoria: categoria ?? this.categoria,
        fechaCheckIn: fechaCheckIn ?? this.fechaCheckIn,
        fechaCheckOut: fechaCheckOut ?? this.fechaCheckOut,
        fecha: fecha ?? this.fecha,
        adultos: adultos ?? this.adultos,
        menores0a6: menores0a6 ?? this.menores0a6,
        menores7a12: menores7a12 ?? this.menores7a12,
        tarifaXDia: tarifaXDia ?? this.tarifaXDia,
        totalReal: totalReal ?? this.totalReal,
        descuento: descuento ?? this.descuento,
        total: total ?? this.total,
        count: count ?? this.count,
        isFree: isFree ?? this.isFree,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'folioHabitacion': folioHabitacion,
      'categoria': categoria,
      'fechaCheckIn': fechaCheckIn,
      'fechaCheckOut': fechaCheckOut,
      'fecha': fecha,
      'adultos': adultos,
      'menores0a6': menores0a6,
      'menores7a12': menores7a12,
      'tarifaXDia': tarifaXDia,
      'totalReal': totalReal,
      'descuento': descuento,
      'total': total,
      'count': count,
      'isFree': isFree,
    };
  }

  factory Habitacion.fromJson(Map<String, dynamic> json) {
    return Habitacion(
      id: json['id'],
      folioHabitacion: json['folioHabitacion'],
      categoria: json['categoria'],
      fechaCheckIn: json['fechaCheckIn'],
      fechaCheckOut: json['fechaCheckOut'],
      fecha: json['fecha'],
      adultos: json['adultos'],
      menores0a6: json['menores0a6'],
      menores7a12: json['menores7a12'],
      tarifaXDia: json['tarifaXDia'],
      totalReal: json['totalReal'],
      descuento: json['descuento'],
      total: json['total'],
      count: json['count'],
      isFree: json['isFree'],
    );
  }
}
