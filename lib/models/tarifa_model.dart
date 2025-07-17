import 'dart:convert';

import '../res/helpers/date_helpers.dart';
import 'categoria_model.dart';
import 'tarifa_base_model.dart';

List<Tarifa> tarifasFromJson(String str) =>
    List<Tarifa>.from(json.decode(str).map((x) => Tarifa.fromJson(x)));

String tarifasToJson(List<Tarifa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Tarifa> listTarifasFromJson(List<dynamic> list) =>
    List<Tarifa>.from(list.map((x) => Tarifa.fromJson(x)));

class Tarifa {
  int? idInt;
  String? id;
  DateTime? createdAt;
  Categoria? categoria;
  double? tarifaAdulto1a2;
  double? tarifaAdulto3;
  double? tarifaAdulto4;
  double? tarifaMenores7a12;
  double? tarifaMenores0a6;
  double? tarifaPaxAdicional;
  TarifaBase? tarifaBase;

  Tarifa({
    this.idInt,
    this.id,
    this.createdAt,
    this.categoria,
    this.tarifaAdulto1a2,
    this.tarifaAdulto3,
    this.tarifaAdulto4,
    this.tarifaMenores7a12,
    this.tarifaMenores0a6,
    this.tarifaPaxAdicional,
    this.tarifaBase,
  });

  Tarifa copyWith({
    int? idInt,
    String? id,
    DateTime? createdAt,
    String? code,
    Categoria? categoria,
    double? tarifaAdulto1a2,
    double? tarifaAdulto3,
    double? tarifaAdulto4,
    double? tarifaMenores7a12,
    double? tarifaMenores0a6,
    double? tarifaPaxAdicional,
    TarifaBase? tarifaBase,
  }) =>
      Tarifa(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        categoria: categoria ?? this.categoria,
        createdAt: createdAt ?? this.createdAt,
        tarifaAdulto1a2: tarifaAdulto1a2 ?? this.tarifaAdulto1a2,
        tarifaAdulto3: tarifaAdulto3 ?? this.tarifaAdulto3,
        tarifaAdulto4: tarifaAdulto4 ?? this.tarifaAdulto4,
        tarifaMenores7a12: tarifaMenores7a12 ?? this.tarifaMenores7a12,
        tarifaMenores0a6: tarifaMenores0a6 ?? this.tarifaMenores0a6,
        tarifaPaxAdicional: tarifaPaxAdicional ?? this.tarifaPaxAdicional,
        tarifaBase: tarifaBase?.copyWith() ?? this.tarifaBase?.copyWith(),
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'idInt': idInt,
      'id': id,
      'categoriaInt': categoria?.idInt,
      'categoria': categoria?.id,
      'tarifaAdulto1a2': tarifaAdulto1a2,
      'tarifaAdulto3': tarifaAdulto3,
      'tarifaAdulto4': tarifaAdulto4,
      'tarifaMenores7a12': tarifaMenores7a12,
      'tarifaMenores0a6': tarifaMenores0a6,
      'tarifaPaxAdicional': tarifaPaxAdicional,
      'tarifaBaseInt': tarifaBase?.idInt,
      'tarifaBase': tarifaBase?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory Tarifa.fromJson(Map<String, dynamic> json) {
    return Tarifa(
      id: json['id'],
      idInt: json['idInt'],
      categoria: json['categoria'],
      createdAt: DateValueFormat.fromJSON(json['createdAt']),
      tarifaAdulto1a2: json['tarifaAdulto1a2'],
      tarifaAdulto3: json['tarifaAdulto3'],
      tarifaAdulto4: json['tarifaAdulto4'],
      tarifaMenores7a12: json['tarifaMenores7a12'],
      tarifaMenores0a6: json['tarifaMenores0a6'],
      tarifaPaxAdicional: json['tarifaPaxAdicional'],
      tarifaBase: json['tarifaBase'] != null
          ? TarifaBase.fromJson(json['tarifaBase'])
          : null,
    );
  }
}
