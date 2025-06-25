import 'dart:convert';

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
      'id_int': idInt,
      'id': id,
      'categoria_int': categoria?.idInt,
      'categoria': categoria?.id,
      'tarifa_adulto1a2': tarifaAdulto1a2,
      'tarifa_adulto3': tarifaAdulto3,
      'tarifa_adulto4': tarifaAdulto4,
      'tarifa_menores7a12': tarifaMenores7a12,
      'tarifa_menores0a6': tarifaMenores0a6,
      'tarifa_pax_adicional': tarifaPaxAdicional,
      'tarifa_base_int': tarifaBase?.idInt,
      'tarifa_base': tarifaBase?.id,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory Tarifa.fromJson(Map<String, dynamic> json) {
    return Tarifa(
      id: json['id'],
      idInt: json['id_int'],
      categoria: json['categoria'],
      createdAt: json['created_at'] ?? DateTime.now().toString(),
      tarifaAdulto1a2: json['tarifa_adulto1a2'],
      tarifaAdulto3: json['tarifa_adulto3'],
      tarifaAdulto4: json['tarifa_adulto4'],
      tarifaMenores7a12: json['tarifa_menores7a12'],
      tarifaMenores0a6: json['tarifa_menores0a6'],
      tarifaPaxAdicional: json['tarifa_pax_adicional'],
      tarifaBase: json['tarifa_base'] != null
          ? TarifaBase.fromJson(json['tarifa_base'])
          : null,
    );
  }
}
