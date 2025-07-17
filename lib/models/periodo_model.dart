import 'dart:convert';

import '../res/helpers/date_helpers.dart';

List<Periodo> periodosFromJson(String str) =>
    List<Periodo>.from(json.decode(str).map((x) => Periodo.fromJson(x)));

String periodosToJson(List<Periodo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Periodo> listPeriodoFromJson(List<dynamic> list) =>
    List<Periodo>.from(list.map((x) => Periodo.fromJson(x)));

Periodo periodoFromJson(String str) => Periodo.fromJson(json.decode(str));
String periodoToJson(Periodo data) => json.encode(data.toJson());

List<String> candenasFromJson(List<dynamic> str) {
  return List<String>.from(str.map((x) => x.toString()));
}

class Periodo {
  int? idInt;
  String? id;
  DateTime? createdAt;
  DateTime? fechaInicial;
  DateTime? fechaFinal;
  List<String>? diasActivo;
  int? tarifaRackInt;
  String? tarifaRack;

  Periodo({
    this.idInt,
    this.id,
    this.createdAt,
    this.fechaInicial,
    this.fechaFinal,
    this.diasActivo,
    this.tarifaRackInt,
    this.tarifaRack,
  });

  Periodo copyWith({
    int? idInt,
    String? id,
    DateTime? createdAt,
    DateTime? fechaInicial,
    DateTime? fechaFinal,
    List<String>? diasActivo,
    int? tarifaRackInt,
    String? tarifaRack,
  }) =>
      Periodo(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        fechaInicial: fechaInicial ?? this.fechaInicial,
        fechaFinal: fechaFinal ?? this.fechaFinal,
        diasActivo: diasActivo ?? this.diasActivo,
        tarifaRack: tarifaRack ?? this.tarifaRack,
        tarifaRackInt: tarifaRackInt ?? this.tarifaRackInt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
        id: json['id'],
        idInt: json['idInt'],
        createdAt: DateValueFormat.fromJSON(json['createdAt']),
        fechaInicial: DateValueFormat.fromJSON(json['fechaInicial']),
        fechaFinal: DateValueFormat.fromJSON(json['fechaFinal']),
        diasActivo: json['diasActivo'] != null
            ? json['diasActivo'] != '[]'
                ? candenasFromJson(json['diasActivo'])
                : List<String>.empty()
            : List<String>.empty(),
        tarifaRack: json['tarifaRack'],
        tarifaRackInt: json['tarifaRackInt'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "id": id,
      "idInt": idInt,
      "fechaInicial": fechaInicial,
      "fechaFinal": fechaFinal,
      "diasActivo": diasActivo,
      "tarifaRack": tarifaRack,
      "tarifaRackInt": tarifaRackInt,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
