import 'dart:convert';
import '../res/helpers/date_helpers.dart';
import 'tarifa_model.dart';

List<Temporada> temporadasFromJson(String str) =>
    List<Temporada>.from(json.decode(str).map((x) => Temporada.fromJson(x)));

String temporadasToJson(List<Temporada> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Temporada> listTemporadaFromJson(List<dynamic> list) =>
    List<Temporada>.from(list.map((x) => Temporada.fromJson(x)));

Temporada temporadaFromJson(String str) => Temporada.fromJson(json.decode(str));
String temporadaToJson(Temporada data) => json.encode(data.toJson());

class Temporada {
  int? idInt;
  String? id;
  String? tipo;
  String? nombre;
  DateTime? createdAt;
  int? estanciaMinima;
  double? descuento;
  double? ocupMin;
  double? ocupMax;
  List<Tarifa>? tarifas;
  bool? editable;
  bool? useTariff;

  Temporada({
    this.idInt,
    this.id,
    this.tipo,
    this.nombre,
    this.createdAt,
    this.estanciaMinima,
    this.descuento,
    this.tarifas,
    this.ocupMax,
    this.ocupMin,
    this.editable = true,
    this.useTariff = false,
  });

  Temporada copyWith({
    int? idInt,
    String? id,
    String? estatus,
    String? nombre,
    DateTime? createdAt,
    int? estanciaMinima,
    double? descuento,
    double? ocupMin,
    double? ocupMax,
    List<Tarifa>? tarifas,
    bool? editable,
    bool? forGroup,
    bool? forCash,
    bool? useTariff,
  }) =>
      Temporada(
        idInt: idInt ?? this.idInt,
        id: id ?? this.id,
        tipo: estatus ?? this.tipo,
        nombre: nombre ?? this.nombre,
        createdAt: createdAt ?? this.createdAt,
        estanciaMinima: estanciaMinima ?? this.estanciaMinima,
        descuento: descuento ?? this.descuento,
        tarifas: tarifas ?? this.tarifas,
        editable: editable ?? this.editable,
        useTariff: useTariff ?? this.useTariff,
        ocupMax: ocupMax ?? this.ocupMax,
        ocupMin: ocupMin ?? this.ocupMin,
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'idInt': idInt,
      'id': id,
      'tipo': tipo,
      'nombre': nombre,
      'createdAt': createdAt,
      'estanciaMinima': estanciaMinima,
      'descuento': descuento,
      'ocupMin': ocupMin,
      'ocupMax': ocupMax,
      'tarifas': tarifas,
    };

    // Remueve todas las claves con valor null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  factory Temporada.fromJson(Map<String, dynamic> json) {
    return Temporada(
      idInt: json['idInt'],
      id: json['id'],
      tarifas: json['tarifas'] != null
          ? json['tarifas'] != '[]'
              ? listTarifasFromJson(json['tarifas'])
              : List<Tarifa>.empty()
          : List<Tarifa>.empty(),
      createdAt: DateValueFormat.fromJSON(json['createdAt']),
      nombre: json['nombre'],
      editable: json['editable'],
      estanciaMinima: json['estanciaMinima'],
      descuento: json['porcentajePromocion'],
      useTariff: json['useTariff'],
      ocupMax: json['ocupMax'],
      ocupMin: json['ocupMin'],
      tipo: json['tipo'],
    );
  }
}
