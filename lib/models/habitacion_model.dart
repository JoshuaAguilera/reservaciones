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
  String? folioCotizacion;
  String? folioHabitacion;
  String? categoria;
  String? fechaCheckIn;
  String? fechaCheckOut;
  String? fecha;
  int? adultos;
  int? menores0a6;
  int? menores7a12;
  List<TarifaXDia>? tarifaXDia;
  double? totalRealVR;
  double? descuentoVR;
  double? totalVR;
  double? totalRealVPM;
  double? descuentoVPM;
  double? totalVPM;
  int count;
  bool isFree;
  TarifaXDia? tarifaGrupal;
  bool? useCashSeason;

  Habitacion({
    this.id,
    this.folioCotizacion,
    this.categoria,
    this.fechaCheckIn,
    this.fechaCheckOut,
    this.fecha,
    this.folioHabitacion,
    this.tarifaXDia,
    this.adultos,
    this.menores0a6,
    this.menores7a12,
    this.totalRealVR,
    this.descuentoVR,
    this.totalVR,
    this.totalRealVPM,
    this.totalVPM,
    this.descuentoVPM,
    this.count = 1,
    this.isFree = false,
    this.tarifaGrupal,
    this.useCashSeason,
  });

  Habitacion CopyWith({
    int? id,
    String? folioHabitacion,
    String? folioCotizacion,
    String? categoria,
    String? fechaCheckIn,
    String? fechaCheckOut,
    String? fecha,
    int? adultos,
    int? menores0a6,
    int? menores7a12,
    List<TarifaXDia>? tarifaXDia,
    double? totalRealVR,
    double? descuentoVR,
    double? totalVR,
    double? totalRealVPM,
    double? descuentoVPM,
    double? totalVPM,
    int? count,
    bool? isFree,
    TarifaXDia? tarifaGrupal,
    bool? useCashSeason,
  }) =>
      Habitacion(
        id: id ?? this.id,
        folioHabitacion: folioHabitacion ?? this.folioHabitacion,
        folioCotizacion: folioCotizacion ?? this.folioCotizacion,
        categoria: categoria ?? this.categoria,
        fechaCheckIn: fechaCheckIn ?? this.fechaCheckIn,
        fechaCheckOut: fechaCheckOut ?? this.fechaCheckOut,
        fecha: fecha ?? this.fecha,
        adultos: adultos ?? this.adultos,
        menores0a6: menores0a6 ?? this.menores0a6,
        menores7a12: menores7a12 ?? this.menores7a12,
        tarifaXDia: tarifaXDia ?? this.tarifaXDia,
        totalRealVR: totalRealVR ?? this.totalRealVR,
        descuentoVR: descuentoVR ?? this.descuentoVR,
        totalVR: totalVR ?? this.totalVR,
        totalRealVPM: totalRealVR ?? this.totalRealVPM,
        descuentoVPM: descuentoVR ?? this.descuentoVPM,
        totalVPM: totalVR ?? this.totalVPM,
        count: count ?? this.count,
        isFree: isFree ?? this.isFree,
        tarifaGrupal: tarifaGrupal ?? this.tarifaGrupal,
        useCashSeason: useCashSeason ?? this.useCashSeason,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'folioHabitacion': folioHabitacion,
      'folioCotizacion': folioCotizacion,
      'categoria': categoria,
      'fechaCheckIn': fechaCheckIn,
      'fechaCheckOut': fechaCheckOut,
      'fecha': fecha,
      'adultos': adultos,
      'menores0a6': menores0a6,
      'menores7a12': menores7a12,
      'tarifaXDia': tarifaXDia,
      'totalRealVR': totalRealVR,
      'descuentoVR': descuentoVR,
      'totalVR': totalVR,
      'totalRealVPM': totalRealVPM,
      'descuentoVPM': descuentoVPM,
      'totalVPM': totalVPM,
      'count': count,
      'isFree': isFree,
      'tarifaGrupal': tarifaGrupal,
      'useCashSeason': useCashSeason,
    };
  }

  factory Habitacion.fromJson(Map<String, dynamic> json) {
    return Habitacion(
      id: json['id'],
      folioHabitacion: json['folioHabitacion'],
      folioCotizacion: json['folioCotizacion'],
      categoria: json['categoria'],
      fechaCheckIn: json['fechaCheckIn'],
      fechaCheckOut: json['fechaCheckOut'],
      fecha: json['fecha'],
      adultos: json['adultos'],
      menores0a6: json['menores0a6'],
      menores7a12: json['menores7a12'],
      tarifaXDia: json['tarifaXDia'] != null
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
      isFree: json['isFree'],
      tarifaGrupal: json['tarifaGrupal'] == null
          ? null
          : TarifaXDia.fromJson(json['tarifaGrupal']),
      useCashSeason: json['useCashSeason'],
    );
  }
}
